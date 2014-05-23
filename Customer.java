public class Customer{

    private int points;
    private int numPeople;
    private int happiness;

    public Customer(){
	happiness = 10;
	//max = 10, decrease when they get impatient
	//TIME
	numPeople = (int)(Math.random()*4);
    }
    
    public void consume(int order){
    	if (happiness != 10){
    		happiness ++;
    	}
    }

    
    public void exit(){
    	points = happiness * happiness;
    	//remove customer
    }
    
    
    	}
    	}
    }

}
