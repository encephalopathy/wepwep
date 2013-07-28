import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPopupMenu;




/**
 * will create basic enemies
 * 
 */
public class Enemy {
	
	//public variables
	public int enemyX;
	public int enemyY;
	public String type = null;
	public int rotation = 0;
	public int maxWeapons = 0;
	public List<String> weaponList = new ArrayList<String>(); //list of all the weapons
	//generic image to be placed later
	
	//object constructor
	public Enemy(int xLoc, int yLoc)
	{
		System.out.println("Creating a new Enemy Object");
		enemyX = xLoc;
		enemyY = yLoc;
		DEBUGPRINT();

	}
	
	public void DEBUGPRINT(){
		System.out.println("I AM A DEBUG FOR ENEMY AT:(" + enemyX + "," + enemyY + ")");
	}
	
	public String DEBUGPRINTSTRING(){
		return "I AM A DEBUG FOR ENEMY AT:(" + enemyX + "," + enemyY + ")";
	}

}
