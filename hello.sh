#!/bin/bash

#***************************************************************************************************************************************************
#Description:
#***************************************************************************************************************************************************
#This Bash script reads the contents of an input file line by line and appends the string " hello" to each line,
#then writes the modified lines to an output file. Here's a breakdown of the script:

#The script begins with a comment block that indicates it is starting.
#The input file and output file are defined as variables using absolute paths.
#A while loop is used to read each line of the input file and append " hello" to the end of the line, 
#then write the modified line to the output file using echo and the -n option to suppress the newline character. 
#The $line variable represents the current line being read from the input file.
#The if statement checks the exit status of the previous command (echo), and if it is 0 (i.e., the command executed successfully), 
#it prints a message indicating success; otherwise, it prints a message indicating failure.
#The script exits with a status of 0, indicating success.
#A comment block indicates that the script is ending, but this code is never reached because the exit command exits the script before it is executed.


#Note that the exit command is used to explicitly exit the script with a status of 0, indicating success. 
#This is good practice to ensure that the script exits cleanly and to signal to calling programs that the script completed successfully. 
#The echo commands are used to print status messages to the console for debugging purposes, 
#but they could be removed in a production version of the script.

#***************************************************************************************************************************************************
#Delete the op File:
#***************************************************************************************************************************************************
if [ -f "/Users/krishnaveni/Desktop/output.txt" ]; then
	echo "output_file exists deleting"
   rm "/Users/krishnaveni/Desktop/output.txt"
else
	"No outputfile"
fi

#***************************************************************************************************************************************************
#Starting:
#***************************************************************************************************************************************************
echo "Starting the script..."

#***************************************************************************************************************************************************
#Input - output files:
#***************************************************************************************************************************************************

input_file='/Users/krishnaveni/Desktop/input.txt'
output_file='/Users/krishnaveni/Desktop/output.txt'


#***************************************************************************************************************************************************
#Reading through the file:
#***************************************************************************************************************************************************
echo $(date +"%Y-%m-%d_%H-%M-%S") >> $output_file
# Open the input file and read its contents line by line
while read line; do
  # Append "hello" to the current line and save it to the output file
  echo  "${line} hello" >> $output_file
done < $input_file

if [ $? -eq 0 ]; then
    echo "Command Executed Successfully"
else
    echo "Command Failed"
fi

exit 0


#***************************************************************************************************************************************************
#Ending:
#***************************************************************************************************************************************************
echo "Ending the script..."
