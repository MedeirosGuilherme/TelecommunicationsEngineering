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
