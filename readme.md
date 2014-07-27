Getting and Cleaning Data Project
-------
-------


This is the peer assessed project of the [Coursera] course on [Getting and Cleaning Data]. The project folder contains the following files

* **readme.md** - the readme file that you are reading now
* **run_analysis.R** - the R source code 
* **Codebook.md** - the codebook file

To run the code, you will have to download the raw data file from [here] and unzip it locally. This will create a data directory named **UCI HAR Dataset** under your local dirctory. Then copy the **run_analysis.R** file to the data directory, open the **R** program and type the following commands on the R console

```sh
setwd('/path/to/data/dir')
source('run_analysis.R')
run_analysis()
```
where */path/to/data/dir* should be substituted with the complete path to the data directory mentioned above. 

For further information on the program and the data files, please check out  **Codebook.md**. 


[Coursera]: http://www.coursera.org
[Getting and Cleaning Data]: https://class.coursera.org/getdata-005
[here]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
