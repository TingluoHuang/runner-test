FROM ubuntu:18.04
LABEL maintainer="tingluohuang@github.com"

ARG RUNNER_REPO
ARG RUNNER_TOKEN

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y curl \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /github/home/actions-runner && cd /github/home/actions-runner
RUN curl -O https://github.com/actions/runner/releases/download/v2.164.0/actions-runner-linux-x64-2.164.0.tar.gz
RUN tar xzf ./actions-runner-linux-x64-2.164.0.tar.gz

RUN ./config.sh --url $RUNNER_REPO --token $RUNNER_TOKEN --unattended --replace

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
