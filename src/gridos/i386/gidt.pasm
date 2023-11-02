/*[meta]
mimetype = text/x-pasm
description = static gdt and idt implementation
author = Marc Woerlein <marc.woerlein@gmx.de>
version = 0.1.0
*/
.code32
_gridos_i386_interrupt_InterruptVectorTable_m_call := 168
__idt_instance: .long 0x0 // filled by gridos
    .long __gridos_idt_48
    .long __gridos_gdt_48
    .long __gridos_gdt_tss

__idt_isr_common:
    // store all registers in stack frame
    pushad
    push %ds
    push %es
    push %fs
    push %gs
    
    // ensure kernel segment in all segment registers
    movw %ss, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %fs
    movw %ax, %gs
    
    // call interrupt
    movl %esp, %eax
    subl 4, %esp
    pushl %eax
    movl (__idt_instance), %eax
    pushl %eax; pushl _gridos_i386_interrupt_InterruptVectorTable_m_call; call (%eax)
    addl 12, %esp
    // replace stack frame (for context switch)
    popl %esp
    
    // restore all registers from stack frame
    pop %gs
    pop %fs
    pop %es
    pop %ds
    popad
    // remove interrupt number and error code
    addl 8, %esp
    iret

.align 32
__idt_isr_0:   pushl 0; pushl   0; jmp __idt_isr_common
__idt_isr_1:   pushl 0; pushl   1; jmp __idt_isr_common
__idt_isr_2:   pushl 0; pushl   2; jmp __idt_isr_common
__idt_isr_3:   pushl 0; pushl   3; jmp __idt_isr_common
__idt_isr_4:   pushl 0; pushl   4; jmp __idt_isr_common
__idt_isr_5:   pushl 0; pushl   5; jmp __idt_isr_common
__idt_isr_6:   pushl 0; pushl   6; jmp __idt_isr_common
__idt_isr_7:   pushl 0; pushl   7; jmp __idt_isr_common
__idt_isr_8:            pushl   8; jmp __idt_isr_common
__idt_isr_9:   pushl 0; pushl   9; jmp __idt_isr_common
__idt_isr_10:           pushl  10; jmp __idt_isr_common
__idt_isr_11:           pushl  11; jmp __idt_isr_common
__idt_isr_12:           pushl  12; jmp __idt_isr_common
__idt_isr_13:           pushl  13; jmp __idt_isr_common
__idt_isr_14:           pushl  14; jmp __idt_isr_common
__idt_isr_15:  pushl 0; pushl  15; jmp __idt_isr_common
__idt_isr_16:  pushl 0; pushl  16; jmp __idt_isr_common
__idt_isr_17:           pushl  17; jmp __idt_isr_common
__idt_isr_18:  pushl 0; pushl  18; jmp __idt_isr_common
__idt_isr_19:  pushl 0; pushl  19; jmp __idt_isr_common
__idt_isr_20:  pushl 0; pushl  20; jmp __idt_isr_common
__idt_isr_21:  pushl 0; pushl  21; jmp __idt_isr_common
__idt_isr_22:  pushl 0; pushl  22; jmp __idt_isr_common
__idt_isr_23:  pushl 0; pushl  23; jmp __idt_isr_common
__idt_isr_24:  pushl 0; pushl  24; jmp __idt_isr_common
__idt_isr_25:  pushl 0; pushl  25; jmp __idt_isr_common
__idt_isr_26:  pushl 0; pushl  26; jmp __idt_isr_common
__idt_isr_27:  pushl 0; pushl  27; jmp __idt_isr_common
__idt_isr_28:  pushl 0; pushl  28; jmp __idt_isr_common
__idt_isr_29:  pushl 0; pushl  29; jmp __idt_isr_common
__idt_isr_30:           pushl  30; jmp __idt_isr_common
__idt_isr_31:  pushl 0; pushl  31; jmp __idt_isr_common
__idt_isr_32:  pushl 0; pushl  32; jmp __idt_isr_common
__idt_isr_33:  pushl 0; pushl  33; jmp __idt_isr_common
__idt_isr_34:  pushl 0; pushl  34; jmp __idt_isr_common
__idt_isr_35:  pushl 0; pushl  35; jmp __idt_isr_common
__idt_isr_36:  pushl 0; pushl  36; jmp __idt_isr_common
__idt_isr_37:  pushl 0; pushl  37; jmp __idt_isr_common
__idt_isr_38:  pushl 0; pushl  38; jmp __idt_isr_common
__idt_isr_39:  pushl 0; pushl  39; jmp __idt_isr_common
__idt_isr_40:  pushl 0; pushl  40; jmp __idt_isr_common
__idt_isr_41:  pushl 0; pushl  41; jmp __idt_isr_common
__idt_isr_42:  pushl 0; pushl  42; jmp __idt_isr_common
__idt_isr_43:  pushl 0; pushl  43; jmp __idt_isr_common
__idt_isr_44:  pushl 0; pushl  44; jmp __idt_isr_common
__idt_isr_45:  pushl 0; pushl  45; jmp __idt_isr_common
__idt_isr_46:  pushl 0; pushl  46; jmp __idt_isr_common
__idt_isr_47:  pushl 0; pushl  47; jmp __idt_isr_common
__idt_isr_48:  pushl 0; pushl  48; jmp __idt_isr_common
__idt_isr_49:  pushl 0; pushl  49; jmp __idt_isr_common
__idt_isr_50:  pushl 0; pushl  50; jmp __idt_isr_common
__idt_isr_51:  pushl 0; pushl  51; jmp __idt_isr_common
__idt_isr_52:  pushl 0; pushl  52; jmp __idt_isr_common
__idt_isr_53:  pushl 0; pushl  53; jmp __idt_isr_common
__idt_isr_54:  pushl 0; pushl  54; jmp __idt_isr_common
__idt_isr_55:  pushl 0; pushl  55; jmp __idt_isr_common
__idt_isr_56:  pushl 0; pushl  56; jmp __idt_isr_common
__idt_isr_57:  pushl 0; pushl  57; jmp __idt_isr_common
__idt_isr_58:  pushl 0; pushl  58; jmp __idt_isr_common
__idt_isr_59:  pushl 0; pushl  59; jmp __idt_isr_common
__idt_isr_60:  pushl 0; pushl  60; jmp __idt_isr_common
__idt_isr_61:  pushl 0; pushl  61; jmp __idt_isr_common
__idt_isr_62:  pushl 0; pushl  62; jmp __idt_isr_common
__idt_isr_63:  pushl 0; pushl  63; jmp __idt_isr_common
__idt_isr_64:  pushl 0; pushl  64; jmp __idt_isr_common
__idt_isr_65:  pushl 0; pushl  65; jmp __idt_isr_common
__idt_isr_66:  pushl 0; pushl  66; jmp __idt_isr_common
__idt_isr_67:  pushl 0; pushl  67; jmp __idt_isr_common
__idt_isr_68:  pushl 0; pushl  68; jmp __idt_isr_common
__idt_isr_69:  pushl 0; pushl  69; jmp __idt_isr_common
__idt_isr_70:  pushl 0; pushl  70; jmp __idt_isr_common
__idt_isr_71:  pushl 0; pushl  71; jmp __idt_isr_common
__idt_isr_72:  pushl 0; pushl  72; jmp __idt_isr_common
__idt_isr_73:  pushl 0; pushl  73; jmp __idt_isr_common
__idt_isr_74:  pushl 0; pushl  74; jmp __idt_isr_common
__idt_isr_75:  pushl 0; pushl  75; jmp __idt_isr_common
__idt_isr_76:  pushl 0; pushl  76; jmp __idt_isr_common
__idt_isr_77:  pushl 0; pushl  77; jmp __idt_isr_common
__idt_isr_78:  pushl 0; pushl  78; jmp __idt_isr_common
__idt_isr_79:  pushl 0; pushl  79; jmp __idt_isr_common
__idt_isr_80:  pushl 0; pushl  80; jmp __idt_isr_common
__idt_isr_81:  pushl 0; pushl  81; jmp __idt_isr_common
__idt_isr_82:  pushl 0; pushl  82; jmp __idt_isr_common
__idt_isr_83:  pushl 0; pushl  83; jmp __idt_isr_common
__idt_isr_84:  pushl 0; pushl  84; jmp __idt_isr_common
__idt_isr_85:  pushl 0; pushl  85; jmp __idt_isr_common
__idt_isr_86:  pushl 0; pushl  86; jmp __idt_isr_common
__idt_isr_87:  pushl 0; pushl  87; jmp __idt_isr_common
__idt_isr_88:  pushl 0; pushl  88; jmp __idt_isr_common
__idt_isr_89:  pushl 0; pushl  89; jmp __idt_isr_common
__idt_isr_90:  pushl 0; pushl  90; jmp __idt_isr_common
__idt_isr_91:  pushl 0; pushl  91; jmp __idt_isr_common
__idt_isr_92:  pushl 0; pushl  92; jmp __idt_isr_common
__idt_isr_93:  pushl 0; pushl  93; jmp __idt_isr_common
__idt_isr_94:  pushl 0; pushl  94; jmp __idt_isr_common
__idt_isr_95:  pushl 0; pushl  95; jmp __idt_isr_common
__idt_isr_96:  pushl 0; pushl  96; jmp __idt_isr_common
__idt_isr_97:  pushl 0; pushl  97; jmp __idt_isr_common
__idt_isr_98:  pushl 0; pushl  98; jmp __idt_isr_common
__idt_isr_99:  pushl 0; pushl  99; jmp __idt_isr_common
__idt_isr_100: pushl 0; pushl 100; jmp __idt_isr_common
__idt_isr_101: pushl 0; pushl 101; jmp __idt_isr_common
__idt_isr_102: pushl 0; pushl 102; jmp __idt_isr_common
__idt_isr_103: pushl 0; pushl 103; jmp __idt_isr_common
__idt_isr_104: pushl 0; pushl 104; jmp __idt_isr_common
__idt_isr_105: pushl 0; pushl 105; jmp __idt_isr_common
__idt_isr_106: pushl 0; pushl 106; jmp __idt_isr_common
__idt_isr_107: pushl 0; pushl 107; jmp __idt_isr_common
__idt_isr_108: pushl 0; pushl 108; jmp __idt_isr_common
__idt_isr_109: pushl 0; pushl 109; jmp __idt_isr_common
__idt_isr_110: pushl 0; pushl 110; jmp __idt_isr_common
__idt_isr_111: pushl 0; pushl 111; jmp __idt_isr_common
__idt_isr_112: pushl 0; pushl 112; jmp __idt_isr_common
__idt_isr_113: pushl 0; pushl 113; jmp __idt_isr_common
__idt_isr_114: pushl 0; pushl 114; jmp __idt_isr_common
__idt_isr_115: pushl 0; pushl 115; jmp __idt_isr_common
__idt_isr_116: pushl 0; pushl 116; jmp __idt_isr_common
__idt_isr_117: pushl 0; pushl 117; jmp __idt_isr_common
__idt_isr_118: pushl 0; pushl 118; jmp __idt_isr_common
__idt_isr_119: pushl 0; pushl 119; jmp __idt_isr_common
__idt_isr_120: pushl 0; pushl 120; jmp __idt_isr_common
__idt_isr_121: pushl 0; pushl 121; jmp __idt_isr_common
__idt_isr_122: pushl 0; pushl 122; jmp __idt_isr_common
__idt_isr_123: pushl 0; pushl 123; jmp __idt_isr_common
__idt_isr_124: pushl 0; pushl 124; jmp __idt_isr_common
__idt_isr_125: pushl 0; pushl 125; jmp __idt_isr_common
__idt_isr_126: pushl 0; pushl 126; jmp __idt_isr_common
__idt_isr_127: pushl 0; pushl 127; jmp __idt_isr_common
__idt_isr_128: pushl 0; pushl 128; jmp __idt_isr_common
__idt_isr_129: pushl 0; pushl 129; jmp __idt_isr_common
__idt_isr_130: pushl 0; pushl 130; jmp __idt_isr_common
__idt_isr_131: pushl 0; pushl 131; jmp __idt_isr_common
__idt_isr_132: pushl 0; pushl 132; jmp __idt_isr_common
__idt_isr_133: pushl 0; pushl 133; jmp __idt_isr_common
__idt_isr_134: pushl 0; pushl 134; jmp __idt_isr_common
__idt_isr_135: pushl 0; pushl 135; jmp __idt_isr_common
__idt_isr_136: pushl 0; pushl 136; jmp __idt_isr_common
__idt_isr_137: pushl 0; pushl 137; jmp __idt_isr_common
__idt_isr_138: pushl 0; pushl 138; jmp __idt_isr_common
__idt_isr_139: pushl 0; pushl 139; jmp __idt_isr_common
__idt_isr_140: pushl 0; pushl 140; jmp __idt_isr_common
__idt_isr_141: pushl 0; pushl 141; jmp __idt_isr_common
__idt_isr_142: pushl 0; pushl 142; jmp __idt_isr_common
__idt_isr_143: pushl 0; pushl 143; jmp __idt_isr_common
__idt_isr_144: pushl 0; pushl 144; jmp __idt_isr_common
__idt_isr_145: pushl 0; pushl 145; jmp __idt_isr_common
__idt_isr_146: pushl 0; pushl 146; jmp __idt_isr_common
__idt_isr_147: pushl 0; pushl 147; jmp __idt_isr_common
__idt_isr_148: pushl 0; pushl 148; jmp __idt_isr_common
__idt_isr_149: pushl 0; pushl 149; jmp __idt_isr_common
__idt_isr_150: pushl 0; pushl 150; jmp __idt_isr_common
__idt_isr_151: pushl 0; pushl 151; jmp __idt_isr_common
__idt_isr_152: pushl 0; pushl 152; jmp __idt_isr_common
__idt_isr_153: pushl 0; pushl 153; jmp __idt_isr_common
__idt_isr_154: pushl 0; pushl 154; jmp __idt_isr_common
__idt_isr_155: pushl 0; pushl 155; jmp __idt_isr_common
__idt_isr_156: pushl 0; pushl 156; jmp __idt_isr_common
__idt_isr_157: pushl 0; pushl 157; jmp __idt_isr_common
__idt_isr_158: pushl 0; pushl 158; jmp __idt_isr_common
__idt_isr_159: pushl 0; pushl 159; jmp __idt_isr_common
__idt_isr_160: pushl 0; pushl 160; jmp __idt_isr_common
__idt_isr_161: pushl 0; pushl 161; jmp __idt_isr_common
__idt_isr_162: pushl 0; pushl 162; jmp __idt_isr_common
__idt_isr_163: pushl 0; pushl 163; jmp __idt_isr_common
__idt_isr_164: pushl 0; pushl 164; jmp __idt_isr_common
__idt_isr_165: pushl 0; pushl 165; jmp __idt_isr_common
__idt_isr_166: pushl 0; pushl 166; jmp __idt_isr_common
__idt_isr_167: pushl 0; pushl 167; jmp __idt_isr_common
__idt_isr_168: pushl 0; pushl 168; jmp __idt_isr_common
__idt_isr_169: pushl 0; pushl 169; jmp __idt_isr_common
__idt_isr_170: pushl 0; pushl 170; jmp __idt_isr_common
__idt_isr_171: pushl 0; pushl 171; jmp __idt_isr_common
__idt_isr_172: pushl 0; pushl 172; jmp __idt_isr_common
__idt_isr_173: pushl 0; pushl 173; jmp __idt_isr_common
__idt_isr_174: pushl 0; pushl 174; jmp __idt_isr_common
__idt_isr_175: pushl 0; pushl 175; jmp __idt_isr_common
__idt_isr_176: pushl 0; pushl 176; jmp __idt_isr_common
__idt_isr_177: pushl 0; pushl 177; jmp __idt_isr_common
__idt_isr_178: pushl 0; pushl 178; jmp __idt_isr_common
__idt_isr_179: pushl 0; pushl 179; jmp __idt_isr_common
__idt_isr_180: pushl 0; pushl 180; jmp __idt_isr_common
__idt_isr_181: pushl 0; pushl 181; jmp __idt_isr_common
__idt_isr_182: pushl 0; pushl 182; jmp __idt_isr_common
__idt_isr_183: pushl 0; pushl 183; jmp __idt_isr_common
__idt_isr_184: pushl 0; pushl 184; jmp __idt_isr_common
__idt_isr_185: pushl 0; pushl 185; jmp __idt_isr_common
__idt_isr_186: pushl 0; pushl 186; jmp __idt_isr_common
__idt_isr_187: pushl 0; pushl 187; jmp __idt_isr_common
__idt_isr_188: pushl 0; pushl 188; jmp __idt_isr_common
__idt_isr_189: pushl 0; pushl 189; jmp __idt_isr_common
__idt_isr_190: pushl 0; pushl 190; jmp __idt_isr_common
__idt_isr_191: pushl 0; pushl 191; jmp __idt_isr_common
__idt_isr_192: pushl 0; pushl 192; jmp __idt_isr_common
__idt_isr_193: pushl 0; pushl 193; jmp __idt_isr_common
__idt_isr_194: pushl 0; pushl 194; jmp __idt_isr_common
__idt_isr_195: pushl 0; pushl 195; jmp __idt_isr_common
__idt_isr_196: pushl 0; pushl 196; jmp __idt_isr_common
__idt_isr_197: pushl 0; pushl 197; jmp __idt_isr_common
__idt_isr_198: pushl 0; pushl 198; jmp __idt_isr_common
__idt_isr_199: pushl 0; pushl 199; jmp __idt_isr_common
__idt_isr_200: pushl 0; pushl 200; jmp __idt_isr_common
__idt_isr_201: pushl 0; pushl 201; jmp __idt_isr_common
__idt_isr_202: pushl 0; pushl 202; jmp __idt_isr_common
__idt_isr_203: pushl 0; pushl 203; jmp __idt_isr_common
__idt_isr_204: pushl 0; pushl 204; jmp __idt_isr_common
__idt_isr_205: pushl 0; pushl 205; jmp __idt_isr_common
__idt_isr_206: pushl 0; pushl 206; jmp __idt_isr_common
__idt_isr_207: pushl 0; pushl 207; jmp __idt_isr_common
__idt_isr_208: pushl 0; pushl 208; jmp __idt_isr_common
__idt_isr_209: pushl 0; pushl 209; jmp __idt_isr_common
__idt_isr_210: pushl 0; pushl 210; jmp __idt_isr_common
__idt_isr_211: pushl 0; pushl 211; jmp __idt_isr_common
__idt_isr_212: pushl 0; pushl 212; jmp __idt_isr_common
__idt_isr_213: pushl 0; pushl 213; jmp __idt_isr_common
__idt_isr_214: pushl 0; pushl 214; jmp __idt_isr_common
__idt_isr_215: pushl 0; pushl 215; jmp __idt_isr_common
__idt_isr_216: pushl 0; pushl 216; jmp __idt_isr_common
__idt_isr_217: pushl 0; pushl 217; jmp __idt_isr_common
__idt_isr_218: pushl 0; pushl 218; jmp __idt_isr_common
__idt_isr_219: pushl 0; pushl 219; jmp __idt_isr_common
__idt_isr_220: pushl 0; pushl 220; jmp __idt_isr_common
__idt_isr_221: pushl 0; pushl 221; jmp __idt_isr_common
__idt_isr_222: pushl 0; pushl 222; jmp __idt_isr_common
__idt_isr_223: pushl 0; pushl 223; jmp __idt_isr_common
__idt_isr_224: pushl 0; pushl 224; jmp __idt_isr_common
__idt_isr_225: pushl 0; pushl 225; jmp __idt_isr_common
__idt_isr_226: pushl 0; pushl 226; jmp __idt_isr_common
__idt_isr_227: pushl 0; pushl 227; jmp __idt_isr_common
__idt_isr_228: pushl 0; pushl 228; jmp __idt_isr_common
__idt_isr_229: pushl 0; pushl 229; jmp __idt_isr_common
__idt_isr_230: pushl 0; pushl 230; jmp __idt_isr_common
__idt_isr_231: pushl 0; pushl 231; jmp __idt_isr_common
__idt_isr_232: pushl 0; pushl 232; jmp __idt_isr_common
__idt_isr_233: pushl 0; pushl 233; jmp __idt_isr_common
__idt_isr_234: pushl 0; pushl 234; jmp __idt_isr_common
__idt_isr_235: pushl 0; pushl 235; jmp __idt_isr_common
__idt_isr_236: pushl 0; pushl 236; jmp __idt_isr_common
__idt_isr_237: pushl 0; pushl 237; jmp __idt_isr_common
__idt_isr_238: pushl 0; pushl 238; jmp __idt_isr_common
__idt_isr_239: pushl 0; pushl 239; jmp __idt_isr_common
__idt_isr_240: pushl 0; pushl 240; jmp __idt_isr_common
__idt_isr_241: pushl 0; pushl 241; jmp __idt_isr_common
__idt_isr_242: pushl 0; pushl 242; jmp __idt_isr_common
__idt_isr_243: pushl 0; pushl 243; jmp __idt_isr_common
__idt_isr_244: pushl 0; pushl 244; jmp __idt_isr_common
__idt_isr_245: pushl 0; pushl 245; jmp __idt_isr_common
__idt_isr_246: pushl 0; pushl 246; jmp __idt_isr_common
__idt_isr_247: pushl 0; pushl 247; jmp __idt_isr_common
__idt_isr_248: pushl 0; pushl 248; jmp __idt_isr_common
__idt_isr_249: pushl 0; pushl 249; jmp __idt_isr_common
__idt_isr_250: pushl 0; pushl 250; jmp __idt_isr_common
__idt_isr_251: pushl 0; pushl 251; jmp __idt_isr_common
__idt_isr_252: pushl 0; pushl 252; jmp __idt_isr_common
__idt_isr_253: pushl 0; pushl 253; jmp __idt_isr_common
__idt_isr_254: pushl 0; pushl 254; jmp __idt_isr_common
__idt_isr_255: pushl 0; pushl 255; jmp __idt_isr_common

.align 32
__idt_start: 
  .wordt __idt_isr_0;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_0   >> 16)
  .wordt __idt_isr_1;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_1   >> 16)
  .wordt __idt_isr_2;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_2   >> 16)
  .wordt __idt_isr_3;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_3   >> 16)
  .wordt __idt_isr_4;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_4   >> 16)
  .wordt __idt_isr_5;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_5   >> 16)
  .wordt __idt_isr_6;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_6   >> 16)
  .wordt __idt_isr_7;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_7   >> 16)
  .wordt __idt_isr_8;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_8   >> 16)
  .wordt __idt_isr_9;   .word 0x0008; .word 0x8e00; .wordt (__idt_isr_9   >> 16)
  .wordt __idt_isr_10;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_10  >> 16)
  .wordt __idt_isr_11;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_11  >> 16)
  .wordt __idt_isr_12;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_12  >> 16)
  .wordt __idt_isr_13;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_13  >> 16)
  .wordt __idt_isr_14;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_14  >> 16)
  .wordt __idt_isr_15;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_15  >> 16)
  .wordt __idt_isr_16;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_16  >> 16)
  .wordt __idt_isr_17;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_17  >> 16)
  .wordt __idt_isr_18;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_18  >> 16)
  .wordt __idt_isr_19;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_19  >> 16)
  .wordt __idt_isr_20;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_20  >> 16)
  .wordt __idt_isr_21;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_21  >> 16)
  .wordt __idt_isr_22;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_22  >> 16)
  .wordt __idt_isr_23;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_23  >> 16)
  .wordt __idt_isr_24;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_24  >> 16)
  .wordt __idt_isr_25;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_25  >> 16)
  .wordt __idt_isr_26;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_26  >> 16)
  .wordt __idt_isr_27;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_27  >> 16)
  .wordt __idt_isr_28;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_28  >> 16)
  .wordt __idt_isr_29;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_29  >> 16)
  .wordt __idt_isr_30;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_30  >> 16)
  .wordt __idt_isr_31;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_31  >> 16)
  .wordt __idt_isr_32;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_32  >> 16)
  .wordt __idt_isr_33;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_33  >> 16)
  .wordt __idt_isr_34;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_34  >> 16)
  .wordt __idt_isr_35;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_35  >> 16)
  .wordt __idt_isr_36;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_36  >> 16)
  .wordt __idt_isr_37;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_37  >> 16)
  .wordt __idt_isr_38;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_38  >> 16)
  .wordt __idt_isr_39;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_39  >> 16)
  .wordt __idt_isr_40;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_40  >> 16)
  .wordt __idt_isr_41;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_41  >> 16)
  .wordt __idt_isr_42;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_42  >> 16)
  .wordt __idt_isr_43;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_43  >> 16)
  .wordt __idt_isr_44;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_44  >> 16)
  .wordt __idt_isr_45;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_45  >> 16)
  .wordt __idt_isr_46;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_46  >> 16)
  .wordt __idt_isr_47;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_47  >> 16)
  .wordt __idt_isr_48;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_48  >> 16)
  .wordt __idt_isr_49;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_49  >> 16)
  .wordt __idt_isr_50;  .word 0x0008; .word 0xEE00; .wordt (__idt_isr_50  >> 16)
  .wordt __idt_isr_51;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_51  >> 16)
  .wordt __idt_isr_52;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_52  >> 16)
  .wordt __idt_isr_53;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_53  >> 16)
  .wordt __idt_isr_54;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_54  >> 16)
  .wordt __idt_isr_55;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_55  >> 16)
  .wordt __idt_isr_56;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_56  >> 16)
  .wordt __idt_isr_57;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_57  >> 16)
  .wordt __idt_isr_58;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_58  >> 16)
  .wordt __idt_isr_59;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_59  >> 16)
  .wordt __idt_isr_60;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_60  >> 16)
  .wordt __idt_isr_61;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_61  >> 16)
  .wordt __idt_isr_62;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_62  >> 16)
  .wordt __idt_isr_63;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_63  >> 16)
  .wordt __idt_isr_64;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_64  >> 16)
  .wordt __idt_isr_65;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_65  >> 16)
  .wordt __idt_isr_66;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_66  >> 16)
  .wordt __idt_isr_67;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_67  >> 16)
  .wordt __idt_isr_68;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_68  >> 16)
  .wordt __idt_isr_69;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_69  >> 16)
  .wordt __idt_isr_70;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_70  >> 16)
  .wordt __idt_isr_71;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_71  >> 16)
  .wordt __idt_isr_72;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_72  >> 16)
  .wordt __idt_isr_73;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_73  >> 16)
  .wordt __idt_isr_74;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_74  >> 16)
  .wordt __idt_isr_75;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_75  >> 16)
  .wordt __idt_isr_76;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_76  >> 16)
  .wordt __idt_isr_77;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_77  >> 16)
  .wordt __idt_isr_78;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_78  >> 16)
  .wordt __idt_isr_79;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_79  >> 16)
  .wordt __idt_isr_80;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_80  >> 16)
  .wordt __idt_isr_81;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_81  >> 16)
  .wordt __idt_isr_82;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_82  >> 16)
  .wordt __idt_isr_83;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_83  >> 16)
  .wordt __idt_isr_84;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_84  >> 16)
  .wordt __idt_isr_85;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_85  >> 16)
  .wordt __idt_isr_86;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_86  >> 16)
  .wordt __idt_isr_87;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_87  >> 16)
  .wordt __idt_isr_88;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_88  >> 16)
  .wordt __idt_isr_89;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_89  >> 16)
  .wordt __idt_isr_90;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_90  >> 16)
  .wordt __idt_isr_91;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_91  >> 16)
  .wordt __idt_isr_92;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_92  >> 16)
  .wordt __idt_isr_93;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_93  >> 16)
  .wordt __idt_isr_94;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_94  >> 16)
  .wordt __idt_isr_95;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_95  >> 16)
  .wordt __idt_isr_96;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_96  >> 16)
  .wordt __idt_isr_97;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_97  >> 16)
  .wordt __idt_isr_98;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_98  >> 16)
  .wordt __idt_isr_99;  .word 0x0008; .word 0x8e00; .wordt (__idt_isr_99  >> 16)
  .wordt __idt_isr_100; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_100 >> 16)
  .wordt __idt_isr_101; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_101 >> 16)
  .wordt __idt_isr_102; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_102 >> 16)
  .wordt __idt_isr_103; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_103 >> 16)
  .wordt __idt_isr_104; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_104 >> 16)
  .wordt __idt_isr_105; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_105 >> 16)
  .wordt __idt_isr_106; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_106 >> 16)
  .wordt __idt_isr_107; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_107 >> 16)
  .wordt __idt_isr_108; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_108 >> 16)
  .wordt __idt_isr_109; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_109 >> 16)
  .wordt __idt_isr_110; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_110 >> 16)
  .wordt __idt_isr_111; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_111 >> 16)
  .wordt __idt_isr_112; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_112 >> 16)
  .wordt __idt_isr_113; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_113 >> 16)
  .wordt __idt_isr_114; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_114 >> 16)
  .wordt __idt_isr_115; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_115 >> 16)
  .wordt __idt_isr_116; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_116 >> 16)
  .wordt __idt_isr_117; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_117 >> 16)
  .wordt __idt_isr_118; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_118 >> 16)
  .wordt __idt_isr_119; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_119 >> 16)
  .wordt __idt_isr_120; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_120 >> 16)
  .wordt __idt_isr_121; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_121 >> 16)
  .wordt __idt_isr_122; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_122 >> 16)
  .wordt __idt_isr_123; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_123 >> 16)
  .wordt __idt_isr_124; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_124 >> 16)
  .wordt __idt_isr_125; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_125 >> 16)
  .wordt __idt_isr_126; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_126 >> 16)
  .wordt __idt_isr_127; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_127 >> 16)
  .wordt __idt_isr_128; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_128 >> 16)
  .wordt __idt_isr_129; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_129 >> 16)
  .wordt __idt_isr_130; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_130 >> 16)
  .wordt __idt_isr_131; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_131 >> 16)
  .wordt __idt_isr_132; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_132 >> 16)
  .wordt __idt_isr_133; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_133 >> 16)
  .wordt __idt_isr_134; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_134 >> 16)
  .wordt __idt_isr_135; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_135 >> 16)
  .wordt __idt_isr_136; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_136 >> 16)
  .wordt __idt_isr_137; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_137 >> 16)
  .wordt __idt_isr_138; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_138 >> 16)
  .wordt __idt_isr_139; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_139 >> 16)
  .wordt __idt_isr_140; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_140 >> 16)
  .wordt __idt_isr_141; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_141 >> 16)
  .wordt __idt_isr_142; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_142 >> 16)
  .wordt __idt_isr_143; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_143 >> 16)
  .wordt __idt_isr_144; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_144 >> 16)
  .wordt __idt_isr_145; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_145 >> 16)
  .wordt __idt_isr_146; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_146 >> 16)
  .wordt __idt_isr_147; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_147 >> 16)
  .wordt __idt_isr_148; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_148 >> 16)
  .wordt __idt_isr_149; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_149 >> 16)
  .wordt __idt_isr_150; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_150 >> 16)
  .wordt __idt_isr_151; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_151 >> 16)
  .wordt __idt_isr_152; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_152 >> 16)
  .wordt __idt_isr_153; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_153 >> 16)
  .wordt __idt_isr_154; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_154 >> 16)
  .wordt __idt_isr_155; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_155 >> 16)
  .wordt __idt_isr_156; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_156 >> 16)
  .wordt __idt_isr_157; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_157 >> 16)
  .wordt __idt_isr_158; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_158 >> 16)
  .wordt __idt_isr_159; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_159 >> 16)
  .wordt __idt_isr_160; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_160 >> 16)
  .wordt __idt_isr_161; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_161 >> 16)
  .wordt __idt_isr_162; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_162 >> 16)
  .wordt __idt_isr_163; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_163 >> 16)
  .wordt __idt_isr_164; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_164 >> 16)
  .wordt __idt_isr_165; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_165 >> 16)
  .wordt __idt_isr_166; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_166 >> 16)
  .wordt __idt_isr_167; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_167 >> 16)
  .wordt __idt_isr_168; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_168 >> 16)
  .wordt __idt_isr_169; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_169 >> 16)
  .wordt __idt_isr_170; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_170 >> 16)
  .wordt __idt_isr_171; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_171 >> 16)
  .wordt __idt_isr_172; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_172 >> 16)
  .wordt __idt_isr_173; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_173 >> 16)
  .wordt __idt_isr_174; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_174 >> 16)
  .wordt __idt_isr_175; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_175 >> 16)
  .wordt __idt_isr_176; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_176 >> 16)
  .wordt __idt_isr_177; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_177 >> 16)
  .wordt __idt_isr_178; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_178 >> 16)
  .wordt __idt_isr_179; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_179 >> 16)
  .wordt __idt_isr_180; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_180 >> 16)
  .wordt __idt_isr_181; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_181 >> 16)
  .wordt __idt_isr_182; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_182 >> 16)
  .wordt __idt_isr_183; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_183 >> 16)
  .wordt __idt_isr_184; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_184 >> 16)
  .wordt __idt_isr_185; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_185 >> 16)
  .wordt __idt_isr_186; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_186 >> 16)
  .wordt __idt_isr_187; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_187 >> 16)
  .wordt __idt_isr_188; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_188 >> 16)
  .wordt __idt_isr_189; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_189 >> 16)
  .wordt __idt_isr_190; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_190 >> 16)
  .wordt __idt_isr_191; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_191 >> 16)
  .wordt __idt_isr_192; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_192 >> 16)
  .wordt __idt_isr_193; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_193 >> 16)
  .wordt __idt_isr_194; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_194 >> 16)
  .wordt __idt_isr_195; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_195 >> 16)
  .wordt __idt_isr_196; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_196 >> 16)
  .wordt __idt_isr_197; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_197 >> 16)
  .wordt __idt_isr_198; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_198 >> 16)
  .wordt __idt_isr_199; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_199 >> 16)
  .wordt __idt_isr_200; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_200 >> 16)
  .wordt __idt_isr_201; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_201 >> 16)
  .wordt __idt_isr_202; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_202 >> 16)
  .wordt __idt_isr_203; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_203 >> 16)
  .wordt __idt_isr_204; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_204 >> 16)
  .wordt __idt_isr_205; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_205 >> 16)
  .wordt __idt_isr_206; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_206 >> 16)
  .wordt __idt_isr_207; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_207 >> 16)
  .wordt __idt_isr_208; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_208 >> 16)
  .wordt __idt_isr_209; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_209 >> 16)
  .wordt __idt_isr_210; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_210 >> 16)
  .wordt __idt_isr_211; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_211 >> 16)
  .wordt __idt_isr_212; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_212 >> 16)
  .wordt __idt_isr_213; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_213 >> 16)
  .wordt __idt_isr_214; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_214 >> 16)
  .wordt __idt_isr_215; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_215 >> 16)
  .wordt __idt_isr_216; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_216 >> 16)
  .wordt __idt_isr_217; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_217 >> 16)
  .wordt __idt_isr_218; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_218 >> 16)
  .wordt __idt_isr_219; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_219 >> 16)
  .wordt __idt_isr_220; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_220 >> 16)
  .wordt __idt_isr_221; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_221 >> 16)
  .wordt __idt_isr_222; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_222 >> 16)
  .wordt __idt_isr_223; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_223 >> 16)
  .wordt __idt_isr_224; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_224 >> 16)
  .wordt __idt_isr_225; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_225 >> 16)
  .wordt __idt_isr_226; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_226 >> 16)
  .wordt __idt_isr_227; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_227 >> 16)
  .wordt __idt_isr_228; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_228 >> 16)
  .wordt __idt_isr_229; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_229 >> 16)
  .wordt __idt_isr_230; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_230 >> 16)
  .wordt __idt_isr_231; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_231 >> 16)
  .wordt __idt_isr_232; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_232 >> 16)
  .wordt __idt_isr_233; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_233 >> 16)
  .wordt __idt_isr_234; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_234 >> 16)
  .wordt __idt_isr_235; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_235 >> 16)
  .wordt __idt_isr_236; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_236 >> 16)
  .wordt __idt_isr_237; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_237 >> 16)
  .wordt __idt_isr_238; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_238 >> 16)
  .wordt __idt_isr_239; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_239 >> 16)
  .wordt __idt_isr_240; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_240 >> 16)
  .wordt __idt_isr_241; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_241 >> 16)
  .wordt __idt_isr_242; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_242 >> 16)
  .wordt __idt_isr_243; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_243 >> 16)
  .wordt __idt_isr_244; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_244 >> 16)
  .wordt __idt_isr_245; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_245 >> 16)
  .wordt __idt_isr_246; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_246 >> 16)
  .wordt __idt_isr_247; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_247 >> 16)
  .wordt __idt_isr_248; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_248 >> 16)
  .wordt __idt_isr_249; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_249 >> 16)
  .wordt __idt_isr_250; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_250 >> 16)
  .wordt __idt_isr_251; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_251 >> 16)
  .wordt __idt_isr_252; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_252 >> 16)
  .wordt __idt_isr_253; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_253 >> 16)
  .wordt __idt_isr_254; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_254 >> 16)
  .wordt __idt_isr_255; .word 0x0008; .word 0x8e00; .wordt (__idt_isr_255 >> 16)
__idt_end:

.align 32
__gridos_idt_48:
__idt_table:
    .wordt ((__idt_end - __idt_start) - 1)
    .long __idt_start
.align 16 // 0x810
__gridos_gdt_48:
    .word   0x28        # 5 GDT entries
    .long   __gridos_gdt # gdt base 
.align 32 // 0x820
__gridos_gdt:
    .long 0; .long 0    # dummy
    
    .word 0xFFFF        # 4Gb - (0x100000*0x1000 = 4Gb)
    .word 0x0000        # base address = 0
    .byte 0; .byte 0x9A # code read/exec, ring 0
    .byte 0xCF; .byte 0 # granularity = 4096, 386
                        #  (+5th nibble of limit)
    
    .word 0xFFFF        # 4Gb - (0x100000*0x1000 = 4Gb)
    .word 0x0000        # base address = 0
    .byte 0; .byte 0x92 # data read/write, ring 0
    .byte 0xCF; .byte 0 # granularity = 4096, 386
                        #  (+5th nibble of limit)
    
    .word 0xFFFF        # 4Gb - (0x100000*0x1000 = 4Gb)
    .word 0x0000        # base address = 0
    .byte 0; .byte 0xFA # code read/exec, ring 3
    .byte 0xCF; .byte 0 # granularity = 4096, 386
                        #  (+5th nibble of limit)
    
    .word 0xFFFF        # 4Gb - (0x100000*0x1000 = 4Gb)
    .word 0x0000        # base address = 0
    .byte 0; .byte 0xF2 # data read/write, ring 3
    .byte 0xCF; .byte 0 # granularity = 4096, 386
                        #  (+5th nibble of limit)
# tss
__gridos_gdt_tss:
    .long 0x00; .long 0    # dummy
    .long 0x01; .long 0    # dummy
    .long 0x02; .long 0    # dummy
    .long 0x03; .long 0    # dummy
    # ...
.align 512
