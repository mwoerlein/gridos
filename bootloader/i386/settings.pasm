MULTIBOOT_TAG_ALIGN                  := 8
MULTIBOOT_TAG_TYPE_END               := 0
MULTIBOOT_TAG_TYPE_CMDLINE           := 1
MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME  := 2
MULTIBOOT_TAG_TYPE_MODULE            := 3
MULTIBOOT_TAG_TYPE_BASIC_MEMINFO     := 4
MULTIBOOT_TAG_TYPE_BOOTDEV           := 5
MULTIBOOT_TAG_TYPE_MMAP              := 6
MULTIBOOT_TAG_TYPE_VBE               := 7
MULTIBOOT_TAG_TYPE_FRAMEBUFFER       := 8

/* The magic field should contain this. */
MULTIBOOT2_HEADER_MAGIC     := 0xe85250d6

/* This should be in %eax. */
MULTIBOOT2_BOOTLOADER_MAGIC := 0x36d76289


/* The bios loaded MBR initially to this segment */
BIOS_BOOTSECTOR_SEGMENT   := 0x07C0

/* 'SMAP' */
BIOS_INT15_E820_SIGNATURE := 0x534d4150

DISK_HEADS   := 2
DISK_TRACKS  := 80
DISK_SECTORS := 36


/* name/version of the loader */
//LOADER_NAME := "GridOS Loader 0.2"

/* The signature for the MBR */
LOADER_MBR_SIGNATURE := 0xaa55

/* start of the master partition table */
LOADER_MPT_START     := 0x1be

/* end of the master partition table */
LOADER_MPT_END       := 0x1fe

/* The loader real stack */
LOADER_STACK_ADDR    := 0x7000


LOADER_SECTORS      := ((loader_end-loader_start) >> 9)
LOADER_LBA          := 0
LOADER_SEGMENT      := 0x0800
LOADER_OFFSET       := 0x0000
LOADER_ADDR         := ((LOADER_SEGMENT << 4) + LOADER_OFFSET)
