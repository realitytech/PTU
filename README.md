# PTU
Port Test Utility for DOS 
This is a quick and dirty TP program to bash I/O port addresses for testing hardware. Its been a VERY long time since I did any DOS programming.

Use:
PTU -p:port -d:delay -1:value1 -2:value2 -a -r -s

Port is specified in decimal or with the $ prefix for hex.
Delay is the delay between read/writes in mS.
Value1 and Value2 specifiy the bytes to use for the writes. If one is not specified, 0 will be used. $ can be used for hex numbers again.
-A Bypasses the warning.
-R Does the same but reads the port and outputs the decimal value to the screen.
-S stops screen output, reduces bus chatter significantly from screen updates.

To alternate 0xAA and 0X55 to the printer port data register alternatively at 1S intervals:
PTU -p:$378 -D:1000 -1:$AA -2:$55

To do the same with no warning ad use 0x00/0xFF with no screen output
PTU -p:$378 -D:1000 -2:$FF -S

To read the printer port data register to the screen at half second intervals
PTU -P:$378 -d:500 -r

This is batch file friendly and will return error codes. These can be found in the source. Of course hitting hardware like this has the potential to make really bad things happen and there is a nag screen to make sure you understand this. Using the -a parameter will skip this. -1 and -2 are optional and will both default to 0, this could be used to test address latched without disturbing anything else. You can also only specify one, to use a a pattern of 0x00/0x55 you could specify just 0x00

Notation is Borland pascal, so decimal numbers are input as it, hex with $ preceeding. 0xnn notification will not work.

