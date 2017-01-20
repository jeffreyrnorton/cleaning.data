# cleaning.data

This is the final project of the Data Science specialization for the course on cleaning data.  The objective is to take "dirty" data from a well-known data set in the UCI data science library, reduce the data by taking the mean and standard deviation for given features of the data, and then label the data appropriately with the features.  This data is then output as a csv file (the mean) and also as an Excel file (xlsx) with both the mean and standard deviation.

The included code book describes the data in detail along with a very detailed explanation of how the data is processed.

FILES:
* run_analysis.R - R file which processes the data from "dirty" to "tidy" and outputs the tidy data.
* run_analysis.Rmd - Codebook - R Markdown file.  Describes in detail the data as well as the process of cleaning and outputing the data.
* run_analysis.html - Codebook.  HTML version produced using knitr from the R Markdwon file.
* subject_activities_average_tidy.csv - CSV file of tidy data.  This is the mean or average for all measurements across all activities.
* subject_activities_average_tidy.xlsx - Microsoft Excel file containing both the mean and standard deviation for all measurements across all activities.
