                                          Linux Fundamentals

Linux File System Hierarchy
The Linux File System Hierarchy Standard (FHS) defines the structure and organization of files and directories in Linux distributions. This standard ensures consistency across different Linux systems and facilitates interoperability between applications.
This content was retrieved from https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html

The  main directories in the Linux file system hierarchy:
1.	/ (Root Directory):
  The root directory is the top-level directory in the file system hierarchy.
  All other directories and files are contained within the root directory.
  It is represented by a forward slash /.
2.	/bin (Binaries):
  Contains essential system binaries (executable files).
  Binaries here are necessary for system boot and repair.
3.	/etc (Configuration Files):
  Contains system-wide configuration files.
  Configuration files for various services, applications, and system settings are stored here.
4.	/home (Home Directories):
  Contains home directories for regular users.
  Each user has their own subdirectory within /home where they can store personal files and configuration settings.
5.	/var (Variable Data):
  Contains variable files, such as logs, databases, spool files, and temporary files.
  Data in /var may change frequently during system operation.
6.	/usr (User):
  Contains user-related files, including user binaries, libraries, documentation, and other read-only data.
  /usr is typically shared among multiple systems in networked environments.
7.	/tmp (Temporary Files):
  Contains temporary files that are typically deleted upon system reboot.
  Users and applications can store temporary data here.
8.	/dev (Device Files):
  Contains device files, representing physical and virtual devices connected to the system.
  Device files provide an interface for interacting with hardware devices.
9.	/proc (Process Information):
  A virtual filesystem that provides information about running processes and system configuration.
  /proc contains directories and files representing system resources and processes.
10.	/mnt (Mount) and /media:
  Used as mount points for temporarily attaching external filesystems, such as USB drives, network shares, or CD-ROMs.
11.	/opt (Optional):
  Contains optional software packages or applications that are not part of the core system.
  Third-party software packages may be installed here.


Command-Line Tools for Navigation and Management:
1.	cd: Change directory.
2.	ls: List directory contents.
3.	pwd: Print working directory.
4.	mkdir: Make directories.
5.	rm: Remove files or directories.
6.	cp: Copy files and directories.
7.	mv: Move or rename files and directories.
8.	touch: Create empty files or update file timestamps.
9.	chmod: Change file permissions.
10.	chown: Change file ownership.


<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/a37b0e39-25e5-4f00-9344-f20d6ec6812b">

Using text editors like vim or nano to create, edit, and manipulate text files

Vim and Nano are text editors used in manipulating files. I used Vim for this activity.

1.	vim new_file.txt
This command is used to create a new file typing vim thefilename.fileextension
To enter insert mode, I pressed “I” on my keyboard.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/eeefdbd6-5ce0-40ed-938e-99e2401e2824">

2.	Editing a File.
To open an existing file use the vim command and the file name, I to enter eidt mode and begin typing the text. 
  Press Esc to exit insert mode. 
Type :wq and press Enter to save and exit Vim.

<img width="468" alt="image" src="https://github.com/Makinates/Sarah-Oguche-Submissions/assets/153545236/e6da342b-77f0-4833-a766-105ee0b6194c">

3.	Navigate and Manipulate Text:
•	Use arrow keys or h, j, k, l to navigate.
•	Use dd to delete a line.
•	Use yy to yank (copy) a line.
•	Use p to paste the yanked line.

Command-line tools for system administration tasks (e.g., ps, top, df, du, lsof, netstat)
1.	ps (Process Status):
•	View all processes: ps aux
•	Filter processes by name: ps aux | grep process_name
•	View process tree: ps auxf

2. top (System Monitor):
•	Display dynamic system information: top
•	Sort processes by CPU or memory usage: Press Shift + P to sort by CPU usage, and Shift + M to sort by memory usage.
•	Interactively kill processes: Press k to kill a process.

3. df (Disk Free):
•	Display disk space usage: df -h
•	View usage for a specific filesystem: df -h /path/to/filesystem

4. du (Disk Usage):
•	Display disk usage for directories: du -h /path/to/directory
•	Show only total usage: du -sh /path/to/directory

5. lsof (List Open Files):
•	List all open files: lsof
•	List open files for a specific process: lsof -p PID

6. netstat (Network Statistics):
•	Display network connections: netstat -tuln
•	Show listening ports: netstat -tuln | grep LISTEN
•	Monitor network traffic in real-time: netstat -i








