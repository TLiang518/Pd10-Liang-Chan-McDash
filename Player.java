public class Player{

    private int points;
    private int level;
    private int experience;
    private int holdOrder;
    //speed?
    
    public Player(){
	points = 0;
	level = 1;
	experience = 10;
	holdOrder = 0;
    }

    public void getFood(int order){
	holdOrder = order;
    }
    
    public void move(){
    }
    
    public void serveFood(){
    //match order number with customer order number
    }
}

