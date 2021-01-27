import nimosc

let client = newClient("127.0.0.1", 51235)
client.send("/run-code", "nimosc", "sample :loop_amen")
