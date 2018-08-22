#ifndef GRIDOS_LOADER_HEADER
#define GRIDOS_LOADER_HEADER 1

/* name/version of the loader */
#define GRIDOS_LOADER_NAME "GridOS Loader 0.1"
 
/* start of the master partition table */
#define GRIDOS_LOADER_MPT_START 0x1be

/* end of the master partition table */
#define GRIDOS_LOADER_MPT_END 0x1fe

/* The signature for the MBR */
#define GRIDOS_LOADER_MBR_SIGNATURE 0xaa55

/* The loader real stack */
#define GRIDOS_STACK_ADDR 0x2000

/* The bios loaded MBR initially to this segment */
#define GRIDOS_BIOS_BOOTSECTOR_SEG 0x07C0

/* The loader segment */
#define GRIDOS_LOADER_SEG 0x2000

/* The loader address */
#define GRIDOS_LOADER_ADDR (GRIDOS_LOADER_SEG << 4)

/* Size of loader */
#define GRIDOS_LOADER_SECTORS ((loader_end-loader_start) >> 9)

/* The magic field should contain this. */
#define GRIDOS_MULTIBOOT2_HEADER_MAGIC 0xe85250d6

/* I386 architecture */
#define GRIDOS_MULTIBOOT2_HEADER_ARCH_I386 0

/* This should be in %eax. */
#define GRIDOS_MULTIBOOT2_LOADER_MAGIC 0x36d76289

/* static limit for mmap entries */
#define GRIDOS_LOADER_MAX_MMAP_ENTRIES 20

#endif /* GRIDOS_LOADER_HEADER */
