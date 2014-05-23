public class Player{

    private int points;
    private int level;
    private int experience;
    private int holdOrder;
    
    public Player(){
	points = 0;
	level = 1;
	experience = 10;
	holdOrder = 0;
    }

    public void getFood(int order){
	holdOrder = order;
    }

}