# Project Clean up..
===================================================================================================================================
This repo holds the script to analyze and summarize observations of 6 subjects performing various activties.The goal was to get the
average of only those features from the dataset that hold the mean and standard deviations as observed in units of g.

## Goal
===================================================================================================================================
Collect, work with, and creating a tidy data set that can be used for later analysis.

## Steps to get going!
================================================
1. Copy run_Analysis.R script to the main UCI Datasets folder.
   <Path to your UCI HAR Datasets folder>\
				|	  
				|-----train\<--- training data sub-folder
				|-----test\<--- test data sub-folder
				
				activity_labels.txt
				features_info.txt
				run_Analysis.R
				README.txt
2. Set your working directory to point to this location in your IDE, using setwd(<Path to your UCI HAR Datasets folder>)
3. Load script file, using source("run_Analysis.R")
4. Execute the following command: summarizedData <- getSubjectActivitySummaryData()
5. Thats it!