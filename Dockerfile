FROM ubuntu

WORKDIR /edit

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME /edit

RUN apt-get update -y
RUN apt-get install -y vim neovim git

# install pyenv
RUN git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
# dependencise
RUN apt-get install -y \
     make \
     build-essential \
     libssl-dev \
     zlib1g-dev \
     libbz2-dev \
     libreadline-dev \
     libsqlite3-dev \
     wget \
     curl \
     llvm \
     libncurses5-dev \
     libncursesw5-dev \
     xz-utils \
     tk-dev \
     libffi-dev \
     liblzma-dev \
     python-openssl \
     vim-gnome

# install python
RUN export PYENV_ROOT="$HOME/.pyenv" && \
export PATH="$PYENV_ROOT/bin:$PATH" && \
export CFLAGS='-O2' && \
eval "$(pyenv init -)" && \
pyenv install 2.7.16 && \
pyenv global 2.7.16 && \
pip install --upgrade pip && \
pyenv rehash && \
pip install neovim pynvim && \
pyenv install 3.7.3 && \
pyenv global 3.7.3 && \
pip install --upgrade pip && \
pyenv rehash && \
pip install neovim pynvim

# vim conf
RUN mkdir $HOME/.config
RUN mkdir $HOME/.config/nvim
COPY ./nvim/ $HOME/.config/nvim/
