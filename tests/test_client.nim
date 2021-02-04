import  os, osproc, strutils
import ../nimosc

let oscdump = startProcess("/usr/bin/oscdump", args=["-L", "9876"])
# Needs a bit of startup time
sleep(50)

let client = newClient("127.0.0.1", 9876)
client.send("/foo/bar", 0.12345678'f32, 23.0'f32)
client.send("/f*/bar", 0.12345678'f32, 34.0'f32)
client.send("/foo/b*", 0.12345678'f32, 56.0'f32)
client.send("/f*", 0.12345678'f32, 78.0'f32)
client.send("/a/b/c/d", "one", 0.12345678'f32, "three", -0.00000023001'f32, 1.0'f32)
# Needs a bit of time for the messages to be delivered
sleep(50)

oscdump.terminate()
let (lines, _) = oscdump.readLines()
doAssert lines[0].split(' ')[1..^1] == ["/foo/bar", "ff", "0.123457", "23.000000"]
doAssert lines[1].split(' ')[1..^1] == ["/f*/bar", "ff", "0.123457", "34.000000"]
doAssert lines[2].split(' ')[1..^1] == ["/foo/b*", "ff", "0.123457", "56.000000"]
doAssert lines[3].split(' ')[1..^1] == ["/f*", "ff", "0.123457", "78.000000"]
doAssert lines[4].split(' ')[1..^1] == ["/a/b/c/d", "sfsff", "\"one\"", "0.123457", "\"three\"", "-0.000000", "1.000000"]

oscdump.close()
