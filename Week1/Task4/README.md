                                  Command Line Scripting

1.	This bash script checks if a file is in a specific directory and prints it.
If the file does not exist, it returns a message “File does not exist”.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/b2cf2fd3-67fb-45dc-b32a-27ef8c174318">

Instead of running the script every single time we need to print a file, we can easily save the script to a file, using any file name – “print_doc_script.sh” nd then make it executable using the command chmod +x check_file.sh. Now you can execute the script by running ./check_file.sh.
Explanation of the script:
1.	#!/bin/bash: This is known as a shebang line, it tells the system which interpreter to use to execute the script, in this case, Bash.
2.	file_path="/path/to/your/file.txt": Here, we're defining the path to the file we want to check.
3.	if [ -e "$file_path" ]; then: This is an if statement that checks if the file exists (-e flag). If it does, it executes the code inside the if block, otherwise, it executes the code inside the else block.
4.	echo "File exists. Printing contents:": If the file exists, this line prints a message.
5.	cat "$file_path": This command prints the contents of the file.
6.	else: If the file does not exist, execution continues here.
7.	echo "File does not exist.": This line prints a message if the file does not exist.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/e1406660-9609-4cfe-9d38-0216fc21939e">

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/6ef10e24-bb6d-4be2-8974-2e87d3b4e4c2">

2.	Creating a backup of a directory and compress it into a tarball.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/a8e33255-ddf7-4ef1-90f2-7c33f581a5ee">

A tarball refers to a file that has been created using the tar command and typically compressed using a compression tool like gzip (gzip) or bzip2 (bzip2). The name "tarball" comes from the combination of "tar" (which stands for "tape archive") and "ball" (indicating a compressed bundle of files).
When you create a tarball, you're essentially bundling multiple files and directories into a single file. This is useful for tasks like creating backups or distributing a collection of files.
3.	Log Rotation- This script will rotate log files, keeping a certain number of backups.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/083769d0-85c8-437b-a44d-37ef5f5ba9a7">

4.	Log File Analysis Script: This script will analyze a log file to count the occurrences of each unique IP address.
The script uses awk to extract the first column (IP addresses) from the log file, then pipes the output to sort to sort the IP addresses, uniq -c to count the occurrences of each unique IP address, and finally another sort to sort the results numerically in descending order.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/5e448397-90e2-4da8-9a65-f2db4504200f">

5.	File Search and Replace Script- This script will search for a specific string in all text files in a directory and replace it with another string.
The script iterates through all .txt files in the specified directory, then uses sed to perform an in-place search and replace operation (-i) to replace occurrences of $search_string with $replace_string in each file.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/42eeec9c-de24-4492-be53-89508d6cd3a7">

6.	Directory Cleanup Script - This script will delete files older than a specified number of days from a directory.
The script uses the find command to locate files (-type f) in the specified directory that are older than $days_old days (-mtime +"$days_old") and deletes them using rm.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/4536efd5-f919-4f10-a597-3936769b1a82">

7.	Search Script Using grep - This script searches for a given pattern in all files within a specified directory.
This script uses grep with the following options:
•	-r : Recursive search within subdirectories.
•	-n : Display line numbers where the pattern is found.
The script will search for the specified pattern in all files within the specified directory and display the matching lines along with their line numbers.
To search for the word "error" in all files within the directory /var/log, you would set search_pattern="error" and directory="/var/log". Then, running the script will display all lines containing the word "error" along with their line numbers in the files under /var/log.
![image](https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/f5c437a8-584b-4a2e-ae0a-d5b2fea8fc5d)
8.	A script that demonstrates the use of grep, sed, awk, and cut together in a single script.
This script will read a CSV file, filter specific rows using grep, extract certain columns using cut, and perform additional manipulation using sed and awk.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/e4dd147d-033a-49f4-aa18-3f1897ceae95">
