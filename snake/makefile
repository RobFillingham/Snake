xGraph: xGraph_client.o xGraph.c check_key.c
	gcc -m32 xGraph.c check_key.c xGraph_client.o -o xGraph -lX11 -no-pie

xGraph_client.o: xGraph_client.asm
	nasm -f elf32 xGraph_client.asm -g -F dwarf -o xGraph_client.o

clean:
	rm -f *.o xGraph

