#Getting and Cleaning Data Project ReadMe 

The contents of this repo are as follows:
-run_analysis.R -- the script which runs the project
-CodeBook.md -- describes the variables used in the script
-README.md -- describes how the script works

##Part 0: Commented out download and folder creation

I initially created the script so that it would download the file and create a unique directory within which to work once the script was launched. Given that the course instructions said to assume the file was already present, I commented these lines of code out, but they could easily be uncommented if you wanted to run the script without having first downloaded the file or created a directory.

##Part 1: Merge training and test sets to create one data set

The first step is to unzip the downloaded data file (in my script, named "SamsungData.zip").

Unzipping the file creates a subdirectory ./UCI HAR dataset. Since everything that happens involves files in this directory, I went ahead and set is as the working directory for the rest of the script.

There are three major types of data in the text files that make up the data: x values, which constitute the bulk of the data and contain numerous sensor data values; y values, which are a set of activity values, and subject values, which indicate the person whom these values are collected for. The data is split between a test group and a training group, and these need to be combined for our analysis.

Since the bulk of the data massaging that needs to take place is with the x values, the script reads those in first as xtrain and xtest data frames, then uses rbind to combine them into a combodata data frame. This completes the requirements for part 1.


##Part 2: Extract Mean and Standard Deviation values

The next part of the exercise requires the script to read a table called features.txt, which contains two columns: a feature ID and an associated feature name. For our exercise, we only want variables with either "mean" or "std" in their name, and so we use grep to create a vector that contains just those row numbers that meet that criteria. We then subset combodata into a new data frame, combodatasub1, using the list of row numbers to indicate which columns should be included in the subset.

This completes the requirements for Part 2.


##Part 3: Use descriptive activity names to name activities in the dataset.

Now we need to read in the y values - which contain only a single column, which we will label "activity." We do this for both the train and test data, the once again use rbind to put them together into a data frame called comboact.

NOTE: It is not required at this point by the project, but because we will need it later, I went ahead and had the script combine the subject training and test data as well (once again, using rbind). This doesn't affect the script, and was merely a convenience in similar coding. The data fram name is combosubject.

Once the comboact data frame is instantiated, the script replaces the numeric values in the comboact activity column with values grabbed from the supporting text files. 1 = WALKING, 4 = SITTING, and so forth. Once the script completes, the comboact data frame values are no longer numeric - they are the text-based equivalents.

This completes the requirements for Part 3. 


##Part 4: Appropriately label the data set with descriptive variable names.

For the first time you need to actually create a vector of the featurelist variables, subsetted by just the ones we used to create our combodatasubset1 data frame. Here, the script takes the featurelist dataset created earlier and creates a subset called featurelistsmall, which subsets the *rows* this time by the numbers we used earlier to subset the columns for combodatasubset1. This generates a dataframe that has the same number of rows as our combodatasubset1 data frame has columns.

Next we take the feature names out of that dataframe and push them into a vector (called varilong). Then we use gsub to remove the () and - characters from the labels. Finally, we use tolower to make all of the variables lower case. Once that is finished, we can now use cbind to add our subject data to the dataset, and then once again use cbind to add the polished-up comboact data to the dataset, which the script names "finaldata."

This meets all requirements for Part 4, but we're not finished yet...


##Part 5: Create a second, independent tidy data set with the variable average for each activity and subject.

To accomplish this task, I employed the aggregate function to aggregate our combodatasub1 data frame with the subject and activity variables of the finaldata data frame, and then calculate the mean. Once this is done, all that's left is to tidy up the column names for the subject and activity columns, and then write this data to a table in the working directory.

And that meets the requirements for Part 5, completing all requirements for the project.