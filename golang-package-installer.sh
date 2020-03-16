#!/bin/bash

mirror_package=(
  tools
  mobile
  crypto
  net
  tour
  text
  playground
  vgo
  lint
  sync
  exp
  image
  time
  debug
  arch
  sys
  perf
  build
  review
  scratch
  mod
  dl
)

declare -A package_source=()

for package in ${mirror_package[@]}
do
  package_source[$package]="https://github.com/golang/$package"
done

usage="golang/x/... package installer
usage:

  install all package:
  ./golang-package-installer.sh -all

  install single package:
  ./golang-package-installer.sh golang.org/x/tools

  install single package with short name:
  ./golang-package-installer.sh tools"

install_package() {
  cpwd=$(pwd)
  package=$(echo "$1" | awk -F '/' '{print $NF}')
  if [ -z "${package_source[${package}]}" ]; then
    echo "unsupported package: $1"
    exit 2
  fi
  if [ -d "${GOPATH}/src/golang.org/x/${package}" ]; then
    rm -rf "${GOPATH}/src/golang.org/x/${package}"
  fi
  if [ ! -d "${GOPATH}/src/golang.org/x" ]; then
    mkdir -p "${GOPATH}/src/golang.org/x"
  fi
  cd "${GOPATH}/src/golang.org/x" || exit 1
  remote="${package_source[${package}]}"
  git clone "${remote}"
  cd "${cpwd}" || exit 1
}

case $1 in
  -all)
    for package in ${mirror_package[@]}
    do
      install_package "${package}"
    done
  ;;
  ""|-h|--help)
    echo "${usage}"
    if [ "$1" == "" ]; then
      exit 2
    fi
  ;;
  *)
    install_package "$1"
  ;;
esac