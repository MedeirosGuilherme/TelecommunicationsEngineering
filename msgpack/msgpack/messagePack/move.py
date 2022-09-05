import msgpack

# Define data
move = {
    "opcode": 13,
    "nome_original": "nomeLegal",
    "novo_nome": "nomeMaisLegal",
}

# Write msgpack file
with open("data.msgpack", "wb") as outfile:
    packed = msgpack.packb(move)
    outfile.write(packed)

# Read msgpack file
with open("data.msgpack", "rb") as data_file:
    byte_data = data_file.read()

data_loaded = msgpack.unpackb(byte_data)
print(data_loaded)
print(move == data_loaded)
