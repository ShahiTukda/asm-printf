all: printf

atoi.o: src/atoi.s
	as -o atoi.o src/atoi.s

itoa.o: src/itoa.s
	as -o itoa.o src/itoa.s

printf.o: src/printf.s
	as -o printf.o src/printf.s

printf: atoi.o itoa.o printf.o
	ld -o printf atoi.o itoa.o printf.o

clean:
	rm -f *.o printf
