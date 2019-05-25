CC=g++
CFLAGS= -fno-rtti -fno-exceptions -fno-pie -m32 -I$(INCDIR) -DCXX_VERSION$(CXX_VERSION) -DLINUX_ENV
ASFLAGS= --32
MAKEOP= -s
#MAKEOP= 

VERSION=$(shell g++ --version)
ifeq ($(VERSION), 2.95.4)
CXX_VERSION=$(shell g++ --version | sed "s/\./\_/g")
else
CXX_VERSION=$(shell g++ --version | grep g++ | cut -d ' ' -f4 | sed "s/\./\_/g")
endif

POOLBASEDIR = ../pool

#STORE=$(BINDIR)/store
#PASM=$(BINDIR)/pasm
STORE=$(POOLBASEDIR)/bootstrap-pool/bin/storeb
PASM=$(POOLBASEDIR)/bootstrap-cpp/bin/pbasm
POOLC=$(POOLBASEDIR)/bootstrap-cpp/bin/poolbc
POOLSC=$(POOLBASEDIR)/bootstrap-cpp/bin/poolbsc

PC_FLAGS=--classpath ./psrc --classpath $(POOLBASEDIR)/src --classpath $(POOLBASEDIR)/bootstrap-pool/src

LIBDIR=./lib
SRCDIR=./src
OBJDIR=./obj
BINDIR=./bin
IMGDIR=./img
INCDIR=./include
BOOTDIR=./boot
MODDIR=./modules
ifndef MASCHINE
MASCHINE=I386
endif

SUBDIRS=$(shell ls $(SRCDIR))
LIBS=$(patsubst %,$(LIBDIR)/%.a,$(SUBDIRS))

MAKEBOOT=make $(MAKEOP) MASCHINE=$(MASCHINE) -f ./.Makefiles/Makefile.boot
MAKELIB=make $(MAKEOP) MASCHINE=$(MASCHINE) -f ./.Makefiles/Makefile.libs

$(LIBDIR)/%.a:
	@$(MAKELIB) LIB=$@ $@
