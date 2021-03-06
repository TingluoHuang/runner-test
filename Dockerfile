FROM ubuntu:18.04
LABEL maintainer="tingluohuang@github.com"

ARG RUNNER_REPO
ARG RUNNER_TOKEN

ENV RUNNER_ALLOW_RUNASROOT=1

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y curl \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /actions-runner
RUN cd /actions-runner && curl -O -L https://github.com/actions/runner/releases/download/v2.164.0/actions-runner-linux-x64-2.164.0.tar.gz
RUN cd /actions-runner && tar xzf ./actions-runner-linux-x64-2.164.0.tar.gz

RUN cd /actions-runner && ./bin/installdependencies.sh && ./config.sh --url $RUNNER_REPO --token $RUNNER_TOKEN --unattended --replace

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
