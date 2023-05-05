#!/bin/bash



#***************************************************************************************************************************************************
#Description:
#***************************************************************************************************************************************************

#This script defines a source directory and destination directory. 
#It then copies the error messages from the latest error log file in the source directory to a new file in the destination directory. 
#The new file has the same name as the original file, but with a timestamp appended to the end. 
#The script uses the ls command to get the latest error log file, then uses basename to extract the file name without the extension. 
#It then uses the date command to get the timestamp, and appends it to the file name to create the new file. 
#Finally, it uses grep to extract the error content from the error log file, and redirects it to the new file. 
#The script also checks the return value of the grep command to ensure that it executed successfully.


#***************************************************************************************************************************************************
#Start
#***************************************************************************************************************************************************

echo "Script Starting ..."

#***************************************************************************************************************************************************
# Define the source directory to backup and the destination directory 
#***************************************************************************************************************************************************
src_dir="/Users/krishnaveni/Desktop"
dest_dir="/Users/krishnaveni/Desktop/error-folder"
  

#***************************************************************************************************************************************************
#copy the error messages to the new file in the destination folder
#***************************************************************************************************************************************************

  # Get the file name without the extension
filename=$(basename "$(ls -t ${src_dir}/*error*.log | head -n1)")

  # Get the timestamp for the new file
timestamp=$(date +"%Y%m%d_%H%M%S")

  # Create the new file with the error content and timestamp
new_file="${dest_dir}/${filename}_${timestamp}.log"

  # Get the error content from the file
error_content= grep -iE 'invalid|error|fail' "${src_dir}/"*error*.log >> "${new_file}"

  
if [ $? -eq 0 ]; then
    echo "Command Executed Successfully"
else
    echo "Command Failed"
fi

exit 0

