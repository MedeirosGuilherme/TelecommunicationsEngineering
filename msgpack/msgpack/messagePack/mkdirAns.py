import msgpack

# Define data
mkdirAns = {
    "opcode": 5,
    "errorcode": 8,
    "errormsg": "directory done",
}

# Write msgpack file
with open("data.msgpack", "wb") as outfile:
    packed = msgpack.packb(mkdirAns)
    outfile.write(packed)

# Read msgpack file
with open("data.msgpack", "rb") as data_file:
    byte_data = data_file.read()

data_loaded = msgpack.unpackb(byte_data)
print(data_loaded)
print(mkdirAns == data_loaded)
