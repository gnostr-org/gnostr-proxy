push:## 	push.yml
	$(MAKE) docker-start
	act $(VERBOSE) $(BIND) $(REUSE) -W .github/workflows/$@.yml
#NOTE: using -C for container context
ubuntu-matrix:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
macos-matrix:## 	
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vr -W $(PWD)/.github/workflows/$@.yml
	
	
alpine:## 	alpine act sequence
## alpine act sequence
## 	additional help example
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vb -W $(PWD)/.github/workflows/$@.yml
archlinux:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
centos:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
cygwin:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
debian:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
fedora:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
freebsd:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
gentoo:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
macos:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
manjaro:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
mint:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
msys2:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
netbsd:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
openbsd:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
opensuse-leap:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
static:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
ubuntu:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
voidlinux-glibc:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml
voidlinux-musl:## 	
	@touch ~/GH_TOKEN.txt
	@export $(cat ~/GH_TOKEN.txt) && act -C $(PWD) -vbr -W $(PWD)/.github/workflows/$@.yml

# vim: set noexpandtab:
# vim: set setfiletype make
