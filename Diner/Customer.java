public class Customer{

    private Player p;
    private int points;
    private int numPeople;//maybe we should just keep it simple and make it a set # of peeps
    private int happiness; //correlates with time
    private int order;
    private int image;
  

    
    public Customer(Player newP){
	p = newP;
	happiness = 10;
	//max = 10, decrease when they get impatient
	//TIME
	image = (int)(Math.random()*5)
	order = (int)(Math.random()*5);
	numPeople = (int)(Math.random()*4);
    }
    
    public int getImage(){
	return image;
    }

    public int consume(int gOrder){
	if (gOrder == order){
	    if (happiness != 10){
    		happiness ++;
		return -1;
	    }
	}
	if (happiness > 0){
	    happiness --;
	}
	return order;
    }

    public void exit(){
    	points = happiness * happiness;
	p.getPoints(points);
    	//remove customer
    }	
    
    public void angry(){
    	if(happiness < 4){
    	   exit();
    	}
    	
    }

    public int giveOrder(){
	return order;
    }

    
}

 
