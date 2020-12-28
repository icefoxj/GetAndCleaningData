## Get and Cleaning Data
Marcelo Jarretta
12/24/2020

This R script (*run_analysis.R*) executes a serie of R command to load the data from experiment and prepare the data following this rules:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script executes:

- Load the libraries that will be used in the script
- Set initial variables that will be used in the commands
- Read all the txt files into data.table variables
- Merge the test and training variables into a common variable
- Set column names based on the txt file
- Select only columns with *mean* and *std* in the name
- Map the activity values column to names in the txt file
- Create the output directory, if don't exists
- Create the output file, *tidy_data.csv*
- Summarize the data, calculating the mean of all columns, grouped by *subject* and *activity*
- Create the output file, *data_summarized.csv*
- Remove all variables from the memory


