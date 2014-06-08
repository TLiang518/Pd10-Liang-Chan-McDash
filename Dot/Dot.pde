PFont myFont;
PImage bg, img;
String[] images ={"Gold1.png"};
int index = 0;
int screen = 1;
int xcor = 50;
int ycor = 50;
void setup(){
    size(1200,650);
    myFont = createFont("Georgia",20,true);
    //textFont(font);

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
      ycor = ycor - 5;
    }
    else if(keyCode == DOWN){
      ycor = ycor + 5;
    }
    else if(keyCode == LEFT){
      xcor = xcor - 5;
    }
    else if(keyCode == RIGHT){
      xcor = xcor + 5;
    }
    else if(keyCode == ENTER){
       println("(" + xcor + "," + ycor + ")");
    }
  }
}
void gameSetup(){
    
    img = loadImage(images[0]);
    image(img,xcor,ycor);
}
