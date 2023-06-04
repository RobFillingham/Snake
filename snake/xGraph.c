#include <X11/Xlib.h>
#include <unistd.h>
#include <stdio.h>

#define SNK_SIZE 10
#define FOOD_SIZE 7

char _setup();
void _draw();
void _drawString();
void _sleep(int var);
void _createRectangle(int index, short int x, short int y, short int height, short int width);
void _createRectangleColor(int index, short int x, short int y, short int height, short int width, int colorNum);
void _paintBlack();
void _drawBlack(int, int, int, int);

Display* disp;

Window ventana;
XColor color;
XRectangle recArray[SNK_SIZE];


char stringDraw[] = {'H','o','l','a',' ','M','u','n','d','o','!'};
char setUpSuccess = 0;
char size = 1, size2=1;

/*int main (){
    setup();
    createRectangle(1,100,100,50,50);
    draw();

    return 0;
}
*/
char _setup(char* s){

    printf("Holas desde asembli");
	disp = XOpenDisplay(NULL);
    
    if (disp == NULL){
        //printf("No se pudo realizar la conexion con el servidor X");
        return 0;
    }

    ventana = XCreateSimpleWindow (
		disp,
		XDefaultRootWindow (disp),
		0, 0,
		500, 500,
		1, 1,
		BlackPixel (disp, DefaultScreen(disp)));

    XSelectInput(disp, ventana, StructureNotifyMask);
	XMapWindow (disp, ventana);
	XFlush (disp);

    color.flags = DoRed | DoGreen | DoBlue;
	color.red = 62000;
	color.blue = 2000;
	color.green = 0;

	XAllocColor (
		disp,
		DefaultColormap (disp, DefaultScreen(disp)),
		&color);

	
	XSetForeground (
		disp,
		XDefaultGC (disp, DefaultScreen(disp)),
		color.pixel);

    for(;;){
        XEvent e;
        XNextEvent(disp, &e);
        if(e.type == MapNotify)
            return 1;
    }

}

void _draw(){
        //XClearWindow(disp, ventana);
        //_drawString();
        XFillRectangles (disp, ventana, XDefaultGC (disp, DefaultScreen(disp)),
		    recArray, size);
	    XFlush (disp);
        //sleep(1);
}


void _drawString(){
    if (setUpSuccess){
        XDrawImageString (disp, ventana, XDefaultGC (disp, DefaultScreen(disp)), 
            10, 10, stringDraw, 11);
	    XFlush (disp);
    }
}

void _createRectangle(int index, short int x, short int y, short int height, short int width){
    recArray[0].x = x;
    recArray[0].y = y;
    recArray[0].height = height;
    recArray[0].width = width;
    size++;
}

void _createRectangleColor(int index, short int x, short int y, short int height, short int width, int colorNum) {
    recArray[index].x = x;
    recArray[index].y = y;
    recArray[index].height = height;
    recArray[index].width = width;
    
    size++;

    switch(colorNum){
        case 1: {  //Se utiliza XParseColor para convertir el nombre de color "red" en una estructura XColor y luego XAllocColor para asignar un píxel a esa estructura. 
            XParseColor(disp, DefaultColormap(disp, DefaultScreen(disp)), "red", &color);
            XAllocColor(disp, DefaultColormap(disp, DefaultScreen(disp)), &color);
            XSetForeground(disp, XDefaultGC(disp, DefaultScreen(disp)), color.pixel);
            break;
        }
        case 2:{
            XParseColor(disp, DefaultColormap(disp, DefaultScreen(disp)), "blue", &color);
            XAllocColor(disp, DefaultColormap(disp, DefaultScreen(disp)), &color);
            XSetForeground(disp, XDefaultGC(disp, DefaultScreen(disp)), color.pixel);
            break;
        }
        case 3:{
            XParseColor(disp, DefaultColormap(disp, DefaultScreen(disp)), "green", &color);
            XAllocColor(disp, DefaultColormap(disp, DefaultScreen(disp)), &color);
            XSetForeground(disp, XDefaultGC(disp, DefaultScreen(disp)), color.pixel);
            break;
        }
        case 4:{
            XParseColor(disp, DefaultColormap(disp, DefaultScreen(disp)), "black", &color);
            XAllocColor(disp, DefaultColormap(disp, DefaultScreen(disp)), &color);
            XSetForeground(disp, XDefaultGC(disp, DefaultScreen(disp)), color.pixel);
            break;
        }
        case 5:{
            XParseColor(disp, DefaultColormap(disp, DefaultScreen(disp)), "white", &color);
            XAllocColor(disp, DefaultColormap(disp, DefaultScreen(disp)), &color);
            XSetForeground(disp, XDefaultGC(disp, DefaultScreen(disp)), color.pixel);
            break;
        }
    }
    
}

void _paintBlack(){
    XParseColor(disp, DefaultColormap(disp, DefaultScreen(disp)), "black", &color);
    XAllocColor(disp, DefaultColormap(disp, DefaultScreen(disp)), &color);
    XSetForeground(disp, XDefaultGC(disp, DefaultScreen(disp)), color.pixel);
    
}

void _drawBlack(int x, int y, int width, int height){
        //XClearWindow(disp, ventana);
        //_drawString();
        XFillRectangle(disp, ventana, XDefaultGC (disp, DefaultScreen(disp)),
		x, y, width, height);
	    XFlush (disp);
        //sleep(1);
}

// Limpiar pantalla
void _clearScreen() {
    XClearWindow(disp, ventana);
    XFlush(disp);
}

void _sleep(int var){
    usleep(var);
}