PFont myFont;
PImage bg;
String[] images = {"diner2.jpg","testpic.jpg"};
int index=0;
int screen = 0;

void setup(){
    size(1200,650);
    myFont = createFont("Georgia",20,true);
    //textFont(font);
    bg = loadImage(images[index]);
}

void draw(){
    background(0);
    if (screen==0){
      intro();
    }
    if (screen==1){
      game();
    }  
}

void intro(){
    bg = loadImage(images[index]);
    image(bg,0,0);   
    textAlign(CENTER,CENTER);
    text("McDash",width/2,height/2);
    fill(207,218,65);
    //font
    textSize(200);
   /* textAlign(CENTER, BOTTOM);
    text("Press ANY key to START!!!",width/10,height/10);
    fill(100,100,20);
    textSize(50);
    */
    
}

void keyPressed(){
    if (key == ENTER){
        screen = 1;
    }
}

void game(){
     bg = loadImage(images[1]);
    image(bg,CENTER,CENTER);   
    textAlign(CENTER,CENTER);
    text("Game Screen",width/2,height/2);
    fill(207,218,65); //we will fix this color later
    textSize(100);
}
