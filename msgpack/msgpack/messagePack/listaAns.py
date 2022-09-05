import msgpack

# Define data
listAns = {
    "opcode": 11,
    "elementos": ["filename", ("filename", 10000)],
}

# Write msgpack file
with open("data.msgpack", "wb") as outfile:
    packed = msgpack.packb(listAns)
    outfile.write(packed)

# Read msgpack file
with open("data.msgpack", "rb") as data_file:
    byte_data = data_file.read()

data_loaded = msgpack.unpackb(byte_data)
print(data_loaded)
print(listAns == data_loaded)
