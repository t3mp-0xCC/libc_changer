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
    result+=("passed")
  else
    error "Failed !"
    result+=("failed")
  fi
}

function test_template {
  # test_template <info msg> <bin name> <cmd>
  info $1
  test_name+=($1)
  # make test directory
  mkdir $1
  cd $1
  gcc ../test.c -o $2
  ln -s ../libc_changer .
  ln -s ../libc-2.31_64.so
  ln -s ../libc-2.31_32.so
  bash $3
  check `./$2` "works"
  let ++count
  cd ..
}

# init
cp ../libc_changer .
## test counter
count=0
## array of result
result=()
## array of test name
test_name=()
## clean or not flag
clean=1

if [ "$1" = "-nc" ]; then
  clean=0
  info "cleaning: disable"
fi

# test template
# 1. show test name
# 2. patch
# 3. check if the program works
# 4. check linked glibc version

# 64bit glibc 2.31 test
test_template "test_64bit_glibc_2.31" "./test_64bit_231"  "./libc_changer ./test_64bit_231 20.04 2.31"
rm -f ./libc.so.6

# 64bit glibc 2.31 local test
test_template "test_64bit_glibc_2.31_local" "./test_64bit_231_local"  "./libc_changer ./test_64bit_231_local 20.04 --local ./libc-2.31_64.so"
rm -f ./libc.so.6

# 32bit glibc 2.31 test
test_template "test_32bit_glibc_2.31" "./test_32bit_231"  "./libc_changer ./test_32bit_231 20.04 2.31 -m32"
rm -f ./libc.so.6

# 32bit glibc 2.31 local test
test_template "test_32bit_glibc_2.31_local" "./test_32bit_231_local"  "./libc_changer ./test_32bit_231 20.04 --local ./libc-2.31_32.so"
rm -f ./libc.so.6

# clear
if [ "$clean" =  "1" ]; then
  echo info "cleaning..."
  ./clean.sh
fi

# result
info "result"
echo "===== result ====="
for ((i=1; i<=count; i++))
do
  echo "${test_name[${i}-1]}"
  echo "${result[${i}-1]}"
done
