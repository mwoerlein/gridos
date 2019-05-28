/* TODO: generate tags instead of hardcoded startup/mods */
mbi_tag_command_line:
    .long   MULTIBOOT_TAG_TYPE_CMDLINE
    .long   (mbi_tag_command_line_end - mbi_tag_command_line)
    .asciz  "--test=0 --debug=2 --mainThread=gridos::KernelThread" // STARTUP_CMD
.align MULTIBOOT_TAG_ALIGN
mbi_tag_command_line_end:
mbi_tag_mod_kernel:
    .long   MULTIBOOT_TAG_TYPE_MODULE
    .long   (mbi_tag_mod_kernel_end - mbi_tag_mod_kernel)
    .long   MOD_KERNEL_ADDR
    .long   (MOD_KERNEL_ADDR + (MOD_KERNEL_SECTORS << 9))
    .asciz  "kernel --debug=1" // MOD_KERNEL_CMD
.align MULTIBOOT_TAG_ALIGN
mbi_tag_mod_kernel_end:
mbi_tag_mod_store:
    .long   MULTIBOOT_TAG_TYPE_MODULE
    .long   (mbi_tag_mod_store_end - mbi_tag_mod_store)
    .long   MOD_STORE_ADDR
    .long   (MOD_STORE_ADDR + (MOD_STORE_SECTORS << 9))
    .asciz  "store --debug=1" // MOD_STORE_CMD
.align MULTIBOOT_TAG_ALIGN
mbi_tag_mod_store_end:
