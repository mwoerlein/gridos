dap_list_end:

/* mbi-structures */
.align MULTIBOOT_TAG_ALIGN
mbi:
    .long   0 # size (will be filled after memory-detection)
    .long   0 # reserved
mbi_tag_name:
    .long   MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME
    .long   (mbi_tag_name_end - mbi_tag_name)
    .asciz  "GridOS Loader 0.2" // LOADER_NAME
.align MULTIBOOT_TAG_ALIGN
mbi_tag_name_end:
