# run_analysis

run_analysis.R downloads the UCI HAR Dataset and processes the average of specifc metrics broken out by subject and activity.

The dataset loads the test and train datasets, adds the column names as defined in features.txt and combines it with the activity labels from activity_labels.txt, and subject data defined in subjects_test.txt and subjects_train.txt.

Columns not containing mean or standard deviation measures were then removed.  The data is then broken out by activity and subject id, and the mean for each metric is provided, even though this makes no mathematical sense for standard deviations.  Meaningless analysis is still analysis.

Special characters have been removed from the feature names to make things a little more readable/short.  Activity names were also added, replacing the id numbers.
