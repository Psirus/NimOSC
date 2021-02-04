{.passL: "-llo".}
import macros

proc lo_address_new(ip: cstring, port: cstring): pointer {.header: "lo/lo.h", importc}
proc lo_blob_new(size: cint, data: cstring): pointer {.header: "lo/lo.h", importc}
proc lo_send*(address: pointer, path: cstring, types: cstring): cint {.header: "lo/lo.h", importc, varargs}

type 
  Client = object
    lo_address: pointer

proc newClient*(ip: string, port: int): Client =
  result.lo_address = lo_address_new(ip, $port)

macro send*(client: Client, path: string, args: varargs[typed]): untyped =
  var params = @[path, newLit("")]
  var typestring = ""
  for s in args:
    case typeKind(getType(s)):
      of ntyString: typestring.add("s")
      of ntyInt: typestring.add("i")
      of ntyFloat32: typestring.add("f")
      else: error("Unsupported argument type.")
    params.add(s)
  params[1].strVal = typestring
  result = newNimNode(nnkDiscardStmt)
  result.add quote do:
    lo_send(client.lo_address)
  for par in params:
    result[0].add(par)
