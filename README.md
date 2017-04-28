# Get-and-Clean-Data
Final Project for Coursera Get and Clean Data

In order to read the data created from the script a standard call to read table should be used. 
data <- read.table(file_path,header = TRUE)

can use "./cleanedData.txt" if you have placed the files in your current working directory or a subfolder of it

the script uses the dplyr package, but initializes it when it runs. If you do not have this package installed it may cause an error. It can be installed with:

install.packages("dplyr")

An explanation of choices regarding cleaning of data and how the script works can be found in the attached code book. 
