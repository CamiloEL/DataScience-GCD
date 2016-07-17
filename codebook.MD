# Codebook for DataMelt2 dataset.

This code book summarizes the resulting data fields in "DataMelt2.txt."

# Identifiers

* subjectID - The ID of the test subject. It has 30 subjects, labeled with integers from 1 to 30.
* Activity - The type of activity performed. It has 6 categories (formatted as factors)

# Activity Labels

* Wlaking: subject was walking
* Walking Upstairs: subject was walking up a staircase
* Walking Downstairs: subject was walking down a staircase
* Sitting: subject was sitting
* Standing: subject was standing
* Laying: subject was laying down

# Features (Selection of Measure Variables)

The 86 Measure Variables in the data set are a selection from the full variables contained in the original dataset.
This selection includes all variables with a 'mean' or 'std' (standard deviation) in its name, as stated by the authors of the original dataset.
The full explanation for the variable names can be reviewed at the 'features_info.txt' file, available from the 'UCI HAR Dataset' directory. The original variable names are available from the 'features.txt' file.

For the selected variables, the following changes where made:

* Variables starting with t, refering to 'time', now start with 'time of'
* Variables stargint with f, refering to frequency after applying the FFT method, now start with 'frequency of'
* Variable names containing "Acc" where expanded to Accelerometer (refering to linear velocity)
* Variable names containing "Gyro" where expanded to Gyroscope (refering to angular velocity)
* Variable names containing "Mag" where expanded to "Magnitude".
* Variables names containing "Body" where simplified and expanded, as well as the ones with "Jerk"



