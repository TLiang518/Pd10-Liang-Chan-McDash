PFont myFont, myFont2;
PImage bg, img, img2, img3;
PImage[] custim = new PImage[20];
String[] images = {"diner2.jpg","testpic.jpg","girl.png", "coorfind.png","peter.png","stewie.png","chris.png","lois.png", "icecream.png", "bacon.png","muffin.png"};
int screen = 0;
int a = 0, b = 0;
int coorX = 100 , coorY = 100;
int savedTime1,savedTime2;
int numCust = 0;
int c, cmin, csec, cmil;
int climit = 10;
int foodOrder = 0;
int goalX = 0, goalY = 0;
int mousex = 480, mousey = 100;
int served = 0, served2 = 0, served3 = 0;
int orderNum = 0;
int score = 0;
int corder = -1;
int[] custCoordX = new int[20];
int[] custCoordY = new int[20];
int[] custPlace = new int[20];
int[] table = new int[10];
String[] tableOrder = new String[10];
int[] foodCoordX = new int[20];
int[] foodCoordY = new int[20];
ArrayList<Integer> orders = new ArrayList<Integer>();
ArrayList<PImage> foodim = new ArrayList<PImage>();
ArrayList<Integer> madeOrders = new ArrayList<Integer>();
ArrayList<Integer> custLine1 = new ArrayList<Integer>();
ArrayList<Integer> custLine2 = new ArrayList<Integer>();
Player p;
Customer[] customers = new Customer[20];


void setup(){
    size(1200,650);
    myFont = createFont("Georgia",20,true);
    myFont2 = createFont("Verdana",5,true);
    bg = loadImage(images[0]);
    savedTime1=millis();
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
      //countdown timer
      c = 600000 - millis();
      cmin = (c/60000);
      csec = (c%60000)/1000;
      textSize(50);
      PFont f = createFont("Arial",28, true);
      textFont(f);
      text(cmin + ":" +csec, 600,630);
    }
}

void intro(){
    bg = loadImage(images[0]);
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
     int food = overFood(mouseX,mouseY);
     int cust = overCust(mouseX,mouseY);
     int cust2 = overCustTable(mouseX, mouseY);
     if (cust >= 0){
       println("Clicked picture");
       addToArray(table,-1,cust);
       orders.add(customers[cust].giveOrder());
       custPlace[cust]=3+(indexOfArray(table,cust));
       if (custLine1.indexOf(cust)>=0){
         custLine1.remove(custLine1.indexOf(cust));
       }
       else{
         custLine2.remove(custLine2.indexOf(cust));
       }
     }
     else if (cust2 >= 0){
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

   foodAppear();
   displayScore();
  
    
   for (int i = 0; i < numCust; i ++){
      if (customers[i]!=null){
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
        else if (custPlace[i]==0){
          if (custCoordX[i]==140 && custCoordY[i]==10){
            custCoordX[i]=0;
            custCoordY[i]=0;
            custim[i]=null;
            customers[i]=null;
            numCust--;
          }
          else {
            moveToward(i,140,10);
          }
        }
        else {
          moveToward(i, 455 + 155*(custPlace[i]-8), 325);
        }
      }
    }

    moveToward();
    
    int passedTime=millis()-savedTime1;
    if (passedTime > 10000){
        if (numCust < 10){  
          int temp = (int)(Math.random()*4);
          int index = addToArray(customers,new Customer(p));
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
        savedTime1=millis();
    }
    
  int passedTime2 = millis() -savedTime2;    
  if (passedTime2 > 5000 & orders.size() > 0){
    madeOrders.add(orders.remove(0));
    savedTime2 = millis();
    foodim.add(loadImage(images[8+madeOrders.get(madeOrders.size()-1)]));
  }
  
  if (coorX >= 435 && coorX <= 510 && coorY >= 60 && coorY <= 130 && corder == -1){
    getOrder();
  }
  
  convertOrdertoString();
  foodAppear();
  displayOrders();
  displayScore();
}

int addToArray(Object[] a, Object addvalue){
 for (int i = 0; i < a.length; i ++){
  if (a[i]==null){
   a[i]=addvalue;
   return i;
  }
 }
 return -1;
}

int addToArray(int[] a, int nullvalue, int addvalue){
 for (int i = 0; i < a.length; i ++){
  if (a[i]==nullvalue){
   a[i]=addvalue;
   return i;
  }
 }
 return -1;
}


void foodAppear(){
  if (madeOrders.size()>0){
     for (int i = 0; i < madeOrders.size(); i ++){
       if (madeOrders.get(i)==0){
         foodim.get(i).resize(45,57);
       }
       if (madeOrders.get(i)==1){
         foodim.get(i).resize(50,50);
       }
       if (madeOrders.get(i)==2){
         foodim.get(i).resize(42,59);
       }
       image(foodim.get(i), mousex + (i*50), mousey);
     }
  }
}

void displayFood(){
    if (served != 0){
     img3 = loadImage(images[8]); 
     img3.resize(45,57);
     image(img3, mousex+5,mousey+100); //replace with coordinates of requested tables.
    }
    if (served2 != 0){
     img3 = loadImage(images[9]); 
     img3.resize(50,50);
     image(img3, mousex+20,mousey+100);//tmp
    }
    if (served3 != 0){
      img3 = loadImage(images[10]); 
     img3.resize(42,59);
     image(img3, mousex+50,mousey+100);//tmp
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
  return -1;
}

int overCustTable(int x, int y){
  for (int i = 0; i < 20; i ++){
    if ((custCoordX[i]!=0)&&(x>=custCoordX[i] && x<=custCoordX[i]+custim[i].width) && (y>=custCoordY[i] && y<=custCoordY[i]+custim[i].height) && (indexOfArray(table,i)>=0)){
      return i;
    }
  }
  return -1;
}

   
int overCust(int x, int y){
  for (int i = 0; i < 20; i ++){
    if (custCoordX[i] > 0){
      if ((x>=custCoordX[i] && x<=custCoordX[i]+custim[i].width) && (y>=custCoordY[i] && y<=custCoordY[i]+custim[i].height) && (custLine1.indexOf(i)>=0 || custLine2.indexOf(i)>=0)){
        return i;
      }
    }
  }
  return -1;
}

int overFood(int x, int y){
    for (int i = 8; i <= 10; i ++){
      if (foodCoordX[i] > 0){
      if ((x>=foodCoordX[i] && x<=foodCoordX[i]+custim[i].width) && (y>=foodCoordY[i] && y<=custCoordY[i]+custim[i].height)) {
         return i;
      }
    }
    }
    return -1;
}

void displayScore(){
   PFont f = createFont("Arial",16,true);
   textFont(f); 
    textAlign(RIGHT);
    text("Score: " + score,1125,630);
}

void convertOrdertoString(){
  for (int i = 0; i < table.length; i ++){  
    if (table[i]==-1){
      tableOrder[i]="Empty";
    }
    else{
      if (customers[table[i]].giveOrder()==0){
        tableOrder[i]="Ice Cream";
      }
      else if (customers[table[i]].giveOrder()==1){
        tableOrder[i]="Bacon";
      }
      else{
        tableOrder[i]="Muffin";
      }
    }
  }
}

void displayOrders(){
  String result = "";
  String currentOrder = "";
  PFont f = createFont("Arial",12,true);
  for (int i = 0; i < table.length; i ++){
    result = result + "Table " + (i+1) + ": " + tableOrder[i] + "      ";
  }
  textFont(f); 
  textAlign(LEFT);
  text(result,25,600);
  
  if (corder == -1){
    currentOrder = "None";
  }
  else if (corder == 0){
    currentOrder = "Ice Cream";
  }
  else if (corder == 1){
    currentOrder = "Bacon";
  }
  else if (corder == 2){
    currentOrder = "Muffin";
  }
  PFont f2 = createFont("Arial",16, true);
  textFont(f2);
  textAlign(LEFT);
  text("Order in Hand: " + currentOrder, 25, 630);  
}

void getOrder(){
  if (madeOrders.size()>0){
    corder = madeOrders.remove(0);
  }
}
