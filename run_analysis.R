# function for loading tables with specified column names
# directory - name of the directory, 'train' or 'test'
# columns - indices of columns to be included
# column.names - corresponding column names
load.tables<-function(directory, columns, column.names) {
	X<-read.table(sprintf('%s/X_%s.txt', directory, directory))
	subject<-read.table(sprintf('%s/subject_%s.txt', directory, directory))
	labels<-read.table(sprintf('%s/y_%s.txt', directory, directory))
	if (nrow(X)!=nrow(subject) | nrow(X)!=nrow(labels)) {
		stop('feature, subject and label files should contain same # of rows')
	}
	# select subset of columns
	X<-X[,columns]
	# update column names
	names(X)<-column.names
	names(subject)<-'subject'
	names(labels)<-'activity'
	# read activities
	activities<-read.table('activity_labels.txt')
	labels$activity<-sapply(labels$activity, function (x) activities$V2[x])
	# combine columns of attributes with corresponding subjects and labels
	cbind(cbind(X, subject), labels)
}

# main function for running analysis for the project
run_analysis<-function(datafilename="merged.csv", summaryfilename="summary.csv") {
	##################################################################################
	# create the first big clean data set merged from training and test sets
	##################################################################################
	message(sprintf('Create data file %s ...', datafilename))
	# get the list of features
	feats<-read.table('features.txt')
	feats<-feats$V2
	# extract indices of features containing mean and std
	# excluding those containing meanFreq
	columns<-setdiff(grep('.*-mean|-std.*', feats), grep('.*-meanFreq.*', feats))
	# extract column names
	column.names<-feats[columns]
	# convert column names to camel cases
	# i.e. -mean()/-std() to Mean/Std
	column.names<-sub('-mean\\(\\)(-|$)', 'Mean', column.names)
	column.names<-sub('-std\\(\\)(-|$)', 'Std', column.names)
	# load and process train data set
	train.df<-load.tables('train', columns, column.names) 
	# load and process test data set
	test.df<-load.tables('test', columns, column.names) 
	# merge train and test subsets
	merged.df<-rbind(train.df, test.df)
	rm('train.df', 'test.df')
	# save merged data set
	write.table(merged.df, file=datafilename, sep=",",row.names=F)

	#########################################################################
	# create the second clean data set taking the average of each variable 
	# for each activity and subject 
	#########################################################################
	message(sprintf('Create summary file %s ...', summaryfilename))
	column.names<-names(merged.df)	
	# get # of activities 
	activities<-levels(merged.df$activity)
	nacts<-length(activities)
	# get # of subjects
	nsubs<-max(merged.df$subject)
	# get # of attributes
	# note the last two columns are subject and activity
	nattrs<-length(column.names)-2		
	# create a data frame holding summary statistics broken down by different activity and subject groups
	#  it should contain same columns as the input data frame
	#   and nsubs*nacts rows corresponding to all combinations of activities and subjects
	summary.table<-data.frame(
		matrix(logical(nsubs*nacts*(nattrs+2)),nsubs*nacts, nattrs+2)
	)
	names(summary.table)<-column.names
	# populate summary statistics for each numeric attribute
	for (i in 1:nattrs) {
		summary.table[,i]<-as.vector(
			with(merged.df, 
				tapply(merged.df[,i],list(subject,activity), mean)
			)
		)
	}
	summary.table$activity<-rep(activities, nsubs)
	summary.table$subject<-kronecker(1:nsubs, rep(1, nacts))
	write.table(summary.table, file=summaryfilename, sep=",",row.names=F)
}
