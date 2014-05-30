PFont myFont;
PImage bg, img;
String[] images = {"diner2.jpg","testpic.jpg","girl.jpg"};
int index=0;
int screen = 0;
int coorX = 100;
int coorY = 100;
//coordinates of diner girl

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
    if(keyCode == UP){
     img.resize(55,110);   
     image(img,coorX,coorY+10);
    }
    else if(keyCode == DOWN){
      img.resize(55,110);   
      image(img,coorX,coorY-10);      
    }
    else if(keyCode == LEFT){
      img.resize(55,110);   
      image(img,coorX-10,coorY);
    }
    else if(keyCode == RIGHT){
      img.resize(55,110);   
      image(img,coorX+10,coorY);
    }
    //doesn't work need to fix!!!
}

void gameSetup(){
     bg = loadImage(images[1]);  
     img = loadImage(images[2]);  
    image(bg,CENTER,CENTER);
    img.resize(55,110);   
    image(img,coorX,coorY);
    
    textAlign(CENTER,CENTER);
    text("Game Screen",width/2,height/2);
    fill(207,218,65); 
    textSize(100);
   
}


  
