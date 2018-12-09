/* ********* ABI **********
 * caller-saved: %eax, %ebx
 * callee-saved: others
 * Stack-Frame:
 * | caller prepared                                                                       | call         | callee prepared                          :
 * |Ret N|...|Ret 2|Ret 1|Param N|...|Param 2|Param 1|@Obj-Handle|Method Offset/@class-desc|@caller return|caller %ebp|Local 1|Local 2|...|saved regs|tmp-data/further frames
 *                                                                                                                    ^callee %ebp                   ^callee %esp
 */

/* ****** Class-Desc ******
 * 31                     0
 * +----------------------+
 * | 0x15AC1A55
 * +----------------------+
 * | 0 / @Class-Ref
 * +----------------------+
 * | Class-classname-Offset
 * +----------------------+
 * | Class-Tabs-Offset
 * +----------------------+
 * | Method-Tabs-Offset
 * +----------------------+
 * | instance-template-Offset
 * +----------------------+
 * | instance size
 * +----------------------+
 * | Object-Handle-Offset
 * +----------------------+
 * | Class-Handle-Offset
 * +----------------------+
 */

/* ****** Class Tabs ******
 * 31                     0
 * +----------------------+
 * | 0 / @Class-Desc
 * +----------------------+
 * | Class-classname-Offset
 * +----------------------+
 * | Class-VTab-Offset
 * +----------------------+
 * | Class-Handle-Offset
 * +----------------------+
 * | 0 / @Super1-Desc
 * +----------------------+
 * | Super1-classname-Offset
 * +----------------------+
 * | Super1-VTab-Offset
 * +----------------------+
 * | Super1-Handle-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | 0 / @SuperN-Desc
 * +----------------------+
 * | SuperN-classname-Offset
 * +----------------------+
 * | SuperN-VTab-Offset
 * +----------------------+
 * | SuperN-Handle-Offset
 * +----------------------+
 */
/* ****** Method Tabs *****
 * 31                     0
 * +----------------------+
 * | Meth 0 - Method Offset
 * +----------------------+
 * | Meth 0 - Class-Desc-Offset
 * +----------------------+
 * | Meth 1 - Method Offset
 * +----------------------+
 * | Meth 0 - Class-Desc-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 */
/* ******* Instance *******
 * +----------------------+
 * | @Obj-Class-Desc
 * +----------------------+
 * | @Inst-MemInfo
 * +======================+ < Ref Class
 * | @Call-Entry
 * +----------------------+
 * | @Inst
 * +----------------------+
 * | Class-VTab-Offset
 * +----------------------+
 * | Object-Vars-Offset
 * +----------------------+
 * | SuperN-Vars-Offset
 * +----------------------+
 * | ..
 * +----------------------+
 * | Super1-Vars-Offset
 * +----------------------+
 * | Class-Vars-Offset
 * +======================+ < Ref Super1
 * | @Call-Entry
 * +----------------------+
 * | @Inst
 * +----------------------+
 * | Super1-VTab-Offset
 * +----------------------+
 * | Object-Vars-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | Super1-Super1-Vars-Offset
 * +----------------------+
 * | Super1-Class-Vars-Offset
 * +======================+ < Ref ...
 * | ...
 * +======================+ < Ref Object
 * | ...
 * +======================+ < Vars Object
 * | ...
 * +----------------------+ < Vars ...
 * | ...
 * +----------------------+ < Vars Super1
 * | Super1-Var1
 * +----------------------+
 * | ...
 * +----------------------+ < Vars Class
 * | This-Var1
 * +----------------------+
 * | This-Var4
 * +----------------------+
 * | This-Var2 | This-Var3
 * +----------------------+
 * | ...
 * +----------------------+
 */

