PFont myFont;
PImage bg;
String[] images = {"diner2.jpg"};
int index=0;

void setup(){
    size(1200,650);
    myFont = createFont("Georgia",20,true);
    bg = loadImage(images[index]);
}

void draw(){
    background(0);
    intro();
    
}

void intro(){
    bg = loadImage(images[index]);
    image(bg,0,0);
    textFont("Georgia", 32);
    text("McDash",10,30);
     
}

