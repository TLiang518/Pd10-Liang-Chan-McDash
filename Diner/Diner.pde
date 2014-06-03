PFont myFont;
PImage bg, img, img2;
PImage[] custim = new PImage[20];

String[] images = {"diner2.jpg","testpic.jpg","girl.png", "coorfind.png",
"peter.png","stewie.png","chris.png","lois.png"};

int index=0;
int screen = 0;
int coorX = 100;
int coorY = 100;
int a = 0;
int b = 0; 
int savedTime;
int numCust = 0;
int[] custCoordX = new int[20];
int[] custCoordY = new int[20];
Player p;
Customer[] customers = new Customer[20];

void setup(){
    size(1200,650);
    myFont = createFont("Georgia",20,true);
    //textFont(font);
    bg = loadImage(images[index]);
    savedTime=millis();
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
}

void gameSetup(){
    bg = loadImage(images[1]);
    img = loadImage(images[2]); 
    img.resize(67,96);
    image(bg,CENTER,CENTER);
    image(img,coorX+a,coorY+b);
    fill(207,218,65);
    textSize(100); 
    //img2 = loadImage(images[3]);
    //img2.resize(10,10);
    //image(img2,50+a,50+b);
    for (int i = 0; i < numCust; i ++){
      if (Math.random()*100 > 90){
        custCoordX[i]=custCoordX[i]+(int)(Math.random()*11) - 5;
      }
      if (Math.random()*100 > 90){
        custCoordY[i]=custCoordX[i]+(int)(Math.random()*11) - 5;
      }
      image(custim[i], custCoordX[i], custCoordY[i]);  
    }
    int passedTime=millis()-savedTime;
    if (passedTime > 10000){
        if (numCust < 5){  
          int temp = (int)(Math.random()*4);
          customers[numCust]=new Customer(p);
          custim[numCust]=loadImage(images[4+temp]);
          custim[numCust].resize(67,96);
          int tempCoord = (int)(Math.random()*500);
          custCoordX[numCust]=tempCoord;
          custCoordY[numCust]=tempCoord;
          numCust ++;
        }
        savedTime=millis();
    }
}


