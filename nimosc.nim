{.passL: "-llo".}

proc lo_address_new(ip: cstring, port: cstring): pointer {.header: "lo/lo.h", importc}
proc lo_blob_new(size: cint, data: cstring): pointer {.header: "lo/lo.h", importc}
proc lo_send(address: pointer, path: cstring, types: cstring): cint {.header: "lo/lo.h", importc, varargs}

type 
  Client = object
    lo_address: pointer

proc newClient*(ip: string, port: int): Client =
  result.lo_address = lo_address_new(ip, $port)

# TODO: this varargs doesn't really make sense here atm, since the call is hardcoded for len == 2
proc send*(client: Client, command: string, messages: varargs[string]) =
  var blobs: seq[pointer]
  for message in messages:
    blobs.add(lo_blob_new(int32(len(message)), message))
  discard lo_send(client.lo_address, command, "bb", blobs[0], blobs[1])
