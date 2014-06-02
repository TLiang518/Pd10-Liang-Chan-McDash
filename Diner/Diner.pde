PFont myFont;
PImage bg, img;
<<<<<<< HEAD
String[] images = {"diner2.jpg","testpic.jpg","girl.png",
"peter.png","stewie.png","meg.png","chris.png","lois.png"};
=======
String[] images = {"diner2.jpg","testpic.jpg","girl.png"};
>>>>>>> f3f3dd83047c1a3efb6ec5a0ffb7e8f303dee43a
int index=0;
int screen = 0;
int coorX = 100;
int coorY = 100;
int a = 0;
int b = 0;


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
      gameSetup();

    }
}

void intro(){
    bg = loadImage(images[index]);
    image(bg,0,0);
    textAlign(CENTER,CENTER);
    text("McDash",width/2,height/2);
    fill(207,218,65);
    textSize(200);
    startScreen();

    
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
<<<<<<< HEAD
   
}

void gameSetup(){
    bg = loadImage(images[1]);
    img = loadImage(images[2]);
    img.resize(67,96);
=======
    //doesn't work need to fix!!!
}

void gameSetup(){
     bg = loadImage(images[1]);  
     img = loadImage(images[2]);  
     img.resize(67,96);
>>>>>>> f3f3dd83047c1a3efb6ec5a0ffb7e8f303dee43a
    image(bg,CENTER,CENTER);
    image(img,coorX+a,coorY+b);
    fill(207,218,65);
    textSize(100);
   
}


