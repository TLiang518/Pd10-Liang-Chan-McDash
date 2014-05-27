import java.util.*;
import java.io.*;

public class McDash{

    //this is the main game file
    //setup: four tables, all with four seats
    
    public void setup(){
	String n = "" //some method of finding name of player (scanner?)
	Player p = new Player(n);
	
    }

    public void game(Player p){
	//game revolves around player, maybe we can save players too 
	Customer[] newC = new Customer[4]; 
	int newCusts = (int) Math.Random()*4;
	for (int i = 0; i < newCusts ; i ++){
	    newC[i] = new Customer();
	}
	//creates up to 4 random customers at a time
	
    }




}
