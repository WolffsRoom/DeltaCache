# Runtime Texture Selection — v0.3

O pacote possui R444 e BC3 para toda Texture Page.

Estrutura de um capítulo:

```text
chapterN\
├─ data.win
├─ texture-cache\
│  └─ page_NNN.r444
└─ pvr\
   └─ page_NNN.bc3.pvr
```

Política:

```c
switch (texture_compression_mode) {
    case TEXTURE_COMPRESSION_NONE:
        use_bc3 = false;
        break;

    case TEXTURE_COMPRESSION_OPTIMIZED:
        use_bc3 = (width == 2048 && height == 2048);
        break;

    case TEXTURE_COMPRESSION_AGGRESSIVE:
        use_bc3 = true;
        break;
}
```

Fallback sugerido:

```text
preferência escolhida
   ↓
arquivo válido?
   ├─ sim → carrega
   └─ não → tenta representação alternativa
                 ↓
             indisponível?
                 ↓
             data.win
```

Ao trocar o modo durante o jogo, invalide/libere as texturas GPU residentes
para que sejam recriadas no novo formato. Não é necessário apagar os caches.
