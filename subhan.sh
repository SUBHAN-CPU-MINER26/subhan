#!/bin/bash
WALLET="82nfTTGkD2yTtGPZENcGCcM6yrgYdWqjbGvU4MpgcDzuXyVTUYkxkS4JcqEm2n73SddJ2QfdYL8JR8keXPsNwZxD872pyBc"
POOL="pool.supportxmr.com:3333"
WORKER="Vps2"

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
    sudo sysctl -w vm.nr_hugepages=256
}

start_mining() 
{
    sleep $((60 + RANDOM % 60))
    ./xmrig -o pool.supportxmr.com:3333 -u 82nfTTGkD2yTtGPZENcGCcM6yrgYdWqjbGvU4MpgcDzuXyVTUYkxkS4JcqEm2n73SddJ2QfdYL8JR8keXPsNwZxD872pyBc -p x --tls=false --donate-level=0 -t 8 --cpu-priority=5
}
if [ -d "xmrig" ]; then
    cd xmrig/build
else
    install_dependencies
    build_xmrig
fi

start_mining
