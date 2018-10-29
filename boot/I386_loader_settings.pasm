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

MULTIBOOT_HEADER_MAGIC     := 0xe85250d6
MULTIBOOT_HEADER_ARCH_I386 := 0
MULTIBOOT_LOADER_MAGIC     := 0x36d76289
MULTIBOOT_MMAP_SIGNATURE   := 0x534d4150 // 'SMAP'

BIOS_BOOTSECTOR_SEGMENT := 0x07C0

//LOADER_NAME := "GridOS Loader 0.2"
LOADER_MBR_SIGNATURE := 0xaa55
LOADER_MPT_START     := 0x1be
LOADER_MPT_END       := 0x1fe
LOADER_STACK_ADDR    := 0x7000

LOADER_SECTORS      := ((loader_end-loader_start) >> 9)
LOADER_LBA          := 0
LOADER_SEGMENT      := 0x0800
LOADER_OFFSET       := 0x0000
LOADER_ADDR         := ((LOADER_SEGMENT << 4) + LOADER_OFFSET)

//MOD_TEXT_SECTORS    := 0 // dynamically added
MOD_TEXT_LBA        := (LOADER_LBA + LOADER_SECTORS)
MOD_TEXT_SIZE       := (MOD_TEXT_SECTORS << 9)
MOD_TEXT_SEGMENT    := 0x1000
MOD_TEXT_OFFSET     := 0x0000
MOD_TEXT_ADDR       := ((MOD_TEXT_SEGMENT << 4) + MOD_TEXT_OFFSET)
//MOD_TEXT_CMD      := "kernel --debug=1"

//STARTUP_SECTORS     := 0 // dynamically added 
STARTUP_LBA         := (MOD_TEXT_LBA + MOD_TEXT_SECTORS)
STARTUP_SIZE        := (STARTUP_SECTORS << 9)
STARTUP_SEGMENT     := 0x2000
STARTUP_OFFSET      := 0x0000
STARTUP_ADDR        := ((STARTUP_SEGMENT << 4) + STARTUP_OFFSET)
STARTUP_STACK_SIZE  := 0x3000
//STARTUP_CMD         := "--test = 0 --debug=2"

DISK_HEADS   := 2
DISK_TRACKS  := 80
DISK_SECTORS := 36
