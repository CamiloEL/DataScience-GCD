# DataScience-GCD

*Quick start:* Run the run_analysis.R file and read the data set with:

data <- read.table("./DataMelt2.txt", header = TRUE)

# Description

The run_analysis.R script will download and merge data from selected .txt files available for download from the original data set, and will create a tidy data set for further analysis and revision from peers from the "Getting and Cleaning Data" Coursera Online Course.

The required packages - reshape2 and dplyr - will be loaded - **please install these packages to read the data properly**

run_analysis.R will check if the required data is available in the working directory; if not, it will download it and unzip it into the "UCI HAR Dataset" directory.

The script will then read the 'features.txt' file to get the variable names. These will be used to rename the variables for the 'X_test' and 'X_training' datasets, upon reading the data. In this step, subject identification is coded as "subject ID", and the activity variable as "Activity". A dataframe with the whole dataset is created as "MergedData".

The script will then rename the Activity variable, to apply descriptive names. Variables containing means ("mean") and standard deviation ("std") measures are selected. Also, appropriate labels will be provided for the variable names. **Please refer to the codebook to review the method to re-name the variables.**

Finally, a new dataset under the name of "DataMelt2" is created through the "melt" and "dcast" functions. This contains the average of the selected variables, for each subject, and for each of the 6 Acitivity typres, properly labeled.

As stated before, you can read this data set using the following command, after sourcing run_analysis.R:

data <- read.table("./DataMelt2.txt", header = TRUE)
