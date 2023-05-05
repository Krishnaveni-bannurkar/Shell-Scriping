#!/bin/bash


#***************************************************************************************************************************************************
#Delete the Log File:
#***************************************************************************************************************************************************
log_file="log.txt"

if [ -f "$log_file" ]; then
   rm "$log_file"
fi


#***************************************************************************************************************************************************
# monitor disk_free_space
#***************************************************************************************************************************************************
# Get the current disk usage
#The FNR == 2 condition tells awk to only execute the print $5 command on the second line of the output of df
disk_free_space=$(df -h /System/Volumes/Update/SFR/mnt1 | awk 'FNR == 2 {print $5}')

echo "Disk Free = $disk_free_space at $(date +"%Y-%m-%d_%H-%M-%S")" >> log.txt

#if disk_free_space > 30% send a notification : clear the logs to free space. 
if [[ $disk_free_space > 30 ]]; then
    echo "disk_free_space is greater than 70%, Clear the logs to free space" >> log.txt
else 
    echo "disk_free_space is $disk_free_space"
fi

#***************************************************************************************************************************************************
#Email
#***************************************************************************************************************************************************
#Create the email message with all the monitoring data
subject="System Monitoring"
#body="CPU Usage: ${cpu_usage}%\nMemory Usage: ${memory_usage}%\nDisk Usage: ${disk_usage}\nDisk Free Space: ${disk_free_space}"
#body="Memory Usage: ${memory_usage}%\nDisk Usage: ${disk_usage}\nDisk Free Space: ${disk_free_space}"
body="$log.txt"

echo "script executed ... initiating the email.."

# Send the email
echo -e "$body" | mail -s "$subject" krishnaveni.nkatte@gmail.com

if [ $? -eq 0 ]; then
    echo "Command Executed Successfully"
else
    echo "Command Failed"
fi

exit 0