public class Player{

    private int points;
    private int level;
    private int experience;
    private int holdOrder;
    private int numOrders;
    private Customer[] customers;
    private int[] orders;
    private String name;
    //speed?
    
    public Player(String n){
	name = n;
	customers = new Customer[20];
	orders = new int[20];
	points = 0;
	level = 1;
	experience = 10;
	holdOrder = 0;
    }

    public void getFood(int order){
	holdOrder = order;
    }
    
    public void serveFood(Customer c){
	if (c.consume(holdOrder)==-1){
	    holdOrder = -1;
	    int index;
	    for (index = 0; index <numOrders; index++){
		if (customers[index]==c){
		    break;
		}
	    }
	    customers[index]=null;
	    for (int i = index; i < numOrders - 1; i ++){
		customers[i]=customers[i+1];
	    }
	    numOrders = numOrders -1;
	}
    }

    public void getPoints(int n){
	points = points + n;
    }

    public void getOrder(Customer c){
	customers[numOrders] = c;
	orders[numOrders]= c.giveOrder();
	numOrders++;
    }

}

