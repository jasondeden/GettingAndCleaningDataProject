Codebook for Getting and Cleaning Data Project

Note: "df"" = shorthand for "data frame""

Variable Name         Description

almostfinaldata       cbind of combodatasub1 and combosubject
avgdata               df used to aggregate combodatasub1 by subject and activity data

comboact              rbind of ytrain and ytest
combodata             rbind of xtrain and xtest
combodatasub1         subset of combodata, subbed by featurelistsub
combosubject          rbind of subtrain and subtest

featurelist           df used to store features.txt data
featurelistsmall      df used to store subset of featurelist by featurelistsub rows
featurelistsub        vector that stores grep'd values containing -mean and -std
finaldata             cbind of comboact and almostfinaldata

subtest               df used to store subject_test.txt data
subtrain              df used to store subject_train.txt data

varilong              vector of featurelistsmall feature names
varilong2             varilong with gsub applied to remove () and - from variable names
varilong3             varilong2 with tolower applied to variable names

xtest                 df used to store the X_test.txt data
xtrain                df to store the X_train.txt data

ytest                 df used to store y_test.txt data
ytrain                df used to store y_train.txt data