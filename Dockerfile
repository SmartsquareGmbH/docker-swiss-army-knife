FROM alpine:3.14 as builder
RUN apk add --no-cache cargo git openssl-dev

RUN mkdir -p /opt/dog
WORKDIR /opt/dog

RUN git clone https://github.com/ogham/dog . && git checkout v0.1.0
RUN cargo build --release



FROM alpine:3.14 as privileged
LABEL org.opencontainers.image.source https://github.com/SmartsquareGmbH/docker-swiss-army-knife/

RUN apk add --no-cache \
    bash \
    bind-tools \
    curl \
    jq \
    tcptraceroute \
    dnstracer \
    paris-traceroute \
    apache2-utils \
    tcpdump \
    socat \
    netcat-openbsd \
    openssl \
    libgcc \
    libcap \
    python3

COPY --from=builder /opt/dog/target/release/dog /usr/bin/dog

RUN cd /usr/bin \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.22.0/bin/linux/amd64/kubectl \
    && chmod +x kubectl

RUN mkdir -p /opt/jc && python3 -m venv /opt/jc && /opt/jc/bin/python3 -m ensurepip --upgrade
RUN /opt/jc/bin/pip3 install jc && ln -s /opt/jc/bin/jc /usr/bin/jc

ENTRYPOINT [ "/bin/bash" ]



FROM privileged AS unprivileged

RUN for bin in ping traceroute traceroute6 tcpdump paris-traceroute; do \
    setcap cap_net_raw=eip $(readlink -f $(which $bin)); \
    done

RUN adduser -D user
USER user