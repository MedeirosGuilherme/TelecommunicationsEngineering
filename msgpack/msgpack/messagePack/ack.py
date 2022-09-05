import msgpack

# Define data
ack = {
    "opcode": 4,
    "block": 200,
}

# Write msgpack file
with open("data.msgpack", "wb") as outfile:
    packed = msgpack.packb(ack)
    outfile.write(packed)

# Read msgpack file
with open("data.msgpack", "rb") as data_file:
    byte_data = data_file.read()

data_loaded = msgpack.unpackb(byte_data)
print(data_loaded)
print(ack == data_loaded)
