import nimosc

let client = newClient("127.0.0.1", 9876)
client.send("/run-code", "nimosc", "sample :loop_amen")
client.send("/foo/bar", 0.12345678'f32, 23.0'f32)
