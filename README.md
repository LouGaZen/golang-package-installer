# golang-package-installer

 A script to install golang/x/... packages from [github mirror](https://github.com/golang?q=%5Bmirror%5D&type=&language=)

## Usage

```bash
# require bash version >= 4.1.2
install all package:
./golang-package-installer.sh -all

install single package:
./golang-package-installer.sh golang.org/x/tools

install single package with short name:
./golang-package-installer.sh tools
```

## TODO

- [ ] support multi package in single command
