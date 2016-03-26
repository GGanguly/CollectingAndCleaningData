getSubjectActivitySummaryData <- function(){
        #All features
        features <- read.table("features.txt", stringsAsFactors=F, colClasses = "character")
        
        ## Activity labels
        labels <- read.table("activity_labels.txt", stringsAsFactors=F, colClasses = "character", col.names = c("activity.code", "activity.name"))
        
        ## Gather test data
        testData <- getSubjectActivityDataset("test", features)
        
        ## Gather training data
        trainData <- getSubjectActivityDataset("train", features)
        
        ##JOIN test and training data
        completeActivityData <- rbind(trainData, testData)
        
        ## Calculate Mean of all measurement columns 
        ## Grouped by Subjects,Activity 
        ## for ONLY those columns whose name MATCH "activity|subject|mean|std"
        require(dplyr)
        summaryTemp <- completeActivityData %>% select(matches("activity|subject|mean|std")) %>% group_by(subject.id,activity.code) %>% summarise_each(funs(mean))
        
        ## Final summarized data per subject and activity label
        ## Attach Activity label post summary as that saves space bcos 180 records is faster to deal with than 10299 records 
        ## and its only for viewing purpose
        summaryData <- merge(x=labels,y=summaryTemp, by.x="activity.code", by.y="activity.code") %>% arrange(subject.id,activity.code) %>% select(matches("subject.id|activity.name|mean|std"))
}


getSubjectActivityDataset <- function(datasetType, features) {
        activityFile <- file.path(getwd(), datasetType, sprintf("y_%s.txt",datasetType))
        subjectFile <- file.path(getwd(), datasetType, sprintf("subject_%s.txt",datasetType))
        dataFile <- file.path(getwd(), datasetType, sprintf("X_%s.txt",datasetType))
        
        #read activity reference
        activityRef <- read.table(activityFile, stringsAsFactors=F, col.names = c("activity.code"))
        
        #read subject reference
        subjects <- read.table(subjectFile, stringsAsFactors=F, col.names = c("subject.id"))
        
        #read measurements data
        measurements <- read.table(dataFile, stringsAsFactors=F, colClasses = "double", col.names = features$V2)
        
        ## Concatenate [activityRef + subjects + measurements]
        subjectActivityData <- cbind(subjects, activityRef, measurements)
}