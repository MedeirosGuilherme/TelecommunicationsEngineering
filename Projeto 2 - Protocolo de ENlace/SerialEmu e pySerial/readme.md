# Usando o serialEmu

## 1. SerialEmu:

Pode ser encontrado aqui:
https://github.com/IFSCEngtelecomPTC/Serialemu

O código pode ser compilado utilizando 

```
g++ -o serialemu *.cpp -lpthread -lutil -std=c++11
```

Com o código compilado, para rodar, basta, no diretório onde o arquivo compilado se encontra, fazer:

```
./serialemu -B {taxa(9600)}
```

Ele irá retornar uma dupla de interfaces como:

```
/dev/pts/17 /dev/pts/2
```

Essas duas interfaces já estão em comunicação.



