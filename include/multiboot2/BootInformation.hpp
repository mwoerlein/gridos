#ifndef BOOTINFORMATION_HPP_LOCK
#define BOOTINFORMATION_HPP_LOCK

#include "multiboot2/multiboot2.h"

class BootInformation{
    public:
	struct multiboot_tag_string *commandline;
	struct multiboot_tag_string *bootloader;
	struct multiboot_tag_basic_meminfo *meminfo;
	struct multiboot_tag_mmap *mmap;
	int modulesCount;
	struct multiboot_tag_module *modules[10];
	BootInformation(void *mbi);
	virtual ~BootInformation(){};
};

#endif //BOOTINFORMATION_HPP_LOCK

