#!/bin/bash



#***************************************************************************************************************************************************
#Description:
#***************************************************************************************************************************************************

#This script performs a backup of a source directory using the tar command, creates a backup filename with a date/time stamp, 
#and archives the source directory to a destination backup directory.

#The script then checks if the backup was successful by checking the exit status of the tar command. 
#If the backup was successful, the script checks for old backup files in the backup directory, 
#compares their creation time with the creation time of the current backup file, 
#and deletes them if they are older than the current backup file. The script uses the stat command to obtain the creation time of the files.


#Overall, this script is a useful tool for creating automated backups of important files or directories, 
#ensuring that data is not lost in case of system failures or other issues.





#***************************************************************************************************************************************************
Start
#***************************************************************************************************************************************************

echo "Script Starting ..."


#***************************************************************************************************************************************************
# Define the source directory to backup and the destination directory for the backup archive
#***************************************************************************************************************************************************
source_dir="/Users/krishnaveni/Desktop/interview-prep/Autosys-Commands"
backup_dir="/Users/krishnaveni/Desktop/interview-prep/backup-folder"





#***************************************************************************************************************************************************
# Define the backup filename and the date/time stamp
#***************************************************************************************************************************************************
backup_filename="Autosys-Commands_backup_$(date +"%Y%m%d_%H%M%S").tar.gz"






#***************************************************************************************************************************************************
# Archive the source directory using the tar command
#***************************************************************************************************************************************************
tar -czf "${backup_dir}/${backup_filename}" "${source_dir}" 

#tar is a command-line utility in Unix and Unix-like operating systems that is used to create, maintain, and manipulate collections of files in 
#an archive file, known as a "tarball." The name "tar" is short for "tape archive," 
#which reflects the fact that tar was originally developed to write data to sequential I/O devices like tape drives.








#***************************************************************************************************************************************************
# Check if the backup was successful

#***************************************************************************************************************************************************
if [ $? -eq 0 ]; then
    echo "Backup successful: ${backup_dir}/${backup_filename}"
    
    # Delete old backup file based on creation time
    for file in ${backup_dir}/Autosys-Commands_backup_*.tar.gz; do
        if [ "${file}" != "${backup_dir}/${backup_filename}" ] && [ -f "${file}" ]; then
            if [[ $(stat -f "%m" "${file}") -lt $(stat -f "%m" "${backup_dir}/${backup_filename}") ]]; then
                echo "Deleting old backup file: ${file}"
                rm "${file}"
            fi
        fi
    done
    
else
    echo "Backup failed"
fi



#loops through all the backup files in the directory ${backup_dir} with the pattern Autosys-Commands_backup_*.tar.gz. For each file, 
#it checks if it is not the current backup file ${backup_dir}/${backup_filename} and if it is a regular file with the -f option.

#For each such file, it compares its modification time, obtained using the stat command, with the modification time of the current backup file. 
#Specifically, it compares the output of stat -f "%m" "${file}", which gives the last modification time of the file in seconds since Epoch, 
#with the output of stat -f "%m" "${backup_dir}/${backup_filename}", which gives the last modification time of the current backup file.

#If the modification time of the backup file being checked is less than that of the current backup file, 
#it means that the backup file being checked is older than the current backup file and hence can be deleted. 
#The script prints a message indicating that it is deleting the old backup file ${file} and removes it using the rm command.
