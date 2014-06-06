PFont myFont, myFont2;
PImage bg, img, img2;
PImage[] custim = new PImage[20];
String[] images = {"diner2.jpg","testpic.jpg","girl.png", "coorfind.png","peter.png","stewie.png","chris.png","lois.png", "icecream.png"};
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
Customer[] custLine1 = new Customer[5];
Customer[] custLine2 = new Customer[5];
Player p;
Customer[] customers = new Customer[20];

void setup(){
    size(1200,650);
    myFont = createFont("Georgia",20,true);
    myFont2 = createFont("Verdana",20,true);
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
    textFont(myFont);
    fill(0);
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
    if ((keyCode==UP)||(keyCode==DOWN)||(keyCode==LEFT)||(keyCode==RIGHT)){
      int tempA = a;
      int tempB = b;
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
      if (outOfBounds(coorX+a,coorY+b)){
        //println("("+(coorX+a)+","+(coorY+b)+")");
        a = tempA;
        b = tempB;
      }
    }
    if (keyCode==ENTER){
       println("("+(coorX+a)+","+(coorY+b)+")");
    }
  }
}

void mouseDragged(){
}

//for dragging customers to tables?
//or should they plop onto random tables themselves?


void gameSetup(){
    bg = loadImage(images[1]);
    img = loadImage(images[2]); 
    img.resize(67,96);
    image(bg,CENTER,CENTER);
    image(img,coorX+a,coorY+b);
    fill(207,218,65);
    textSize(100); 
    
    
    for (int i = 0; i < numCust; i ++){
      if (Math.random()*100 > 90){
        int newCoor = custCoordX[i]+(((int)(Math.random()*3)-1)*5);
        if (!outOfBounds(newCoor,custCoordY[i])){
          custCoordX[i]=newCoor;
        }  
      }
      if (Math.random()*100 > 90){
        int newCoor = custCoordX[i]+(((int)(Math.random()*3)-1)*5);
        if (!outOfBounds(custCoordX[i],newCoor)){
          custCoordY[i]=newCoor;
        }
      }
      image(custim[i], custCoordX[i], custCoordY[i]);  
    }
    int passedTime=millis()-savedTime;
    if (passedTime > 10000){
        if (numCust < 5){  
          int temp = (int)(Math.random()*4);
          customers[numCust]=new Customer(p);
          custim[numCust]=loadImage(images[4+temp]);
          if(4+temp == 4){
            custim[numCust].resize(60,120);
          }
          if(4+temp == 5){
            custim[numCust].resize(35,40);
          }
          if(4+temp == 6){
            custim[numCust].resize(83,100);
          }
          if(4+temp == 7){
            custim[numCust].resize(68,128);
          }
          
          //int tempCoord = (int)(Math.random()*500);
          custCoordX[numCust]=165;
          custCoordY[numCust]=35;
          numCust ++;
        }
        savedTime=millis();
    }
}

boolean outOfBounds(int x,int y){
  //Walls
  if ((x<-10)||(x>1165)||(y<-10)||(y>580)){
    return true;
  }
  //Kitchen
  if (x>430 && x<1075 && y<115){
    return true;
  }
  //tables
  if (((y>165 && y<290)||(y>325 && y<445))&&((x>415 && x<490)||(x>570 && x<645)||(x>715 && x<790)||(x>865 && x<950)||(x>1010 && x<1085))){
    return true;
  } 
  return false;
}

void moveToward(int c, int x, int y){
  while (custCoordX[c]!=x){
    if (custCoordX[c] < x){
      custCoordX[c] = custCoordX[c]+5;
    }
    else {
      custCoordX[c]= custCoordX[c]-5;
    }
  }
  while (custCoordY[c]!=y){
    if (custCoordY[c] < y){
      custCoordY[c] = custCoordY[c]+5;
    }
    else {
      custCoordY[c]= custCoordY[c]-5;
    }
  }
}

void goOnLine(Customer c){
  //if no room in line 1 or 2, customer leaves, lose points
  //if lines are uneven, place customer in the line with less people, else in line 1
  //image moves TOWARD correct coordinate. 
  //refresh line, people move down
}

/*void makeText(){
   textAlign(400,1000);
   if(coorX == 100 && coorY == 100){
     text("Use ARROW KEYS to move!",400,1000);
     textFont(myFont2);
     fill(0);
     textSize(50);
   }
}
*/

