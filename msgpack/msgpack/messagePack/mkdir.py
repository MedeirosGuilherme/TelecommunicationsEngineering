import msgpack

# Define data
mkdir = {
    "opcode": 12,
    "caminho": "path/to/dir",
}

# Write msgpack file
with open("data.msgpack", "wb") as outfile:
    packed = msgpack.packb(mkdir)
    outfile.write(packed)

# Read msgpack file
with open("data.msgpack", "rb") as data_file:
    byte_data = data_file.read()

data_loaded = msgpack.unpackb(byte_data)
print(data_loaded)
print(mkdir == data_loaded)
