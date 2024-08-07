SHELL                                   := /bin/bash
PWD                                     ?= pwd_unknown
TIME                                    := $(shell date +%s)
export TIME

OS                                      :=$(shell uname -s)
export OS
OS_VERSION                              :=$(shell uname -r)
export OS_VERSION
ARCH                                    :=$(shell uname -m)
export ARCH
ifeq ($(ARCH),x86_64)
TRIPLET                                 :=x86_64-linux-gnu
export TRIPLET
endif
ifeq ($(ARCH),arm64)
TRIPLET                                 :=aarch64-linux-gnu
export TRIPLET
endif
ifeq ($(ARCH),arm64)
TRIPLET                                 :=aarch64-linux-gnu
export TRIPLET
endif

HOMEBREW                                := $(shell type -P brew)
export HOMEBREW

PYTHON                                  := $(shell which python)
export PYTHON
PYTHON2                                 := $(shell which python2)
export PYTHON2
PYTHON3                                 := $(shell which python3)
ifeq ($(PYTHON3),)
PYTHON3                                 :=$(shell which python)
endif
export PYTHON3

PIP                                     := $(notdir $(shell which pip))
export PIP
PIP2                                    := $(notdir $(shell which pip2))
export PIP2
PIP3                                    := $(notdir $(shell which pip3))
export PIP3

ifeq ($(PYTHON3),/usr/local/bin/python3)
PIP                                    := pip
PIP3                                   := pip
export PIP
export PIP3
endif

#detect python
PYTHON_ENV                              = $(shell python -c "import sys; sys.stdout.write('1')  if hasattr(sys, 'base_prefix') else sys.stdout.write('0')" 2>/dev/null)
#detect python3
PYTHON3_ENV                             = $(shell python3 -c "import sys; sys.stdout.write('1') if hasattr(sys, 'base_prefix') else sys.stdout.write('0')")
export PYTHON_ENV
export PYTHON3_ENV

ifeq ($(PYTHON_ENV),1)
#likely in virtualenv
PYTHON_VENV                             := $(shell python -c "import sys; sys.stdout.write('1') if sys.prefix != sys.base_prefix else sys.stdout.write('0')" 2>/dev/null)
endif
export PYTHON_VENV

ifeq ($(PYTHON_VENV),1)
PYTHON3_VENV                            := $(shell python3 -c "import sys; sys.stdout.write('1') if sys.prefix != sys.base_prefix else sys.stdout.write('0')")
else
PYTHON_VENV                             :=$(PYTHON_ENV)
PYTHON3_VENV                            :=$(PYTHON3_ENV)
endif
export PYTHON3_VENV

ifeq ($(PYTHON_VENV),0)
USER_FLAG                               :=--user
else
USER_FLAG                               :=
endif

ifeq ($(project),)
PROJECT_NAME                            := $(notdir $(PWD))
else
PROJECT_NAME                            := $(project)
endif
export PROJECT_NAME

GIT_USER_NAME                           := $(shell git config user.name || echo $(PROJECT_NAME))
export GIT_USER_NAME
GH_USER_NAME                            := $(shell git config user.name || echo $(PROJECT_NAME))
ifneq ($(ghuser),)
GH_USER_NAME := $(ghuser)
endif
export GIT_USER_NAME

GIT_USER_EMAIL                          := $(shell git config user.email || echo $(PROJECT_NAME))
export GIT_USER_EMAIL
GIT_SERVER                              := https://github.com
export GIT_SERVER
GIT_SSH_SERVER                          := git@github.com
export GIT_SSH_SERVER
GIT_PROFILE                             := $(shell git config user.name || echo $(PROJECT_NAME))
export GIT_PROFILE
GIT_BRANCH                              := $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null || echo $(PROJECT_NAME))
export GIT_BRANCH
GIT_HASH                                := $(shell git rev-parse --short HEAD 2>/dev/null || echo $(PROJECT_NAME))
export GIT_HASH
GIT_PREVIOUS_HASH                       := $(shell git rev-parse --short master@{1} 2>/dev/null || echo $(PROJECT_NAME))
export GIT_PREVIOUS_HASH
GIT_REPO_ORIGIN                         := $(shell git remote get-url origin 2>/dev/null || echo $(PROJECT_NAME))
export GIT_REPO_ORIGIN
GIT_REPO_NAME                           := $(PROJECT_NAME)
export GIT_REPO_NAME
GIT_REPO_PATH                           := $(HOME)/$(GIT_REPO_NAME)
export GIT_REPO_PATH

##TODO: make this more dynamic yet robust
RELAYS                                  =$(shell cat .relays)
export RELAYS


NODE_VERSION                            :=v18.17.1
export NODE_VERSION
NODE_ALIAS                              :=v18.17.0
export NODE_ALIAS
NVM_DIR                                 :=$(HOME)/.nvm
export NVM_DIR
PNPM_VERSION                            :=8.6.7
export PNPM_VERSION

#PACKAGE_MANAGER                         :=yarn
#export PACKAGE_MANAGER
#PACKAGE_INSTALL                         :=add
#export PACKAGE_INSTALL

-:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
## help

.PHONY: init
.ONESHELL:
	@touch requirements.txt
init:initialize venv##	initialize venv
## init
	@echo $(PYTHON)
	@echo $(PYTHON2)
	@echo $(PYTHON3)
	@echo $(PIP)
	@echo $(PIP2)
	@echo $(PIP3)
	@echo PATH=$(PATH):/usr/local/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin
	@echo PATH=$(PATH):$(HOME)/Library/Python/3.10/bin
	test -d .venv || $(PYTHON3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; $(PIP) install -q -r requirements.txt; \
	   $(PYTHON3) -m $(PIP) install $(USER_FLAG) --upgrade pip; \
	   $(PYTHON3) -m $(PIP) install $(USER_FLAG) -r requirements.txt; \
	   $(PIP) install -q --upgrade pip; \
	);
	( \
	    while ! docker system info > /dev/null 2>&1; do\
	    echo 'Waiting for docker to start...';\
	    if [[ '$(OS)' == 'Linux' ]]; then\
	     type -P systemctl && systemctl restart docker.service || type -P apk && apk add openrc docker && rc-service docker restart;\
	    fi;\
	    if [[ '$(OS)' == 'Darwin' ]]; then\
	     open --background -a /./Applications/Docker.app/Contents/MacOS/Docker;\
	    fi;\
	sleep 1;\
	done\
	)
	@bash -c ". .venv/bin/activate &"

help:## 	verbose help
	@sed -n 's/^## //p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
.ONESHELL:
env:
	git update-index --assume-unchanged public/assets/entrypoints.json public/assets/manifest.json
	@echo -e "PORT=6102"                                 >.env
	@echo -e "HOST=0.0.0.0"                             >>.env
	@echo -e "NODE_ENV=development"                     >>.env
	@echo -e "APP_KEY=UgSS9o_p04BZ0duSOyJ1kz6TjlTXoOaE" >>.env
	@echo -e "DRIVE_DISK=local"                         >>.env
	@echo -e "SESSION_DRIVER=cookie"                    >>.env
	@echo -e "CACHE_VIEWS=false"                        >>.env
	@echo -e "PROXY_URL=ws://127.0.0.1:6102"            >>.env
	@echo RELAYS=$(RELAYS)                              >>.env
	@git update-index --assume-unchanged .env
	@git update-index --assume-unchanged APP_KEY
#@cat .env > .env.example
.PHONY:pnpm
pnpm: nvm
	@$(shell echo node ace generate:key) | sed 's/>.*//' > APP_KEY && cat APP_KEY
	@curl -fsSL https://get.pnpm.io/install.sh | sh - || echo "pnpm install script failed"
	@npm i --global yarn  --force && which yarn || echo "yarn not found"
	@npm i --global pnpm  --force && which pnpm || echo "pnpm not found"
	exec bash
	@pnpm install reflect-metadata || echo "pnpm install reflect-metadata failed"
	@pnpm install pino-pretty || echo "pnpm install pino-pretty failed"
	@pnpm install @adonisjs/core/build/standalone || echo "pnpm install @adonisjs/core/build/standalone failed..."

run: pnpm env## 	gnostr-proxy
	@pnpm install && pnpm run dev #&
run-dev:run## 	run-dev
run-production:## 	run-production
	@npm run build && install .env build/ && cd build && pnpm install --prod && node server.js
lynx-dump:
	@type -P lynx && lynx -dump -nolist http://127.0.0.1:6102 || echo #&& \
    #make lynx-dump | jq -R

install:pnpm env## 	install
	@install gnostr-proxy /usr/local/bin/

.PHONY: report
report:## 	report
## report
	@echo ''
	@echo '[ENV VARIABLES]	'
	@echo ''
	@echo 'HOME=${HOME}'
	@echo ''
	@echo 'TIME=${TIME}'
	@echo 'BASENAME=${BASENAME}'
	@echo 'PROJECT_NAME=${PROJECT_NAME}'
	@echo ''
	@echo 'PYTHON_ENV=${PYTHON_ENV}'
	@echo 'PYTHON3_ENV=${PYTHON3_ENV}'
	@echo ''
	@echo 'PYTHON_VENV=${PYTHON_VENV}'
	@echo 'PYTHON3_VENV=${PYTHON3_VENV}'
	@echo ''
	@echo 'PYTHON=${PYTHON}'
	@echo 'PIP=${PIP}'
	@echo 'PYTHON2=${PYTHON2}'
	@echo 'PIP2=${PIP2}'
	@echo 'PYTHON3=${PYTHON3}'
	@echo 'PIP3=${PIP3}'
	@echo ''
	@echo 'NODE_VERSION=${NODE_VERSION}'
	@echo 'NODE_ALIAS=${NODE_ALIAS}'
	@echo 'PNPM_VERSION=${PNPM_VERSION}'
	@echo ''
	@echo 'HOMEBREW=${HOMEBREW}'
	@echo ''
	@echo 'GIT_USER_NAME=${GIT_USER_NAME}'
	@echo 'GH_USER_REPO=${GH_USER_REPO}'
	@echo 'GH_USER_SPECIAL_REPO=${GH_USER_SPECIAL_REPO}'
	@echo 'GIT_USER_EMAIL=${GIT_USER_EMAIL}'
	@echo 'GIT_SERVER=${GIT_SERVER}'
	@echo 'GIT_PROFILE=${GIT_PROFILE}'
	@echo 'GIT_BRANCH=${GIT_BRANCH}'
	@echo 'GIT_HASH=${GIT_HASH}'
	@echo 'GIT_PREVIOUS_HASH=${GIT_PREVIOUS_HASH}'
	@echo 'GIT_REPO_ORIGIN=${GIT_REPO_ORIGIN}'
	@echo 'GIT_REPO_NAME=${GIT_REPO_NAME}'
	@echo 'GIT_REPO_PATH=${GIT_REPO_PATH}'

.PHONY: super
.ONESHELL:
super:
ifneq ($(shell id -u),0)
	@echo switch to superuser
	@echo cd $(TARGET_DIR)
	sudo -s
endif

checkbrew:##
## checkbrew
ifeq ($(HOMEBREW),)
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && $(MAKE) success || $(MAKE) failure
else
	@type -P brew && $(MAKE) success || $(MAKE) failure
endif

submodules:## 	submodules
## submodules
	git submodule update --init --recursive
	git submodule foreach --recursive "git submodule update --init; git fetch --all --tags"

.ONESHELL:
docker-start:
## docker-start
	touch requirements.txt && $(PYTHON3) -m ensurepip --user && \
    $(PYTHON3) -m pip install -U -q -r requirements.txt
	test -d .venv || $(PYTHON3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; $(PYTHON3) -m pip install -U -q -r requirements.txt; \
	   $(PYTHON3) -m pip install -U -q --upgrade pip; \
	);
	( \
	    while ! docker system info > /dev/null 2>&1; do\
	    echo 'Waiting for docker to start...';\
	    if [[ '$(OS)' == 'Linux' ]] && [[ '$(GITHUB_ACTIONS)' == 'false' ]]; then\
	    type -P apt && apt install docker*;\
	    type -P systemctl && systemctl restart docker.service || type -P service && service docker.service restart || type -P apk &&  apk add openrc docker && rc-service docker restart || echo "try installing docker manually...";\
	    fi;\
	    if [[ '$(OS)' == 'Darwin' ]] && [[ '$(GITHUB_ACTIONS)' == 'false' ]]; then\
	     open --background -a /./Applications/Docker.app/Contents/MacOS/Docker;\
	    fi;\
	sleep 1;\
	docker pull catthehacker/ubuntu:act-latest;\
	done\
	)

initialize:## 	initialize
## initialize
	@[[ '$(shell uname -m)' == 'x86_64' ]] && [[ '$(shell uname -s)' == 'Darwin' ]] && echo "is_Darwin/x86_64" || echo "not_Darwin/x86_64"
	@[[ '$(shell uname -m)' == 'x86_64' ]] && [[ '$(shell uname -s)' == 'Linux' ]] && echo "is_Linux/x86_64" || echo "not_Linux/x86_64"

failure:
	@-/usr/bin/false && ([ $$? -eq 0 ] && echo "success!") || echo "failure!"
success:
	@-/usr/bin/true && ([ $$? -eq 0 ] && echo "success!") || echo "failure!"

.PHONY: nvm
.ONESHELL:
nvm: ## 	nvm
	@echo "$(NODE_VERSION)" > .nvmrc && \
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash || \
git -C $(HOME)/.nvm reset --hard
	@git -C $(HOME)/.nvm checkout master && git -C $(HOME)/.nvm pull --no-rebase --force 2>/dev/null
	@echo . $(HOME)/.nvm/nvm.sh &>/dev/null

nvm-clean: ## 	nvm-clean
	@rm -rf ~/.nvm

clean:## 	clean
	@git clean -xfd && git submodule foreach --recursive git clean -xfd && git reset --hard && git submodule foreach --recursive git reset --hard && git submodule update --init --recursive

tag:
	@git tag $(OS)-$(OS_VERSION)-$(ARCH)-$(shell date +%s)
	@git push -f --tags || echo "unable to push tags..."

.PHONY:index.html
index.html:
	curl --connect-timeout 20 http://localhost:6102 > index.html

curl-test:
	curl --connect-timeout 20 http://localhost:6102 | sed  's/<[^>]*>//g'

gnostr-query-test:
	@gnostr --sec $(shell gnostr-sha256) \
    --envelope \
    --content \
    "$(shell curl -s http://127.0.0.1:6102 | grep "<li>" | sed 's/<li>//' | sed 's/<\/li\>//')"
test-query:
	@gnostr-query \
    -t gnostr \
    -t weeble \
    -t wobble | gnostr-cat ws://127.0.0.1:6102

-include Makefile
-include venv.mk
-include act.mk

# vim: set noexpandtab
# vim: set setfiletype make
