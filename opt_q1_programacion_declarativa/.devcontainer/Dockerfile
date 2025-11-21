FROM debian:bookworm-slim

# Variables de entorno
ENV DEBIAN_FRONTEND=noninteractive
ENV GHCUP_INSTALL_BASE_PREFIX=/root
ENV PATH=/root/.ghcup/bin:$PATH

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libffi-dev \
    libgmp-dev \
    libncurses-dev \
    libtinfo-dev \
    zlib1g-dev \
    git \
    wget \
    vim \
    procps \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Instalar GHCup (gestor de versiones de GHC, Cabal, Stack, HLS)
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
    BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_GHC_VERSION=9.4.8 \
    BOOTSTRAP_HASKELL_CABAL_VERSION=recommended \
    BOOTSTRAP_HASKELL_INSTALL_STACK=1 \
    BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
    sh

# Configurar PATH para shells interactivos
RUN echo 'export PATH="$HOME/.ghcup/bin:$PATH"' >> /root/.bashrc

# Pre-instalar dependencias comunes (opcional, acelera el primer build)
RUN stack config set system-ghc --global true

# Directorio de trabajo
WORKDIR /workspace

# Exponer puertos comunes
EXPOSE 8080 3000

CMD ["/bin/bash"]