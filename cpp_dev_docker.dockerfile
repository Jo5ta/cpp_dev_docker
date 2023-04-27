FROM archlinux:latest

USER root

RUN pacman -Syu --noconfirm \
    ;

RUN pacman -S --noconfirm \
    sudo\
    ;

RUN pacman -S --noconfirm  \
    git\
    git-lfs\
    curl\
    openssh\
    ;

RUN pacman -S --noconfirm \
    gcc\
    gdb\
    clang\
    lldb\
    ;

RUN pacman -S --noconfirm  \
    cmake\
    ninja\
    make\
    ;

RUN pacman -Sy --noconfirm \
    base-devel \
    flex \
    bison \
    bc \
    busybox \
    rsync \
    strace \
    cpio \
    qemu-base \
    ;

RUN pacman -S --noconfirm  \
    python\
    python-pip\
    ;

RUN pip install \
    numpy\
    scipy\
    pandas\
    matplotlib\
    ;

RUN pacman -S --noconfirm \
    libtar \
    sudo \
    vi \
    ;

RUN  \
    useradd -m cpp_dev_docker ;\
    passwd -d cpp_dev_docker ;\
    usermod -aG wheel cpp_dev_docker ;\
    sudo sed -i 's/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers ;\
    sudo sed -i 's/# %wheel ALL=(ALL:ALL)/%wheel ALL=(ALL:ALL)/g' /etc/sudoers ;\
    sudo sed -i 's/# %sudo ALL=(ALL:ALL)/%sudo ALL=(ALL:ALL)/g' /etc/sudoers ;

USER cpp_dev_docker
