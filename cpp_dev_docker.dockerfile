FROM archlinux:latest

USER root

RUN pacman -Syu --noconfirm\
    ;

RUN pacman -S --noconfirm\
    sudo\
    ;

RUN pacman -S --noconfirm\
    git\
    git-lfs\
    curl\
    openssh\
    ;

RUN pacman -S --noconfirm\
    gcc\
    gdb\
    clang\
    lldb\
    ;

RUN pacman -S --noconfirm\
    cmake\
    ninja\
    make\
    ;

RUN \
    pacman -S --noconfirm bash-completion

RUN\
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git &&\
    make -C ble.sh install PREFIX=/usr/local/ &&\
    echo 'source /usr/local/share/blesh/ble.sh' >> /etc/bash.bashrc ;

RUN pacman -Sy --noconfirm\
    base-devel\
    flex\
    bison\
    bc\
    busybox\
    rsync\
    strace\
    cpio\
    qemu-base\
    ;

RUN pacman -Sy --noconfirm\
    python\
    python-pip\
    ;

RUN pacman -Sy --noconfirm\
    python-numpy\
    python-scipy\
    python-pandas\
    python-matplotlib\
    ;

RUN pip install --break-system-packages\
    robotframework\
    ;

RUN pacman -Sy --noconfirm\
    libtar\
    sudo\
    vi\
    ;

RUN pacman -Sy --noconfirm\
    rustup\
    ;

RUN\
    useradd -m cpp_dev_docker &&\
    passwd -d cpp_dev_docker &&\
    usermod -aG wheel cpp_dev_docker &&\
    sudo sed -i 's/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers &&\
    sudo sed -i 's/# %wheel ALL=(ALL:ALL)/%wheel ALL=(ALL:ALL)/g' /etc/sudoers &&\
    sudo sed -i 's/# %sudo ALL=(ALL:ALL)/%sudo ALL=(ALL:ALL)/g' /etc/sudoers ;

USER cpp_dev_docker
