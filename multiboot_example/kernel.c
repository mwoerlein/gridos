/*  kernel.c - the C part of the kernel */
/*  Copyright (C) 1999, 2010  Free Software Foundation, Inc.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "multiboot2.h"

/*  Macros. */

/*  Some screen stuff. */
/*  The number of columns. */
#define COLUMNS                 80
/*  The number of lines. */
#define LINES                   24
/*  The attribute of an character. */
#define ATTRIBUTE               7
/*  The video memory address. */
#define VIDEO                   0xB8000

/*  Variables. */
/*  Save the X position. */
static int xpos;
/*  Save the Y position. */
static int ypos;
/*  Point to the video memory. */
static volatile unsigned char *video;

#ifdef __cplusplus
extern "C" {
#endif
extern struct multiboot_header multiboot_header;
extern struct multiboot_header_tag_address address_tag;
extern struct multiboot_header_tag_entry_address entry_address_tag;

/*  Forward declarations. */
void cmain (unsigned long magic, unsigned long addr);
void cprintf (const char *format);
#ifdef __cplusplus
}
#endif

class I386CgaOStream {
    private:
	enum { index_port = 0x3d4, data_port = 0x3d5 , cga_ram = 0xB8000};
	enum { maxx = 80, maxy = 25};
	char* screen;
	int pos,base;
    public:
	I386CgaOStream(char* scr=(char*)cga_ram, int x=0, int y=0);
	~I386CgaOStream();
	I386CgaOStream &operator<<(char c);
	I386CgaOStream &operator<<(int i);
	I386CgaOStream &operator<<(unsigned int i);
	I386CgaOStream &operator<<(long i);
	I386CgaOStream &operator<<(unsigned long i);
	I386CgaOStream &operator<<(unsigned long long i);
	I386CgaOStream &operator<<(char *c);
	I386CgaOStream &operator<<(const char *c);
	I386CgaOStream &operator<<(void *ptr);
//	I386CgaOStream &operator<<(String &str);
	void clear();
};

/*  Check if MAGIC is valid and print the Multiboot information structure
pointed by ADDR. */
void
cmain (unsigned long magic, unsigned long addr)
{
struct multiboot_tag *tag;
char buf[20];
unsigned size;
I386CgaOStream cout;

/*  Clear the screen. */
cout.clear ();
cout << "\n";

/*  Am I booted by a Multiboot-compliant boot loader? */
if (magic != MULTIBOOT2_BOOTLOADER_MAGIC)
 {
   cout << "Invalid magic number: " << (unsigned long long) magic << "\n";
   return;
 }

if (addr & 7)
 {
   cout << "Unaligned mbi: " << addr << "\n";
   return;
 }
cout << "multiboot header: " << &multiboot_header
 << " magic: " << (void *) multiboot_header.magic 
 << " architecture: " << (void *) multiboot_header.architecture 
 << " header_length: " << (void *) multiboot_header.header_length 
 << " checksum: " << (void *) multiboot_header.checksum 
 << "\n";

cout << "address tag: " << &address_tag
 << " header: " << (void *) address_tag.header_addr 
 << " load: " << (void *) address_tag.load_addr 
 << " load end: " << (void *) address_tag.load_end_addr 
 << " bss end: " << (void *) address_tag.bss_end_addr
 << "\n";

cout << "address entry tag: " << &entry_address_tag
 << " entry addr: " << (void *) entry_address_tag.entry_addr
 << "\n"; 

size = *(unsigned int *) addr;
cout << "Announced mbi size: " << size << "\n";

for (tag = (struct multiboot_tag *) (addr + 8);
    tag->type != MULTIBOOT_TAG_TYPE_END;
    tag = (struct multiboot_tag *) ((multiboot_uint8_t *) tag
                                    + ((tag->size + 7) & ~7)))
 {
   cout <<"Tag " << tag->type << " Size: " << tag->size << "\n";
   switch (tag->type)
     {
     case MULTIBOOT_TAG_TYPE_CMDLINE:
       cout << "Command line = " << ((struct multiboot_tag_string *) tag)->string << "\n";
       break;
     case MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME:
       cout << "Boot loader name = " << ((struct multiboot_tag_string *) tag)->string << "\n";
       break;
     case MULTIBOOT_TAG_TYPE_MODULE:
       cout << "Module at " << (unsigned long long) ((struct multiboot_tag_module *) tag)->mod_start << "-" << (unsigned long long) ((struct multiboot_tag_module *) tag)->mod_end 
          << ". Command line " << ((struct multiboot_tag_module *) tag)->cmdline << "\n";
       break;
     case MULTIBOOT_TAG_TYPE_BASIC_MEMINFO:
       cout << "mem_lower = "<<((struct multiboot_tag_basic_meminfo *) tag)->mem_lower<<"KB, mem_upper = " << ((struct multiboot_tag_basic_meminfo *) tag)->mem_upper << "KB\n";
       break;
     case MULTIBOOT_TAG_TYPE_BOOTDEV:
       {
         struct multiboot_tag_bootdev *dev = (struct multiboot_tag_bootdev *) tag;
       cout << "Boot device " << dev->biosdev<<","<<dev->slice<<","<<dev->part<<"\n";
       }
       break;
     case MULTIBOOT_TAG_TYPE_MMAP:
       {
         multiboot_memory_map_t *mmap;

         cout << "mmap\n";

         for (mmap = ((struct multiboot_tag_mmap *) tag)->entries;
              (multiboot_uint8_t *) mmap
                < (multiboot_uint8_t *) tag + tag->size;
              mmap = (multiboot_memory_map_t *)
                ((unsigned long) mmap
                 + ((struct multiboot_tag_mmap *) tag)->entry_size))
           cout <<" base_addr = " << mmap->addr << ", length = " << mmap->len << ", type = " << mmap->type << "\n";
       }
       break;
     case MULTIBOOT_TAG_TYPE_FRAMEBUFFER:
       break;
       {
         multiboot_uint32_t color;
         unsigned i;
         struct multiboot_tag_framebuffer *tagfb
           = (struct multiboot_tag_framebuffer *) tag;
         void *fb = (void *) (unsigned long) tagfb->common.framebuffer_addr;

         switch (tagfb->common.framebuffer_type)
           {
           case MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED:
             {
               unsigned best_distance, distance;
               struct multiboot_color *palette;

               palette = tagfb->framebuffer_palette;

               color = 0;
               best_distance = 4*256*256;

               for (i = 0; i < tagfb->framebuffer_palette_num_colors; i++)
                 {
                   distance = (0xff - palette[i].blue)
                     * (0xff - palette[i].blue)
                     + palette[i].red * palette[i].red
                     + palette[i].green * palette[i].green;
                   if (distance < best_distance)
                     {
                       color = i;
                       best_distance = distance;
                     }
                 }
             }
             break;

           case MULTIBOOT_FRAMEBUFFER_TYPE_RGB:
             color = ((1 << tagfb->framebuffer_blue_mask_size) - 1)
               << tagfb->framebuffer_blue_field_position;
             break;

           case MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT:
             color = '\\' | 0x0100;
             break;

           default:
             color = 0xffffffff;
             break;
           }

         for (i = 0; i < tagfb->common.framebuffer_width
                && i < tagfb->common.framebuffer_height; i++)
           {
             switch (tagfb->common.framebuffer_bpp)
               {
               case 8:
                 {
                   multiboot_uint8_t *pixel = ((multiboot_uint8_t *) fb)
                     + tagfb->common.framebuffer_pitch * i + i;
                   *pixel = color;
                 }
                 break;
               case 15:
               case 16:
                 {
                   multiboot_uint16_t *pixel = ((multiboot_uint16_t *) fb)
                     + tagfb->common.framebuffer_pitch * i + 2 * i;
                   *pixel = color;
                 }
                 break;
               case 24:
                 {
                   multiboot_uint32_t *pixel = ((multiboot_uint32_t *) fb)
                     + tagfb->common.framebuffer_pitch * i + 3 * i;
                   *pixel = (color & 0xffffff) | (*pixel & 0xff000000);
                 }
                 break;

               case 32:
                 {
                   multiboot_uint32_t *pixel = ((multiboot_uint32_t *) fb)
                     + tagfb->common.framebuffer_pitch * i + 4 * i;
                   *pixel = color;
                 }
                 break;
               }
           }
         break;
       }

     }
 }
tag = (struct multiboot_tag *) ((multiboot_uint8_t *) tag
                               + ((tag->size + 7) & ~7));
cout << "Total mbi size " << (unsigned) tag - addr << "\n";
}

/*  Clear the screen and initialize VIDEO, XPOS and YPOS. */
static void
cls (void)
{
int i;

video = (unsigned char *) VIDEO;

for (i = 0; i < COLUMNS * LINES * 2; i++)
 *(video + i) = 0;

xpos = 0;
ypos = 0;
}

void
cprintf (const char *format)
{
    I386CgaOStream cout;
    cout<<format;
}

 /*  Convert the integer D to a string and save the string in BUF. If
    BASE is equal to 'd', interpret that D is decimal, and if BASE is
    equal to 'x', interpret that D is hexadecimal. */
 static void
 itoa (char *buf, int base, int d, int pad = 0)
 {
   char *p = buf;
   char *p1, *p2;
   unsigned long ud = d;
   int divisor = 10;
 
   /*  If %d is specified and D is minus, put `-' in the head. */
   if (base == 'd' && d < 0)
     {
       *p++ = '-';
       buf++;
       ud = -d;
     }
   else if (base == 'x')
     divisor = 16;
 
   /*  Divide UD by DIVISOR until UD == 0. */
   do
     {
       int remainder = ud % divisor;
 
       *p++ = (remainder < 10) ? remainder + '0' : remainder + 'a' - 10;
     }
   while (ud /= divisor);
   while (buf+pad > p) {
      *p++ = '0';
   }
 
   /*  Terminate BUF. */
   *p = 0;
 
   /*  Reverse BUF. */
   p1 = buf;
   p2 = p - 1;
   while (p1 < p2)
     {
       char tmp = *p1;
       *p1 = *p2;
       *p2 = tmp;
       p1++;
       p2--;
     }
 }



I386CgaOStream::I386CgaOStream(char* scr,int x,int y):screen(scr),base(10){
/*
    I386IO_Port(index_port).outb(14);
    pos=I386IO_Port(data_port).inb()*512;
    I386IO_Port(index_port).outb(15);
    pos+=I386IO_Port(data_port).inb()*2;
    */
};
I386CgaOStream::~I386CgaOStream(){};
I386CgaOStream &I386CgaOStream::operator<<(char c){
    switch (c) {
	case '\n':
	    pos-=pos%(2*maxx);
	    pos+=2*maxx;
	    break;
	case '\t':
	    while (pos%16) *this<<(' ');
	    return *this;
	case '\0':
	    break;
	default:
	    screen[pos++]=c;
	    screen[pos++]=7;
    }
    if (pos>=2*maxx*maxy){
	char* c1=screen;
	char* c2=screen+2*maxx;
	while(c2<screen+2*maxx*maxy){*c1++=*c2++;}
	while(c1<screen+2*maxx*maxy){*c1++=' ';*c1++=7;}
	pos-=2*maxx;
    };
    /*
    I386IO_Port(index_port).outb(14);
    I386IO_Port(data_port).outb(pos/512);
    I386IO_Port(index_port).outb(15);
    I386IO_Port(data_port).outb((pos/2)%256);
    */
    return *this;
};
I386CgaOStream &I386CgaOStream::operator<<(int i){
    char buf[20];
    itoa(buf,'d',i); 
    return *this<<buf; 
}
I386CgaOStream &I386CgaOStream::operator<<(unsigned int i){
    char buf[20];
    itoa(buf,'d',i); 
    return *this<<buf; 
}
I386CgaOStream &I386CgaOStream::operator<<(long i){
    char buf[20];
    itoa(buf,'d',i); 
    return *this<<buf; 
}
I386CgaOStream &I386CgaOStream::operator<<(unsigned long i){
    char buf[20];
    itoa(buf,'d',i); 
    return *this<<buf; 
}
I386CgaOStream &I386CgaOStream::operator<<(unsigned long long i){
    char buf[20];
    *this<<'0'<<'x';
    unsigned int a = (unsigned) (i >> 32);
    if (a) {  
        itoa(buf,'x',a); 
        *this<<buf;
    } 
    itoa(buf,'x',(unsigned) (i  & 0xffffffff), a?8:0); 
    return *this<<buf; 
}
I386CgaOStream &I386CgaOStream::operator<<(void *ptr){
    char buf[20];
    itoa(buf,'x',(unsigned)ptr);
    return *this<<"0x"<<buf; 
};

I386CgaOStream &I386CgaOStream::operator<<(char *str){
    while (*str) *this<<*str++;
    return *this;
};

I386CgaOStream &I386CgaOStream::operator<<(const char *str){
    return *this<<(char *) str;
};

/*
I386CgaOStream &I386CgaOStream::operator<<(String &str){
    char* ack=(char*) ack;
    while (*ack) *this<<*ack++;
    return *this;
};
*/
void I386CgaOStream::clear(){
    char* i=screen;
    while (i<screen+2*maxx*maxy){ *i++=' ';*i++=7; }

    pos=0;
/*    I386IO_Port(index_port).outb(14);
    I386IO_Port(data_port).outb(0);
    I386IO_Port(index_port).outb(15);
    I386IO_Port(data_port).outb(0);*/
};



// braucht c++
__asm__(".globl __stack_chk_fail");
__asm__(".globl __pure_virtual");
__asm__(".globl __builtin_delete");
__asm__(".globl __cxa_pure_virtual");
__asm__(".globl __cxa_atexit");
__asm__(".globl __dso_handle");
__asm__(".globl _ZdlPv");
__asm__("_ZdlPv:");
__asm__("__cxa_atexit:");
__asm__("__cxa_pure_virtual:");
__asm__("__builtin_delete:");
__asm__("__pure_virtual:");
__asm__("__stack_chk_fail:");
__asm__("__dso_handle:");
__asm__("	ret");
