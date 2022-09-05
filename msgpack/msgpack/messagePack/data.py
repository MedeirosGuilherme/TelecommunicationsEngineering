import msgpack

# Define data
data = {
    "opcode": 3,
    "block": 255,
    "mode": b'coisaQualquer',
}

# Write msgpack file
with open("data.msgpack", "wb") as outfile:
    packed = msgpack.packb(data)
    outfile.write(packed)

# Read msgpack file
with open("data.msgpack", "rb") as data_file:
    byte_data = data_file.read()

data_loaded = msgpack.unpackb(byte_data)
print(data_loaded)
print(data == data_loaded)
