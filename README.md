# libc_changer
forked from  
https://gist.github.com/tachibana51/a89a748eaebc8b080eb0b46c35233e0d  
## Usage
### patch any version of glibc
`libc_changer <elf-file> [ubuntu-version] [glibc-version]`  
e.g.  
`libc_changer ./chall 18.04 2.27`  
### patch local glibc  
`libc_changer <elf-file> [ubuntu-version] --local <libc-file>`  
e.g.  
`libc_changer ./chall 18.04 --local ./libc-2.27.so`   
