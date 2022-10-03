ARG NODE_VERSION=14.20.0

FROM node:${NODE_VERSION}
RUN apt-get update && apt-get install -y libsecret-1-dev
ARG version=latest
WORKDIR /home/theia
ADD $version.package.json ./package.json
ARG GITHUB_TOKEN
RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean

FROM node:${NODE_VERSION}

# Install Python 3 from source
ARG VERSION=3.8.10

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y make build-essential libssl-dev \
    && apt-get install -y libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    && apt-get install -y libncurses5-dev  libncursesw5-dev xz-utils tk-dev \
    && wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz \
    && tar xvf Python-$VERSION.tgz \
    && cd Python-$VERSION \
    && ./configure \
    && make -j8 \
    && make install \
    && cd .. \
    && rm -rf Python-$VERSION \
    && rm Python-$VERSION.tgz

ADD python/requirements.txt /tmp/

RUN apt-get update \
    && apt-get install -y libsecret-1-0 \
    && apt-get install -y python3-dev python3-pip \
    && apt-get install -y sshpass ncat \
    && pip3 install --upgrade pip \
    && pip3 install python-language-server flake8 autopep8 \
    && apt-get install -y yarn \
    \
    && pip3 install -r /tmp/requirements.txt \
    && apt-get upgrade -yq --no-install-recommends \
                    ca-certificates \
                    openssl \
    && update-alternatives --install /usr/bin/python python /usr/local/bin/python3.8 99 \
    \
    && apt-get purge make build-essential -y \
    && apt-get clean \
    && apt-get auto-remove -y \
    && rm -rf /var/cache/apt/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    \
    && mkdir -p /home/theia \
    && mkdir -p /home/project

ENV HOME /home/theia
WORKDIR /home/theia
COPY --from=0 /home/theia /home/theia

ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins \
    USE_LOCAL_GIT=true \
    TZ="Asia/Taipei"

# Expose ports
EXPOSE 3000
HEALTHCHECK --interval=300s --timeout=3s CMD curl -fs http://localhost:3000 || exit 1

RUN addgroup theia \
    && adduser --ingroup theia --disabled-password --gecos "" --no-create-home theia \
    && chown -R theia:theia /home/theia \
    && chown -R theia:theia /home/project \
    && echo 'export PS1="# "' >> /home/theia/.bashrc
USER theia

COPY docker-entrypoint.sh docker-entrypoint.sh
CMD bash
ENTRYPOINT ./docker-entrypoint.sh