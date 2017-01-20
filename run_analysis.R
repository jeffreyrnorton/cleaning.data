## QUIZ - Getting and cleaning data project.
## Assignment: https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project
## Jeffrey Norton

## ---- download ----
library(xlsx)

# Download the file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              dest="dataset.zip")
# Unzip the file
unzip("dataset.zip")

## ---- readdata ----
# File paths located from download...
sub.dir="UCI HAR Dataset"
test.dir.path=file.path(sub.dir,"test")
train.dir.path=file.path(sub.dir,"train")

# Read the data
ttdp.X <- read.table(file.path(test.dir.path, "X_test.txt"))
ttdp.y <- read.table(file.path(test.dir.path, "y_test.txt"))
tndp.X <- read.table(file.path(train.dir.path, "X_train.txt"))
tndp.y <- read.table(file.path(train.dir.path, "y_train.txt"))

row.labels <- read.table(file.path(sub.dir, "activity_labels.txt"))
col.labels <- read.table(file.path(sub.dir, "features.txt"))

## ---- mergedata ----
# Merge the data.frames
merged.df.X <- rbind(ttdp.X, tndp.X)
merged.df.y <- rbind(ttdp.y, tndp.y)

## ---- cleandata ----
# Create data.frames for mean and standard deviation
# across each subject (in columns) for the activities (in rows)
mean.df <- sd.df <- NULL
# Processing each subject
for( subject in as.numeric(names(table(merged.df.y)))) {
  # activity.df are all sensor measurements for this activity across all sensors
  activity.df <- merged.df.X[which(merged.df.y$V1==subject[1]),]
  # Extracts measurements on the mean and standard deviation for each measurement.
  mean.r <- sapply(activity.df, function(x) mean(x))
  sd.r <- sapply(activity.df, function(x) sd(x))
  
  # Assign row to data frame.
  if( is.null(mean.r) ) mean.df <- data.frame(mean.r)
  else                  mean.df <- rbind(mean.df, mean.r)
  if( is.null(sd.r) )   sd.df <- data.frame(sd.r)
  else                  sd.df <- rbind(sd.df, sd.r)
}

## ---- assignlabels ----
# Assign row (activity) names
rownames(mean.df) <- rownames(sd.df) <- row.labels[,2]
colnames(mean.df) <- colnames(sd.df) <- col.labels[,2]

## ---- tidydata ----
# Write out a tidy file of the data (mean data.frame) as a csv.
write.table(mean.df,
            file=file.path(sub.dir, "subject_activities_average_tidy.csv"),
            sep=",", col.names=NA)
# Also, write out all data (mean and sd) to an Excel file with two sheets
xlsx.path <- file.path(sub.dir, "subject_activities_average_tidy.xlsx")
write.xlsx2(mean.df,
           file=xlsx.path,
           sheetName="Mean",
           append=FALSE)
write.xlsx2(sd.df,
           file=xlsx.path,
           sheetName="Standard Deviation",
           append=TRUE)

## ---- labels ----
print(row.labels)
print(col.labels)

## ---- mean ----
print(mean.df)

## ---- sd ----
print(sd.df)
