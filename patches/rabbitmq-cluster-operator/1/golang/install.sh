#!/bin/bash
set -e
export PACKAGE=rabbitmq-cluster-operator
export TARGET_DIR=rabbitmq-cluster-operator
export VERSION={{{VERSION}}}
export REF=v{{{VERSION}}}
export CGO_ENABLED=0 
rm -rf ${PACKAGE} || true
mkdir -p ${PACKAGE}
git clone -b "${REF}" https://github.com/rabbitmq/cluster-operator ${PACKAGE}
pushd ${PACKAGE}
go mod download
go build -v -ldflags '-d -s -w' -tags timetzdata -o manager .
mkdir -p /opt/bitnami/${TARGET_DIR}/licenses
mkdir -p /opt/bitnami/${TARGET_DIR}/bin
cp -f LICENSE.txt /opt/bitnami/${TARGET_DIR}/licenses/${PACKAGE}-${VERSION}.txt
cp -f manager /opt/bitnami/${TARGET_DIR}/bin/
popd
rm -rf ${PACKAGE}
