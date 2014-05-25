Smartphones-
============

comment: 
Each step in the file "run_analysis.R" are describe in the code. Each step is signed by lines and number of quest. Some time I change the order of quests. 

Briefly:
- set working directory
- read files of column names and change the name of them to be compatible with R
- read and combine subject data
- read files with activity id
- read and combine test and train data
- combine all data with subject and activity id 
- read file with labels
- add names of activity
- Extracts only the measurements on the mean and standard deviation for each measurement. With TRUE mean() and std(). Not mean freq...
- compute all means for all subject and all activity
- create a file (tide_data_set.txt) with new independent data set
- checking format after reading from the file (if values are numeric)
