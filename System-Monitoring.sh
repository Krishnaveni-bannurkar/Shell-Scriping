#!/bin/bash

# System Monitoring: 
# This script is designed to monitor system resources such as CPU, memory, and disk usage, and alerts users when usage goes beyond specified thresholds. 
#The script first deletes the log file if it exists and then starts monitoring the CPU usage, memory usage, disk usage, and disk free space. 
#The monitoring data is written to a log file. After the monitoring is complete, an email is sent with the monitoring data. 
#The email contains information about memory usage, disk usage, and disk free space. 
#The script ends by checking the exit code of the mail command and printing whether the command was executed successfully or not. 
#Finally, the script exits with code 0.


#***************************************************************************************************************************************************
#Delete the Log File:
#***************************************************************************************************************************************************
log_file="log.txt"

if [ -f "$log_file" ]; then
   rm "$log_file"
fi





#***************************************************************************************************************************************************
#start the script
#***************************************************************************************************************************************************
echo "Script Starting ..."
echo `touch log.txt`



#***************************************************************************************************************************************************
# monitor CPU usage
#***************************************************************************************************************************************************
# Get the current CPU usage
#cpu_usage = $(top -n 1 | grep "Cpu(s)" | awk '{print $2+$4}') 
#echo "cpu_usage  = $cpu_usage at $(date +"%Y-%m-%d_%H-%M-%S")" >> log.txt


#***************************************************************************************************************************************************
# monitor memory usage
#***************************************************************************************************************************************************
# Get the current CPU usage
memory_usage=$(vm_stat | awk '/Pages active/ {print $3*4096/1048576}')
echo "Memory Usage = $memory_usage at $(date +"%Y-%m-%d_%H-%M-%S")" >> log.txt

#***************************************************************************************************************************************************
# monitor disk usage
#***************************************************************************************************************************************************
# Get the current disk usage
disk_usage=$(du -sh /path/ | awk '{print $1}')

echo "Disk Usage = $disk_usage at $(date +"%Y-%m-%d_%H-%M-%S")" >> log.txt



#***************************************************************************************************************************************************
# monitor disk_free_space
#***************************************************************************************************************************************************
# Get the current disk usage
#The FNR == 2 condition tells awk to only execute the print $5 command on the second line of the output of df
disk_free_space=$(df -h /dev/ | awk 'FNR == 2 {print $5}')

echo "Disk Free = $disk_free_space at $(date +"%Y-%m-%d_%H-%M-%S")" >> log.txt




#***************************************************************************************************************************************************
#Email
#***************************************************************************************************************************************************
# Create the email message with all the monitoring data
subject="System Monitoring"
#body="CPU Usage: ${cpu_usage}%\nMemory Usage: ${memory_usage}%\nDisk Usage: ${disk_usage}\nDisk Free Space: ${disk_free_space}"
body="Memory Usage: ${memory_usage}%\nDisk Usage: ${disk_usage}\nDisk Free Space: ${disk_free_space}"

echo "script executed ... initiating the email.."

# Send the email
echo -e "$body" | mail -s "$subject" xxx@gmail.com

if [ $? -eq 0 ]; then
    echo "Command Executed Successfully"
else
    echo "Command Failed"
fi

exit 0
