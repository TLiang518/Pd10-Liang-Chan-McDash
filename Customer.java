public class Customer{

    private int points;
    private int numPeople;//maybe we should just keep it simple and make it a set # of peeps
    private int happiness; //correlates with time
  

    
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
    
    public void angry(){
    	if(happiness < 4){
    	   exit();
    	}
    	
    }
}

 
