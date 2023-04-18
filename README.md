Build foot:

```bash
docker build -t foot-terminal-focal .
```

Prepare environment for libxkbcommon in /usr/local:

```bash
cd /usr/share/X11 && sudo -u gdm rsync -rRltu xkb /var/lib/gdm3/.config
echo "XKB_CONFIG_ROOT=/usr/share/X11/xkb" >> ~/.pam_environment
```

Install libxkbcommon:

```bash
docker run -it --rm -v /:/destdir foot-terminal-focal bash -c \
    'cd /libxkbcommon && DESTDIR=/destdir meson install -C build'
```

Reload the ld cache:

```bash
sudo ldconfig -v
```

Install foot:

```bash
docker run -it --rm -v /:/destdir foot-terminal-focal bash -c \
    'cd /foot && DESTDIR=/destdir meson install -C build'
cd /usr/local/share/terminfo && sudo rsync -rRtu f /etc/terminfo
```
