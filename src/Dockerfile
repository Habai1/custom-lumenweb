FROM debian:trixie-slim
LABEL authors="david1117dev"

RUN apt-get update && \
    apt-get install -y \
        bash \
        curl \
        wget \
        gnupg \
        ca-certificates \
        unzip \
        lsb-release \
        git \
        dnsutils \
        jq \
        nginx \
        build-essential \
        libssl-dev \
        libssl3 \
        python3 \
        openssl \
        passwd \
        openjdk-21-jdk-headless \
        openjdk-25-jdk-headless \
        fontconfig \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://packages.sury.org/php/apt.gpg | tee /etc/apt/trusted.gpg.d/php-sury.gpg >/dev/null && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php-sury.list && \
    apt-get update && \
    apt-get install -y \
        php7.4 php7.4-cli php7.4-fpm php7.4-common php7.4-mbstring php7.4-xml php7.4-mysql php7.4-gd php7.4-zip php7.4-intl php7.4-bcmath \
        php8.0 php8.0-cli php8.0-fpm php8.0-common php8.0-mbstring php8.0-xml php8.0-mysql php8.0-gd php8.0-zip php8.0-curl php8.0-intl php8.0-bcmath \
        php8.1 php8.1-cli php8.1-fpm php8.1-common php8.1-mbstring php8.1-xml php8.1-mysql php8.1-gd php8.1-zip php8.1-curl php8.1-intl php8.1-bcmath \
        php8.2 php8.2-cli php8.2-fpm php8.2-common php8.2-mbstring php8.2-xml php8.2-mysql php8.2-gd php8.2-zip php8.2-curl php8.2-intl php8.2-bcmath \
        php8.3 php8.3-cli php8.3-fpm php8.3-common php8.3-mbstring php8.3-xml php8.3-mysql php8.3-gd php8.3-zip php8.3-curl php8.3-intl php8.3-bcmath \
        php8.4 php8.4-cli php8.4-fpm php8.4-common php8.4-mbstring php8.4-xml php8.4-mysql php8.4-gd php8.4-zip php8.4-curl php8.4-intl php8.4-bcmath \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN curl -fsSL https://deb.nodesource.com/setup_25.x | sh - \
 && apt-get install -y nodejs

ENV NPM_CONFIG_PREFIX=/usr/local/lumenweb
ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH
RUN npm install --force -g pnpm yarn bun serve

COPY lib /static
COPY default /static/default
COPY --chmod=+x entrypoint.sh /lumenweb

RUN useradd -m -u 999 -d /home/container -s /bin/bash container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container


CMD ["/lumenweb"]
