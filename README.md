# Get-Data-Course-Project

The reference for the data used in this project is "Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. *Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.* International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012"

Thirty volunteers were divided into two groups where 70% generated "training" data and 30% generated "test" data.  Each subject engaged in 6 activities and generated 561 variables of information. For more infomration on what the variables measure please see the referenced article. 

The dataset was downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R is also commented on for futher information.

After reading the data into R, for the purposes of this "Getting and Cleaning Data" assignment,the three data frames from the "training" and "testing" files were merged respectively and then merged together into one main data frame. At this point, the data was filtered for just those variables relating to either the "mean" or the "std"  (note: the "freq" variables related to some of the means were not included either) for a total of 66 variables per 6 activities for 30 subjects.  

The data frame was converted into a data table and the mean was run across all  observations for each of the 6 activities for each of the 30 subjects across all 66 variables.  This resulted in a tidy dataset of 180 observations (6 activities X 30 subjects) of 66 variables.  




