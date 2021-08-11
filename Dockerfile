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
    libgcc

COPY --from=builder /opt/dog/target/release/dog /usr/bin/dog

RUN cd /usr/bin \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.22.0/bin/linux/amd64/kubectl \
    && chmod +x kubectl

ENTRYPOINT [ "/bin/bash" ]



FROM privileged AS unprivileged
RUN adduser -D user
USER user