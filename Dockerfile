FROM alpine:3 AS build
WORKDIR /usr/local/bin/
RUN apk add --no-cache bash curl openssl
RUN curl -sSLO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
RUN curl -sSL https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
RUN curl -sSLo ./kind https://kind.sigs.k8s.io/dl/v0.8.1/kind-linux-amd64
RUN chmod a+x *

FROM alpine:3
COPY --from=build /usr/local/bin/* /usr/local/bin/
RUN apk add --no-cache docker-cli docker-compose jq py3-pip
RUN pip3 install yq
ENV INIT_DIR=/initialized
VOLUME $INIT_DIR
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]
