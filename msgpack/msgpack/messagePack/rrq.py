import msgpack

# Define data
rrq = {
    "opcode": 1,
    "fileaname": "File/to/path",
    "mode": "netascii",
}

# Write msgpack file
with open("data.msgpack", "wb") as outfile:
    packed = msgpack.packb(rrq)
    outfile.write(packed)

# Read msgpack file
with open("data.msgpack", "rb") as data_file:
    byte_data = data_file.read()

data_loaded = msgpack.unpackb(byte_data)
print(data_loaded)
print(rrq == data_loaded)
