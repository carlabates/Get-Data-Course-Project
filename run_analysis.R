library(data.table)

# **********
# To begin put all eight data files into one folder and set the working directory to that folder.
# Files include activity_labels, txt, features.txt, subject_test.txt, subject_train.txt, X_test.txt, X_train.txt, y_test.txt, y_train.txt
# The files are read into separate data frames and the data frames are named after the files names minus the .txt extension.
# **********

filelist <- list.files( , full.names=FALSE)

for(i in 1:length(filelist)){ 
  xDF <- read.table(filelist[i], stringsAsFactors=F)
  iX <- unlist(strsplit(filelist[i], ".", fixed=T))
  iX <- print(iX[1], quote=F)
  assign(iX, xDF)
}

# **********
# Three data frames for "test" and three for "train" are merged on "Row.names" and then the redundant columns are removed.
# The "test" and "train" data frames are then merged into one data frame (35)
#      and unnecessary objects are removed from the workspace (37)
# **********

cols <- c("subject", "activity", as.list(features$V2))

testDF <- merge(subject_test, y_test, by=0)
testDF <- merge(testDF, X_test, by=0)
testDF <- testDF[ , !(colnames(testDF) %in% c("Row.names"))]
colnames(testDF) <- cols

trainDF <- merge(subject_train, y_train, by=0)
trainDF <- merge(trainDF, X_train, by=0)
trainDF <- trainDF[ , !(colnames(trainDF) %in% c("Row.names"))]
colnames(trainDF) <- cols

dataDT <- rbind(testDF,trainDF)

rm(xDF, subject_test, X_test, y_test, subject_train, X_train, y_train, testDF, trainDF)

# **********
# The columns not related to measurements of the mean or standard deviation are removed.  
# Those columns containing the frequency of the mean were also removed.
# Finally (50-59), a new column is added to hold the more descriptive names of the activites rather than just numeric markers.
# **********

xCols <- grep(("mean|std"), cols, value=T)
xCols <- c("subject", "activity", grep("Freq", xCols, value=T, invert=T))
dataDT <- dataDT[ , colnames(dataDT) %in% xCols ]

activities <- c()

for (i in 1:nrow(dataDT)){
  for (j in activity_labels$V1){
    if(dataDT$activity[i] %in% c(activity_labels$V1[j])){
      x <- as.character(activity_labels$V2[j])
    }
  }
  activities <- c(activities,x)
}

dataDT$activity_labels <- activities

# **********
# The data frame is now ready for processing so it is made into a data.table and two keys are set:  subject and new
# ... the means are then found for each of the 30 subjects, for each of the 6 activities, for each of the 66 measurements.
# **********

dataDT <- data.table(dataDT)
setkey(dataDT, subject, activity_labels)
meanDT <- dataDT[ , lapply(.SD,mean), by=.(subject, activity_labels), .SDcols=3:68 ]




