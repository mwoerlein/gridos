/* TODO: generate dap-list instead of hardcoded startup/mods */

//STARTUP_SECTORS     := 0 // dynamically added 
STARTUP_LBA         := (MOD_KERNEL_LBA + MOD_KERNEL_SECTORS)
STARTUP_SEGMENT     := 0x2000
STARTUP_OFFSET      := 0x0000
STARTUP_ADDR        := ((STARTUP_SEGMENT << 4) + STARTUP_OFFSET)
//STARTUP_CMD         := "--test = 0 --debug=2"
startup_disk_address_packet:
    .byte 0x10
    .byte 0x0
    .word STARTUP_SECTORS  # count
    .word STARTUP_OFFSET   # destination offset
    .word STARTUP_SEGMENT  # destination segment
    .long STARTUP_LBA      # lba block
    .long 0                # lba block

//MOD_KERNEL_SECTORS  := 0 // dynamically added
MOD_KERNEL_LBA      := (LOADER_LBA + LOADER_SECTORS)
MOD_KERNEL_SEGMENT  := 0x1000
MOD_KERNEL_OFFSET   := 0x0000
MOD_KERNEL_ADDR     := ((MOD_KERNEL_SEGMENT << 4) + MOD_KERNEL_OFFSET)
//MOD_KERNEL_CMD    := "kernel --debug=1"
mod_kernel_disk_address_packet:
    .byte 0x10
    .byte 0x0
    .word MOD_KERNEL_SECTORS # count
    .word MOD_KERNEL_OFFSET  # destination offset
    .word MOD_KERNEL_SEGMENT # destination segment
    .long MOD_KERNEL_LBA     # lba block
    .long 0                  # lba block

//MOD_STORE_SECTORS  := 0 // dynamically added
MOD_STORE_LBA      := (STARTUP_LBA + STARTUP_SECTORS)
MOD_STORE_SEGMENT  := (MOD_KERNEL_SEGMENT + (MOD_KERNEL_SECTORS << 5))
MOD_STORE_OFFSET   := 0x0000
MOD_STORE_ADDR     := ((MOD_STORE_SEGMENT << 4) + MOD_STORE_OFFSET)
//MOD_STORE_CMD    := "store --debug=1"
mod_store_disk_address_packet:
    .byte 0x10
    .byte 0x0
    .word MOD_STORE_SECTORS # count
    .word MOD_STORE_OFFSET  # destination offset
    .word MOD_STORE_SEGMENT # destination segment
    .long MOD_STORE_LBA     # lba block
    .long 0                 # lba block
