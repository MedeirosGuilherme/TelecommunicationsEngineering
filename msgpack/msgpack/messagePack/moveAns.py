import msgpack

# Define data
moveAns = {
    "opcode": 5,
    "errorcode": 9,
    "errormsg": "sucesso",
}

# Write msgpack file
with open("data.msgpack", "wb") as outfile:
    packed = msgpack.packb(moveAns)
    outfile.write(packed)

# Read msgpack file
with open("data.msgpack", "rb") as data_file:
    byte_data = data_file.read()

data_loaded = msgpack.unpackb(byte_data)
print(data_loaded)
print(moveAns == data_loaded)
