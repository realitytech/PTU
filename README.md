# PTU
Port Test Utility for DOS 
This is a quick and dirty TP program to bash I/O port addresses for testing hardware. Its been a VERY long time since I did any DOS programming.

Use:
PTU -p:port -d:delay -1:value1 -2:value2 -a

Will alternatively write value1 then value2 with a delay of delay microseconds to port port until a key is pressed

This is batch file friendly and will return error codes. These can be found in the source. Of course hitting hardware like this has the potential to make really bad things happen and there is a nag screen to make sure you understand this. Using the -a parameter will skip this. -1 and -2 are optional and will both default to 0, this could be used to test address latched without disturbing anything else. You can also only specify one, to use a a pattern of 0x00/0x55 you could specify just 0x00

Notation is Borland pascal, so decimal numbers are input as it, hex with $ preceeding. 0xnn notification will not work.

