run_analysis <- funciont(){
    library(plyr)
    library(dplyr)
    #download data, we already did this once
    #download.file(fileurl, destfile="./project.zip")
    #unzip("./project.zip")
    
    #Read files
    testx <- read.table("./UCI HAR Dataset/test/X_test.txt")
    testy <- read.table("./UCI HAR Dataset/test/Y_test.txt")
    trainx <- read.table("./UCI HAR Dataset/train/X_train.txt")
    trainy <- read.table("./UCI HAR Dataset/train/Y_train.txt")
    subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    
    #Add Y column to X data, then combine add train at the end of test
    test <- cbind(testx,testy,subjects_test)
    train <- cbind(trainx,trainy,subjects_train)
    full <- rbind(test,train)
    
    #read names and labels
    names <- read.table("./UCI HAR Dataset/features.txt")
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    #add name for last column
    act <- data.frame(V1=562,V2="activity")
    sub <- data.frame(V1=563,V2="subject")
    names <- rbind(names,act,sub)
    #rename..names... to not have special characters
    names2 <- gsub("[^[:alnum:]///' ]", "", names$V2)
    
    #assign names
    colnames(full) <- names2
    
    #get the indicies of the columns matching Mean, mean or std
    index <- grep("mean",names$V2)
    index <- c(index,grep("Mean", names$V2))
    index <- c(index,grep("std", names$V2),562,563)
    newdata <- full[,index]
    
    #change activity numbers to names
    numbers <- c("1","2","3","4","5","6")
    labels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
    newdata$activity = mapvalues(newdata$activity, from = numbers, to = labels)
    
    #split data by activity and subject
    activity_data <- group_by(newdata,activity,subject)
    
    #summarise_each lets us run a summary across all columns, cant be spelled with a z
    final = summarise_each(activity_data,funs(mean))
    final
}
