#!usr/bin/bash
#https://bash.cyberciti.biz/guide/Variables
#*****************************************************************
#						ABOUT LINUX DIRECTORIES
#*****************************************************************
# bin
# Essential user programs are stored here. These represent the bare minimum set of programs required for a user to use the system. Things like the shell and the filesystem commands (ls, cp, and so on) are stored here. The /bin directory usually doesn't receive modification after installation. If it does, it's usually in the form of package upgrades that we provide.

# boot
# Files that are used by the Linux Loader (LILO). This directory also receives little modification after an installation. The kernel is stored here as of Slackware 8.1. In earlier releases of Slackware, the kernel was simply stored under / , but common practice is to put the kernel and related files here to facilitate dual-booting.

# dev
# Everything in Linux is treated as a file, even hardware devices like serial ports, hard disks, and scanners. In order to access these devices, a special file called a device node has to be present. All device nodes are stored in the /dev directory. You will find this to be true across many Unix-like operating systems.

# etc
# This directory holds system configuration files. Everything from the X Window configuration file, the user database, to the system startup scripts. The system administrator will become quite familiar with this directory over time.

# home
# Linux is a multiuser operating system. Each user on the system is given an account and a unique directory for personal files. This directory is called the user's home directory. The /home directory is provided as the default location for user home directories.

# lib
# System libraries that are required for basic operation are stored here. The C library, the dynamic loader, the ncurses library, and kernel modules are among the things stored here.

# mnt
# This directory contains temporary mount points for working on hard disks or removable drives. Here you'll find mount points for your CD-ROM and floppy drives.

# opt
# Optional software packages. The idea behind /opt is that each software package installs to /opt/software-package, which makes it easy to remove later. Slackware distributes some things in /opt (such as KDE in /opt/kde), but you are free to add anything you want to /opt.

# proc
# This is a unique directory. It's not really part of the filesystem, but a virtual filesystem that provides access to kernel information. Various pieces of information that the kernel wants you to know are conveyed to you through files in the /proc directory. You can also send information to the kernel through some of these files. Try doing cat /proc/cpuinfo.

# root
# The system administrator is known as root on the system. root's home directory is kept in /root instead of /home/root. The reason is simple. What if /home was a different partition from / and it could not be mounted? root would naturally want to log in and repair the problem. If his home directory was on the damaged filesystem, it would make it difficult for him to log in.

# sbin
# Essential programs that are run by root and during the system bootup process are kept here. Normal users will not run programs in this directory.

# tmp
# The temporary storage location. All users have read and write access to this directory.

# usr
# This is the big directory on a Linux system. Everything else pretty much goes here, programs, documentation, the kernel source code, and the X Window system. This is the directory to which you will most likely be installing programs.

# var
# System log files, cache data, and program lock files are stored here. This is the directory for frequently-changing data.

#*****************************************************************
#							BREAK
#*****************************************************************
echo "
vi editor commands

-- TO EXIT
:wq 				- Save and quite
:q 					- quit
:q! 				- quit vi even though latest changes have not been saved for this vi call 

-- TO MOVE CURSOR
0(zero) 			- move cursor to start of current line (the one with the cursor)
$					- move cursor to end of current line
w					- move cursor to beginning of next word
b					- move cursor back to beginning of preceding word
:0<Return> or 1G	- move cursor to first line in file
:n<Return> or nG	- move cursor to line n
:$<Return> or G		- move cursor to last line in file

-- SCREEN MANIPULATION (^ = CTRL)
^f	move forward one screen
^b	move backward one screen
^d	move down (forward) one half screen
^u	move up (back) one half screen

-- UNDO 
u

-- Inserting or Adding Text
ESC + i - to insert 
a	append text after cursor, until <Esc> hit
A	append text to end of current line, until <Esc> hit
o	open and put text in a new line below current line, until <Esc> hit
O	open and put text in a new line above current line, until <Esc> hit

-- Deleting Text
x	delete single character under cursor
Nx	delete N characters, starting with character under cursor
dw	delete the single word beginning with character under cursor
dNw	delete N words beginning with character under cursor; 
  e.g., d5w deletes 5 words
D	delete the remainder of the line, starting with current cursor position
dd	delete entire current line
Ndd or dNd	delete N lines, beginning with the current line; 
  e.g., 5dd deletes 5 lines

-- COPY PASTE
yy	copy (yank, cut) the current line into the buffer
p	put (paste) the line(s) in the buffer into the text after the current line

-- Searching Text
/string	search forward for occurrence of string in text
?string	search backward for occurrence of string in text
n	move to next occurrence of search string
N	move to next occurrence of search string in opposite direction

-- Determine LINE NUMBER
:.=	returns line number of current line at bottom of screen
:=	returns the total number of lines at bottom of screen

-- Saving and reading file
:w<Return>	write current contents to file named in original vi call
:w newfile<Return>	write current contents to a new file named newfile
:12,35w smallfile<Return>	write the contents of the lines numbered 12 through 35 to a new file named smallfile
:w! prevfile<Return>	write current contents over a pre-existing file named prevfile
"; 
#*****************************************************************
#							BREAK
#*****************************************************************
echo "
1. bash shell have Internal and external commands.
2. type command tells if command is Internal(built in) or external. It also displays path";
type -a pwd
type -p ls
#*****************************************************************
#							BREAK
#*****************************************************************
echo "
which - displays full path of the command
whereis - displays all path including man documentations
";
which bash
whereis bash
#*****************************************************************
#							BREAK
#*****************************************************************
echo "
tar - archiving using tar
-c create
-v verbose
-vv verbose detail
-f file (MANDATORY)
-t lists file/directories in tar
-x Extract
-u Update
--delete To delete file
-r APPEND
";
touch saur.txt
mkdir saur_dir
tar -cvf saurabh.tar saur.txt saur_dir
tar -xvf saurabh.tar
tar -tf saurabh.tar
tar -tvf saurabh.tar
tar -xvf saurabh.tar saur.txt
tar -xvvf saurabh.tar saur.txt
mkdir newdir
tar -rf saurabh.tar newdir/
tar -tf saurabh.tar
touch newdir/newfileTOappend
tar -uf saurabh.tar newdir
tar -tf saurabh.tar
tar --delete -f saurabh.tar saur.txt
tar -tf saurabh.tar
#*****************************************************************
#							BREAK
#*****************************************************************
echo "history - Display list of commands executed";
history | less
#*****************************************************************
#							BREAK
#*****************************************************************
echo "chmod usage
rwx - 421
0 - no permission
7 - rwx
5 - rx
u g o - user group others
+x, +r, +w, +rxw
";
chmod 755 saur.txt
#*****************************************************************
#							BREAK
#*****************************************************************
# debugging script
bash -x hello.sh
bash -xv hello.sh
echo "
appending -x will run entire script in DEBUG mode, #!/bin/bash -x
You can use set -x to turn on debugging
and set +x to turn off debugging 
IN the shell file" ;
#*****************************************************************
#							BREAK
#*****************************************************************
# Script to print currently logged in users information, and current date & time.
clear
echo "Hello $USER"
echo -e "Today is \c ";date
echo -e "Number of user login : \c" ; who | wc -l
echo "Calendar"
cal
exit 0
#*****************************************************************
#							BREAK
#*****************************************************************











