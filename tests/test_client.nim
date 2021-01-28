import os, osproc, strutils
import ../nimosc

let oscdump = startProcess("/usr/bin/oscdump", args=["-L", "9876"])
# Needs a bit of startup time
sleep(50)

let client = newClient("127.0.0.1", 9876)
client.send("/run-code", "nimosc", "sample :loop_amen")
client.send("/foo/bar", 0.12345678'f32, 23.0'f32)
# Needs a bit of time for the messages to be delivered
sleep(50)

oscdump.terminate()
let (lines, _) = oscdump.readLines()
doAssert(lines[1].split(' ')[1..^1] == ["/foo/bar", "ff", "0.123457", "23.000000"])
oscdump.close()
