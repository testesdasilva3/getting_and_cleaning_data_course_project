#########################
# Course Project 1 - Exploratory Data Analysis Course
#########################

#loading tables

#train - datasets
x_train= read.table("./data/train/X_train.txt")
y_train= read.table("./data/train/y_train.txt")
subject_train= read.table("./data/train/subject_train.txt")

#test - datasets
x_test= read.table("./data/test/X_test.txt")
y_test= read.table("./data/test/y_test.txt")
subject_test= read.table("./data/test/subject_test.txt")

#Step 3 - getting columns names

features = read.table("./data/features.txt")
activity_labels = read.table("./data/activity_labels.txt")
names(x_train) = features[,2]
names(x_test) = features[,2]

#Step 1 - merging datasets

train = cbind(x_train,y_train,subject_train)
test = cbind(x_test,y_test,subject_test)
train_and_test = rbind(train,test)
names(train_and_test)[562] = "activity"
names(train_and_test)[563] = "subject"

#Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement
train_and_test = train_and_test[,c(grep(".*mean.*|.*std.*",features[,2]),562,563)]

#Step 4 - Appropriately labels the data set with descriptive variable names.

for(i in 1:nrow(activity_labels)){
    train_and_test$activity = gsub(activity_labels[i,1],activity_labels[i,2],train_and_test$activity)
}


#Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy = aggregate(train_and_test[,1:79],by=list(subject=train_and_test$subject,activity=train_and_test$activity),mean)

write.table(tidy,"tidy.txt",sep="\t")


