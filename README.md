# libc_changer
forked from  
https://gist.github.com/tachibana51/a89a748eaebc8b080eb0b46c35233e0d  
Patch the binary to work with any version of glibc  
## Install  
### Required Tools
* docker
* patchelf

## Usage
### Patch any version of glibc
`libc_changer <elf-file> [ubuntu-version] [glibc-version]`  
e.g.  
`libc_changer ./chall 18.04 2.27`  
### Patch local glibc  
`libc_changer <elf-file> [ubuntu-version] --local <libc-file>`  
e.g.  
`libc_changer ./chall 18.04 --local ./libc-2.27.so`   
### Patch 32bit glibc  
Add `-m32` option to args  
e.g.  
`libc_changer ./chall_32 18.04 2.27 -m32`  
