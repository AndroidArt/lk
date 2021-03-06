LOCAL_DIR := $(GET_LOCAL_DIR)
MODULE := $(LOCAL_DIR)

PLATFORM := sifive
VARIANT := sifive_u

WITH_SMP := 1
RISCV_BOOT_HART := 1
# Hart 0 on this board is disabled in supervisor mode, so make sure
# there are enough hart slots for it
RISCV_MAX_HARTS := 5

GLOBAL_DEFINES += SIFIVE_FREQ=500000000 # 500 MHz

RISCV_MODE ?= supervisor

ifeq ($(RISCV_MODE),supervisor)
MEMBASE ?= 0x080300000
SMP_MAX_CPUS := 4
else
MEMBASE ?= 0x080000000
SMP_MAX_CPUS := 5
endif

MEMSIZE ?= 0x200000000 # 8 GiB

MODULE_SRCS := $(LOCAL_DIR)/target.c
# set some global defines based on capability
GLOBAL_DEFINES += TARGET_HAS_DEBUG_LED=1
GLOBAL_DEFINES += PLATFORM_HAS_DYNAMIC_TIMER=1
GLOBAL_DEFINES += ARCH_RISCV_CLINT_BASE=0x02000000
GLOBAL_DEFINES += ARCH_RISCV_MTIME_RATE=1000000  # 1 MHz

include make/module.mk
