xGraph: xGraph_client.o xGraph.c
	gcc -m32 xGraph.c -lX11 xGraph_client.o -o xGraph -no-pie 

xGraph_client.o: xGraph_client.asm
	nasm -f elf32 xGraph_client.asm -g -F dwarf

clean:
	rm -f *.o
