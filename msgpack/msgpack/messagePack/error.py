import msgpack

# Define data
error = {
    "opcode": 5,
    "errorcode": 7,
    "errormsg": "No such user",
}

# Write msgpack file
with open("data.msgpack", "wb") as outfile:
    packed = msgpack.packb(error)
    outfile.write(packed)

# Read msgpack file
with open("data.msgpack", "rb") as data_file:
    byte_data = data_file.read()

data_loaded = msgpack.unpackb(byte_data)
print(data_loaded)
print(error == data_loaded)
