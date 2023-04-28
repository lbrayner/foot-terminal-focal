FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install \
        git \
        python3-pip \
        build-essential \
        pkg-config \
        bison \
        libxcb-xkb-dev \
        libxml2-dev \
        wayland-protocols \
        libwayland-dev \
        libpixman-1-dev \
        libfontconfig1-dev

RUN pip3 install --upgrade pip && pip3 install meson ninja

RUN git clone https://github.com/xkbcommon/libxkbcommon /libxkbcommon

WORKDIR /libxkbcommon

RUN meson setup build -Denable-docs=false && ninja -C build && meson install -C build

RUN git clone https://github.com/lbrayner/foot /foot && mkdir /foot/build

WORKDIR /foot

# https://codeberg.org/dnkl/foot/pulls/1099
RUN git checkout -b add-extended-underlines origin/add-extended-underlines

RUN ./pgo/pgo.sh auto . build -Dext-underline=true
