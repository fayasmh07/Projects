<h1 align=center>
  SBT FINAL PROJECT
</h1>

The SOC has received an anonymous report that a user is potentially exfiltrating data from the company. An image of the user’s hard drive has been taken, and you are responsible for analyzing the contents of a perfect copy to find any evidence of malicious activity. Using your newly developed skills, search through the folders and files using techniques to uncover 4 pieces of hidden information (each piece of evidence will contain the string {1 of 4} or similar). You will be tested on your ability to discover this information using all of the techniques taught in this course; Linux CLI navigation, identifying incorrect file extensions, identifying hidden files/folders, steganography, and password cracking.

Some useful commands include the following:
Remember you can view the manual page for tools by using “man <command>” to get useful information!

ls -a (Allows us to identify files hidden using filenames beginning with “.” in the current directory)
cat/heads/strings (Allows us to potentially find hidden text strings in image and audio files, or read text files from the CLI)
fcrackzip (Allows us to crack password protected .zip files)
steghide (Allows us to retrieve files hidden in image and audio files)
file (Allows us to see what the true file-type of the file is, even if the extension has been changed to trick us
