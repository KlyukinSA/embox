#include <asm-generic/embox.lds.h>

#if __riscv_xlen == 64
OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv", "elf32-littleriscv")
#elif __riscv_xlen == 32
OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
#error "Unexpected __riscv_xlen"
#endif

OUTPUT_ARCH(riscv)

ENTRY(_start)

MEMORY {
	#include <regions.lds.h>
}

PROVIDE(_ram_base = ORIGIN(RAM));
PROVIDE(_ram_size = LENGTH(RAM));

SECTIONS {
	.text : {
		KEEP(*(.init));
		*(.text)
		*(.text.*)
	}

	.global_pointers : {
		. = ALIGN(4096);
		PROVIDE( __global_pointer$ = . + 0x800 );
	} SECTION_REGION(data)
}
