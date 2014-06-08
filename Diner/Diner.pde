PFont myFont, myFont2;
PImage bg, img, img2, img3;
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
int c, cmin, csec, cmil;
int climit = 10;
int foodOrder = 0;
int goalX = 0;
int goalY = 0;
int mousex = 480;
int mousey = 100;
int served = 0;
int[] custCoordX = new int[20];
int[] custCoordY = new int[20];
int[] custPlace = new int[20];
int[] table = new int[20];
ArrayList<Integer> custLine1 = new ArrayList<Integer>();
ArrayList<Integer> custLine2 = new ArrayList<Integer>();
Player p;
Customer[] customers = new Customer[20];

void setup(){
    size(1200,650);
    myFont = createFont("Georgia",20,true);
    myFont2 = createFont("Verdana",5,true);
    bg = loadImage(images[index]);
    savedTime=millis();
    for (int i=0; i < table.length; i ++){
      table[i]=-1;
    }
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
      int tempX = coorX;
      int tempY = coorY;
      if(keyCode == UP){
        coorY=coorY-5;
      }
      else if(keyCode == DOWN){
        coorY=coorY+5;
      }
      else if(keyCode == LEFT){
        coorX = coorX - 5;
      }
      else if(keyCode == RIGHT){
        coorX = coorX + 5;
      }
      if (outOfBounds(coorX,coorY)){
        //println("("+(coorX+a)+","+(coorY+b)+")");
        coorX = tempX;
        coorY = tempY;
      }
    }
    if (keyCode==ENTER){
       println("("+(coorX+a)+","+(coorY+b)+")");
    }
  }
}

void mousePressed(){
  if (screen==1){
     int cust = overCust(mouseX,mouseY);
     if (cust >= 0){
       println("Clicked picture");
       table.add(cust);
       custPlace[cust]=3+(indexOfArray(table,cust));
       if (custLine1.indexOf(cust)>=0){
         custLine1.remove(custLine1.indexOf(cust));
       }
       else{
         custLine2.remove(custLine2.indexOf(cust));
       }
     }
     int cust2 = overCustTable(mouseX, mouseY);
     else if (cust2 >= 0){
       moveToward(cust2,140,10);
       custPlace[cust2]=0;
       table[cust2]=-1;
     }
     else{
     int tempX = goalX;
     int tempY = goalY;
     goalX = (mouseX/5)*5;
     goalY = (mouseY/5)*5;
     if (outOfBounds(goalX,goalY)){
        //println("("+(coorX+a)+","+(coorY+b)+")");
        goalX = tempX;
        goalY = tempY;
      }
     }
  }
}

void gameSetup(){
    bg = loadImage(images[1]);
    img = loadImage(images[2]); 
    img.resize(67,96);
    image(bg,CENTER,CENTER);
    image(img,coorX,coorY);
    fill(207,218,65);
    textSize(100); 
    
    //countdown timer
    c = climit*60*1000 - millis();
    cmin = (c/(60*1000));
    csec = (c/(100)); 
    //cmil = (c/(60*100));
    textSize(50);
    text(cmin+ ":" + csec, 1100,50);

   foodAppear();//testing
   getFood();
   displayFood();
    
   for (int i = 0; i < numCust; i ++){
      image(custim[i], custCoordX[i], custCoordY[i]);          
      if (custPlace[i]==1){
        moveToward(i,95,445-105*(custLine1.indexOf(i)));
      }
      else if (custPlace[i]==2){
        moveToward(i,180,445-105*(custLine2.indexOf(i)));
      }
      else if (custPlace[i]>=3 && custPlace[i]<=7){
        moveToward(i, 455 + 155*(custPlace[i]-3), 165);
      }
      else {
        moveToward(i, 455 + 155*(custPlace[i]-8), 325);
      }
      if (custPlace[i]==0 && custCoordX[i]==140 && custCoordY[i]==10){
        custCoordX[i]=0;
        custCoordY[i]=0;
        custim[i]=null;
        customers[i]=null;
        numCust--;
      }
    }

    moveToward();
    
    int passedTime=millis()-savedTime;
    if (passedTime > 10000){
        if (numCust < 10){  
          int temp = (int)(Math.random()*4);
          int index = addToArray(customers,null,newCustomer(p));
          if (custLine2.size()<custLine1.size()){
            custLine2.add(index);
            custPlace[index]=2;
          }
          else{
            custLine1.add(index);
            custPlace[index]=1;
          }
          custim[index]=loadImage(images[4+temp]);
          if(4+temp == 4){
            custim[index].resize(60,120);
          }
          if(4+temp == 5){
            custim[index].resize(35,40);
          }
          if(4+temp == 6){
            custim[index].resize(83,100);
          }
          if(4+temp == 7){
            custim[index].resize(68,128);
          }
          //int tempCoord = (int)(Math.random()*500);
          custCoordX[index]=140;
          custCoordY[index]=10;
          numCust ++;
        }
        savedTime=millis();
    }
}

int addToArray(Object[] a, Object nullvalue, Object addvalue){
 for (int i = 0; i < a.length; i ++){
  if (a[i]==nullvalue){
   a[i]=addvalue;
   return i;
  } 
 }
}

void foodAppear(){
  //int passedTime = millis() -savedTime;    
   if(Customer.giveOrder() == 1){
   //  if(passedTime > 5000){
     img3 = loadImage(images[8]); 
     img3.resize(45,57);
     image(img3, mousex,mousey);
     }
   }
//}

void getFood(){
  if (mouseX <= mousex + 15 && mouseX >= mousex - 15 && mouseY <= mousey+15 && mouseY >= mousey-15){
     img3 = loadImage(images[8]); 
     img3.resize(45,57);
     image(img3, mousex+5,mousey+100);
     served ++;
  }
  
}

void displayFood(){
    if (served != 0){
     img3 = loadImage(images[8]); 
     img3.resize(45,57);
     image(img3, mousex+5,mousey+100); //replace with coordinates of requested tables.
    }
}

boolean outOfBounds(int x,int y){
  //Walls
  if ((x<-10)||(x>1165)||(y<-10)||(y>490)){
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

void moveToward(){
    if (goalX!=0){
      int tempX = coorX;
        if (coorX < goalX){
          coorX = coorX + 5;
        }
        else if (coorX > goalX){
         coorX = coorX - 5;
      }
       else{
         goalX = 0;
       }
       if (outOfBounds(coorX,coorY)){
         coorX= tempX;
         moveTowardY();
       }
    }
    else{
      moveTowardY();
    }
}

void moveTowardY(){
    if (goalY!=0){
        if (coorY < goalY){
          coorY = coorY + 5;
        }
        else if (coorY > goalY){
          coorY = coorY - 5;
        }
        else{
          goalY = 0;
        }
    }
}

void moveToward(int c, int x, int y){
   if (custCoordX[c]!=x){
     int tempX = custCoordX[c];
     if (custCoordX[c] < x){
          custCoordX[c] = custCoordX[c] + 5;
        }
        else if (custCoordX[c] > x){
         custCoordX[c] = custCoordX[c] - 5;
      }
       if (outOfBounds(custCoordX[c],custCoordY[c])){
         custCoordX[c]= tempX;
         moveTowardY(c,x,y);
       }
    }
    else{
      moveTowardY(c,x,y);
    }
}

void moveTowardY(int c, int x, int y){
  if (custCoordY[c]!=y){
        if (custCoordY[c] < y){
          custCoordY[c] = custCoordY[c] + 5;
        }
        else if (custCoordY[c] > y){
          custCoordY[c] = custCoordY[c] - 5;
        }
    }
}

int indexOfArray(int[] a, int i){
  for (int k = 0; k < a.length; k ++){
    if (a[k]==i){
      return k;
    }
  }
}

int overCustTable(int x, int y){
  int overCust(int x, int y);
  for (int i = 0; i < 20; i ++){
    if ((custCoordX[i]!=0)&&(x>=custCoordX[i] && x<=custCoordX[i]+custim[i].width) && (y>=custCoordY[i] && y<=custCoordY[i]+custim[i].height) && (indexOfArray(table,i)>=0){
      return i;
    }
  }
  return -1;
}


int overCust(int x, int y){
  for (int i = 0; i < numCust; i ++){
    if ((x>=custCoordX[i] && x<=custCoordX[i]+custim[i].width) && (y>=custCoordY[i] && y<=custCoordY[i]+custim[i].height) && (custLine1.indexOf(i)>=0 || custLine2.indexOf(i)>=0)){
      return i;
    }
  }
  return -1;
}

