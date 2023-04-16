```bash
docker build -t foot-terminal-focal .
docker run -it --rm -v /:/destdir foot-terminal-focal bash -c 'cd /libxkbcommon && DESTDIR=/destdir meson install -C build'
docker run -it --rm -v /:/destdir foot-terminal-focal bash -c 'cd /foot && DESTDIR=/destdir meson install -C build'
```
