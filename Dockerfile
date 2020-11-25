FROM alpine:3
WORKDIR /usr/local/bin/
RUN apk add --no-cache bash curl openssl openssh-client jq py3-pip
RUN pip3 install yq
RUN curl -sSLo ./kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN curl -sSLo ./kind $(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4)
RUN curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
RUN curl -sSL https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
COPY --from=docker /usr/local/bin/docker /usr/local/bin/
COPY --from=docker/compose:1.27.4 /usr/local/bin/docker-compose /usr/local/bin/
RUN chmod a+x *

ENV INIT_DIR=/initialized
VOLUME $INIT_DIR
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "docker-entrypoint.sh" ]
