PFont myFont;
PImage bg, img;
String[] images ={"testpic.jpg","coorfind.png"};
int a = 0;
int b = 0;
int index = 0;
int screen = 0;
void setup(){
    size(1200,650);
    myFont = createFont("Georgia",20,true);
    //textFont(font);
    bg = loadImage(images[index]);

}

void draw(){
    background(0);
   
    if (screen==1){
      gameSetup();   
    }
}



void startScreen(){
    if (key == ENTER){
        screen = 1;
    }
}
void keyPressed(){
  if (screen == 1){
    if(keyCode == UP){
     b = b - 5;
    }
    else if(keyCode == DOWN){
      b = b + 5;
    }
    else if(keyCode == LEFT){
      a = a - 5;
    }
    else if(keyCode == RIGHT){
      a = a + 5;
    }
  }
}
void gameSetup(){
    bg = loadImage(images[0]);
    img = loadImage(images[1]);
    img.resize(10,10);
    image(img,50+a,50+b);
}
