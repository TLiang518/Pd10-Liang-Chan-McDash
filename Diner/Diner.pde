PFont myFont;
PImage bg, img;
String[] images = {"diner2.jpg","testpic.jpg","girl.jpg"};
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
    
    
    
}

void keyPressed(){
    if (key == ENTER){
        screen = 1;
    }
}

void gameSetup(){
     bg = loadImage(images[1]);  
     img = loadImage(images[2]);  
    image(bg,CENTER,CENTER);
    img.resize(55,110);   
    image(img,100,100);
    
    textAlign(CENTER,CENTER);
    text("Game Screen",width/2,height/2);
    fill(207,218,65); 
    textSize(100);
   
}


  
