PFont myFont;
PImage bg;
String[] images = {"diner2.jpg"};
int index=0;

void setup(){
    size(1200,650);
    myFont = createFont("Georgia",20,true);
    //textFont(font);
    bg = loadImage(images[index]);
}

void draw(){
    background(0);
    intro();
    
}

void intro(){
    bg = loadImage(images[index]);
    image(bg,0,0);   
    textAlign(CENTER,CENTER);
    text("McDash",width/2,height/2);
    fill(120); //we will fix this color later
    //font
    textSize(100);
    //press any key to start game
     
}
