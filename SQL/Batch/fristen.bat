cd C:\Programme\Apache-Group\jakarta-tomcat-3.3.1a\webapps\terminebeta\SQL\Batch
osql -U scr -P lala -d schedule -i fristen.sql -o fristen.txt -w 500 -n -r > fristen.log
rem notepad /p fristen.txt
c:\Programme\wscite\scite.exe "-font.base=font:Courier New,size:8" -p fristen.txt
