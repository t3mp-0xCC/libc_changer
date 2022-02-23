#!/bin/bash

function info {
  # show info
  echo -e "\e[32m[test]\e[m $1"
}

function error {
  echo -e "\e[31m[fail]\e[m $1" >&2
}

function check {
  # check test result
  # $1=command, $2=expected_output
  if [ "$1" = "$2" ]; then
    info "Passeed !"
  else
    error "Failed !"
  fi
}

function test_template {
  # test_template <info msg> <bin name> <cmd>
  info $1
  gcc test.c -o $2
  bash $3
  check `./$2` "works"
}

# init
cp ../libc_changer .

# test template
# 1. show test name
# 2. patch
# 3. check if the program works
# 4. check linked glibc version

# 64bit glibc 2.31 test
test_template "64bit glibc 2.31 test" "./test_64bit_231"  "./libc_changer ./test_64bit_231 20.04 2.31"
rm -f ./libc.so.6

# 64bit glibc 2.31 local test
test_template "64bit glibc 2.31 local test" "./test_64bit_231_local"  "./libc_changer ./test_64bit_231_local 20.04 --local ./libc-2.31_64.so"
rm -f ./libc.so.6

# 32bit glibc 2.31 test
test_template "32bit glibc 2.31 test" "./test_32bit_231"  "./libc_changer ./test_32bit_231 20.04 2.31 -m32"
rm -f ./libc.so.6

# 32bit glibc 2.31 local test
test_template "32bit glibc 2.31 local test" "./test_32bit_231_local"  "./libc_changer ./test_32bit_231 20.04 --local ./libc-2.31_32.so"
rm -f ./libc.so.6

# clear
rm -f ./test_*
rm -f ./libc.so.6
rm -rf ./.debug
rm -f ./ld-*
rm -f ./libc_changer
