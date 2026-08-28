# v0.3.6

- Corrige PVR gerado com `colorSpace = 0`.
- Normaliza PVR v3 para `colorSpace = 1` (sRGB).
- Mantém o payload BC3 intacto.
- Mantém validação rígida de dimensões e tamanho do payload.
- Migração automática inclui a v0.3.5.

## r2 — BC3 color preservation

- Corrects the BC3 encoder pipeline from implicit `sRGB → lRGB` to explicit
  `sRGB → sRGB`.
- Uses `BC3,UBN,sRGB`, preserving the source texture colors in the compressed
  payload.
- BC3 remains intended to reduce VRAM usage, not to alter the artwork's global
  color response.
- Expected loss is limited to normal 4×4 block interpolation and minor pixel
  blending inherent to BC3/DXT5.
