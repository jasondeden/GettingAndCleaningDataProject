##create a separate directory for this script and set it as the working directory
##UNCOMMENT IF RUNNING SCRIPT WITHOUT HAVING FILE IN LOCAL DIRECTORY

#if (!file.exists("GCDProject")){
#  dir.create("GCDProject")
#}
#setwd("./GCDProject")

##download the data for the project

#fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileURL, dest="SamsungData.zip", method="curl")

##Unzip the data file

unzip("SamsungData.zip")

##Change to UCI HAR dataset directory

setwd("/UCI HAR dataset")


######1. MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET############


#read training and test data into tables and create a combined table

xtrain <- read.table("./train/X_train.txt", header=F)

xtest <- read.table("./test/X_test.txt", header=F)

combodata <- rbind(xtrain,xtest)


######2. EXTRACT ONLY THE MEASUREMENTS ON MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT#######


#read features data into table

featurelist <- read.table("features.txt", col.names=c("featID", "featName"))

#pull out featID values that contain either "std" or "mean" and store in a vector

featurelistsub <- grep("-mean|-std",featurelist$featName)

#subset combodata by this list of features

combodatasub1 <- combodata[,featurelistsub]


#####3. USE DESCRIPTIVE ACTIVITY NAMES TO NAME ACTIVITIES IN THE DATA SET#####

#read the activity data into a data table (same order as the data - first train, then test)

ytrain <- read.table("./train/y_train.txt", col.names="activity")

ytest <- read.table("./test/y_test.txt", col.names="activity")

comboact <- rbind(ytrain,ytest)

#for later use, we'll go ahead and create the subject combo as well (see step 5)

subtrain <- read.table("./train/subject_train.txt", col.names="subject")

subtest <- read.table("./test/subject_test.txt", col.names="subject")

combosubject <- rbind(subtrain,subtest)


#replace comboact activity number with activity name

comboact$activity <- as.character(comboact$activity)

comboact$activity[comboact$activity == "1"] <- "WALKING"
comboact$activity[comboact$activity == "2"] <- "WALKING_UPSTAIRS"
comboact$activity[comboact$activity == "3"] <- "WALKING_DOWNSTAIRS"
comboact$activity[comboact$activity == "4"] <- "SITTING"
comboact$activity[comboact$activity == "5"] <- "STANDING"
comboact$activity[comboact$activity == "6"] <- "LAYING"

##We will combine this with the data set at the end of step 4



#####4. Appropriately labels the data set with descriptive variable names.#####

#Create a subset of featurelist with just the desired feature names

featurelistsmall <- featurelist[featurelistsub,]

#Create a vector of long variable names from the feature list

varilong <- as.vector(featurelistsmall$featName)

#remove all () and - from names

varilong2 <- gsub("\\(\\)|-","",varilong)

#put all variable names in lower case

varilong3 <- tolower(varilong2)

#assign names to dataset variables

names(combodatasub1) <- varilong3

#add activity and subject labels to combodatasub1

almostfinaldata <- cbind(combosubject,combodatasub1)
finaldata <- cbind(comboact,almostfinaldata)


#####5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.#####

#aggregate combodatasub1 with finaldata subject and activity, take the mean

avgdata <- aggregate(combodatasub1,list(finaldata$subject,finaldata$activity),FUN=mean)

#label the first two columns in the avg'd data

names(avgdata)[1] <- "subject"
names(avgdata)[2] <- "activity"

#write file to the local directory

write.table(avgdata, file="avgdata.txt", row.name=F)