#!/bin/bash
set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

SRC_DIR=${DIR}/..
BIN_DIR=${HOME}/bin

curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o ${BIN_DIR}/kubectl
chmod +x ${BIN_DIR}/kubectl

ISTIO_VERSION=0.1.6
ISTIO=istio-${ISTIO_VERSION}

curl -L https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/${ISTIO}-linux.tar.gz -o /tmp/istio.tar.gz
tar --no-overwrite-dir -C /tmp -xzf /tmp/istio.tar.gz
mv /tmp/${ISTIO}/bin/istioctl ${HOME}/bin
chmod +x ${BIN_DIR}/istioctl
