# asm-printf


A minimal printf implementation written in pure x86-64 assembly.
Parses format strings and handles escape sequences directly at the
syscall level, no C standard library involved.


## What this is


A follow-up to my [asm-calculator](https://github.com/ShahiTukda/asm-calculator) project. Wanted to see if I
could implement something closer to a real libc function instead of
just arithmetic. This one parses a format string character by character,
detects format specifiers and escape sequences, and writes output
directly via the write syscall.

Reuses atoi and itoa from the calculator project for %d formatting.


## Supported format specifiers


%d      prints an integer argument

%s      prints a string argument

%%      prints a literal percent sign


## Supported escape sequences


\n      newline

\xHH    arbitrary byte via 2-digit hex (e.g. \x41 prints 'A')

\\      prints a literal backslash sign


## Build


[makefile](https://github.com/ShahiTukda/asm-printf/blob/main/Makefile)


## Usage


./printf "format string" arg1 arg2 ...


Examples:


./printf "value is %d\n" 42

./printf "hello %s\n" world

./printf "escaped: \x48\x69\n"


## How it works


The program walks the format string one byte at a time. On hitting
a `%` or `\`, it looks ahead one character to decide what to do —
print a converted argument, print a literal character, or handle
an escape sequence. Integer arguments are pulled from the stack
(where argv places them) and converted using a handwritten atoi/itoa
pair. Everything else is written directly via raw write syscalls,
one byte or one chunk at a time.


## Notes


Written to push past the calculator project — handling variable
arguments and format parsing in raw assembly instead of just fixed
arithmetic. Code reflects my current understanding, not necessarily
the most optimal way to do this.
