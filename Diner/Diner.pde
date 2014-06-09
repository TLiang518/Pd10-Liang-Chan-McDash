PFont myFont, myFont2;
PImage bg, img, img2, img3;
PImage[] custim = new PImage[20];
String[] images = {"startup.jpg","restaurant.jpg","Red.png", "coorfind.png","Blue.png","Whitney.png","Falkner.png","Misty.png", "icecream.png", "bacon.png","muffin.png","plate.png"};
int screen = 0;
int a = 0, b = 0;
int coorX = 100 , coorY = 100;
int savedTime1,savedTime2;
int numCust = 0;
int c, cmin, csec;
int kitchenX = 480, kitchenY = 100;
int goalX = 0, goalY = 0;
int score = 0;
int corder = -1;
int[] custCoordX = new int[20];
int[] custCoordY = new int[20];
int[] custPlace = new int[20];
int[] table = new int[10];
String[] tableOrder = new String[10];
int[] receivedOrder = new int[10];
int[] foodCoordX = new int[20];
int[] foodCoordY = new int[20];
int[] tableTimer = new int[10];
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
      receivedOrder[i]=-1;
    }
}

void draw(){
    background(0);
    if (screen==0){
      intro();
    }
    if (screen==1){
      gameSetup(); 
      timer();
    }
}

void timer(){
      c = 600000 - millis();
      cmin = (c/60000);
      csec = (c%60000)/1000;
      textSize(50);
      PFont f = createFont("Arial",28, true);
      textFont(f);
      if (csec > 9){
        text(cmin + ":" +csec, 600,630);
      }
      else{
        text(cmin + ":0" +csec, 600,630);
      }
      if (c <= 0){
        println("Your final score is: " + score);
        exit();
      } 
}

void intro(){
    bg = loadImage(images[0]);
    image(bg,0,0);
    textAlign(CENTER,CENTER);
    text("McDash",width/2,height/2);
    textFont(myFont);
    fill(205,200,74);
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
      if (outOfBounds(coorX,coorY,true)){
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
     else if (cust2 >= 0 && receivedOrder[indexOfArray(table,cust2)]==3){
       custPlace[cust2]=0;
       table[cust2]=-1;
       receivedOrder[cust2]=-1;
       score = score + 20;
     }
     else{
     int tempX = goalX;
     int tempY = goalY;
     goalX = (mouseX/5)*5;
     goalY = (mouseY/5)*5;
     if (outOfBounds(goalX,goalY,true)){
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
    img.resize(img.width*2,img.height*2);
    image(bg,CENTER,CENTER);
    image(img,coorX,coorY);
    fill(207,218,65);
    textSize(100);    

   foodAppear();
   displayScore();
    
    moveToward();
    refreshCustomers();
    
    int passedTime=millis()-savedTime1;
    if (passedTime > 10000){
        newCustomer();
        savedTime1=millis();
    }
    
  int passedTime2 = millis() -savedTime2;    
  if (passedTime2 > 5000 & orders.size() > 0){
    madeOrders.add(orders.remove(0));
    savedTime2 = millis();
    foodim.add(loadImage(images[8+madeOrders.get(madeOrders.size()-1)]));
  }
  
  if (coorX >= 460 && coorX <= 510 && coorY >= 90 && coorY <= 145 && corder == -1){
    getOrder();
  }
  if (corder >=0 && nearTable(coorX,coorY)>=0){
    if (corder == customers[table[nearTable(coorX,coorY)]].giveOrder()){
      score = score + 10;
      receivedOrder[nearTable(coorX,coorY)]=corder;
      tableTimer[nearTable(coorX,coorY)]=millis();
      corder=-1;
    }
  }
  checkTime();
  placeOrders();
  convertOrdertoString();
  foodAppear();
  displayOrders();
  displayScore();
}

void refreshCustomers(){
     for (int i = 0; i < numCust; i ++){
      if (customers[i]!=null){
        image(custim[i], custCoordX[i], custCoordY[i]);          
        if (custPlace[i]==1){
          moveToward(i,95,445-105*(custLine1.indexOf(i)));
        }
        else if (custPlace[i]==2){
          moveToward(i,180,445-105*(custLine2.indexOf(i)));
        }
        else if (custPlace[i]>=3){
          moveToSeat(i);
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
      }
    }
}

void moveToSeat(int i){
   if ((custPlace[i])==3){
     moveToward(i, 465, 220);
   }
   else if ((custPlace[i])==4){
     moveToward(i, 615, 220);
   }
   else if ((custPlace[i])==5){
     moveToward(i, 760, 220);
   }
   else if ((custPlace[i])==6){
     moveToward(i, 905, 220);
   }
   else if ((custPlace[i])==7){
     moveToward(i, 1055, 220);
   }
   else if ((custPlace[i])==8){
     moveToward(i, 465, 375);
   }
   else if ((custPlace[i])==9){
     moveToward(i, 615, 375);
   }
   else if ((custPlace[i])==10){
     moveToward(i, 760, 375);
   }
   else if ((custPlace[i])==11){
     moveToward(i, 905, 375);
   }
   else if ((custPlace[i])==12){
     moveToward(i, 1055, 375);
   }
}

void newCustomer(){
          if (numCust < 20 && (custLine1.size()!=5 || custLine2.size()!=5)){  
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
            custim[index].resize(custim[index].width*2,custim[index].height*2); 
            custCoordX[index]=140;
            custCoordY[index]=10;
            numCust ++;
            
          }
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
       image(foodim.get(i), kitchenX + (i*50), kitchenY);
     }
  }
}
   
boolean outOfBounds(int x,int y,boolean chairs){
  //Walls
  if ((x<-10)||(x>1165)||(y<-10)||(y>520)){
    return true;
  }
  //Kitchen
  if (x>430 && x<1075 && y<135){
    return true;
  }
  //tables with chairs
  if (chairs){
    if (((y>180 && y<320)||(y>335 && y<480))&&((x>415 && x<500)||(x>570 && x<650)||(x>715 && x<795)||(x>865 && x<945)||(x>1010 && x<1090))){
      return true;
    } 
  }
  //tables without chairs
  else{
    if (((y>225 && y<320)||(y>385 && y<480))&&((x>415 && x<500)||(x>570 && x<650)||(x>715 && x<795)||(x>865 && x<945)||(x>1010 && x<1090))){
      return true;
    } 
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
       if (outOfBounds(coorX,coorY,true)){
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
       if (outOfBounds(custCoordX[c],custCoordY[c],false)){
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

int nearTable(int x, int y){
  int row = -1;
  if (y>=180 && y<=320){
    row = 0;
  }
  else if (y>=335 && y<=480){
    row = 5;
  }
  else{
    return -1;
  }
  if (x>=415 && x<=500){
    return row + 0;
  }
  if (x>=570 && x<=650){
    return row + 1;
  }
  if (x>=715 && x<=795){
    return row + 2;
  }
  if (x>=865 && x<=945){
    return row + 3;
  }
  if (x>=1010 && x<=1090){
    return row + 4;
  }
  return -1;
} 

void getOrder(){
  if (madeOrders.size()>0){
    corder = madeOrders.remove(0);
  }
}

void placeOrders(){
  for (int i = 0; i < receivedOrder.length; i++){
    if (receivedOrder[i]!=-1){
      putOrder(i,receivedOrder[i]);
    }
  }
}

void putOrder(int t, int ord){
   int x = 0;
   int y = 0;
   if (t <= 4){
     y = 275;
   }
   else {
     y = 435;
   }
   if (t%5==0){
     x= 455;
   }
   else if (t%5==1){
     x = 610;
   }
   else if (t%5==2){
     x = 755;
   }
   else if (t%5==3){
     x = 905;
   }
   else if (t%5==4){
     x = 1050;
   }
   PImage food= loadImage(images[8+ord]);
   if (ord == 0){
     food.resize(45,57);
   }
   else if (ord == 1){
     food.resize(50,50);
   }
   else if (ord == 2){
     food.resize(42,59);
   }
   else if (ord == 3){
     food.resize(45,45);
   }
   image(food,x,y);
}

void checkTime(){
  for (int i = 0; i < tableTimer.length; i++){
      if (tableTimer[i]!=0){
      if (millis()-tableTimer[i]>3000){
        tableTimer[i]=0;
        receivedOrder[i]=3;
      }
    }
  }
}
