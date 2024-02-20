FROM --platform=linux/amd64 archlinux

# Update package repositories and install required dependencies
RUN pacman -Sy --noconfirm && \
    pacman -S --noconfirm base-devel git

RUN pacman -S --needed --noconfirm sudo # Install sudo
RUN useradd builduser -m # Create the builduser
RUN passwd -d builduser # Delete the buildusers password
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers # Allow the builduser passwordless sudo
RUN sudo -u builduser bash -c 'cd ~ && git clone https://aur.archlinux.org/paru.git some-pkgbuild && cd some-pkgbuild && makepkg -si --noconfirm'
# RUN sudo -u builduser bash -c 'cd ~ && https://aur.archlinux.org/ns.git'
ADD src /home/builduser/ns
RUN chown -R builduser /home/builduser/ns 
RUN sudo -u builduser bash -c 'cd ~ && cd ns && paru -B -i .'

CMD sudo -u builduser /bin/sh
