import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.ImageIcon;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPopupMenu;




/**
 * will create basic enemies
 * 
 */
public class Enemy{
	
	//public variables
	public Enemy self = this;
	public int enemyX;
	public int enemyY;
	public String type = null;
	public int rotation = 0;
	public int maxWeapons = 0;
	public List<String> weaponList = new ArrayList<String>(); //list of all the weapons
	public int maxPassives = 0;
	public List<String> passiveList = new ArrayList<String>(); //list of all the weapons
	public String imageFileName = "src/test.png"; //default image for an enemy
	public EnemyPlacementGrid Grid;
	
	//object constructor
	public Enemy(EnemyPlacementGrid epgRef)
	{
		Grid = epgRef;
		System.out.println("Creating a new Enemy Object");
		//DEBUGPRINT();

	}
	
	public void createWeaponList(){
		try {
			final WeaponPopUp weaponPopUp = new WeaponPopUp(maxWeapons);
			weaponPopUp.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			weaponPopUp.setVisible(true);
			
			//System.out.println(testString);
			weaponPopUp.addWindowListener(new WindowListener() {
				@Override public void windowActivated(WindowEvent e) {}
				@Override public void windowClosed(WindowEvent e) {}
				@Override public void windowClosing(WindowEvent e) {
					System.out.println("EXITING THE WEAPON POP UP");
					weaponList = weaponPopUp.returnWeaponList();
					System.out.println(weaponList.toString());
				}
				@Override public void windowDeactivated(WindowEvent e) {}
				@Override public void windowDeiconified(WindowEvent e) {}
				@Override public void windowIconified(WindowEvent e) {}
				@Override public void windowOpened(WindowEvent e) {}
			});
			
			final PassivePopUp passivePopUp = new PassivePopUp(maxPassives);
			passivePopUp.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			passivePopUp.setVisible(true);
			
			passivePopUp.addWindowListener(new WindowListener(){
				@Override public void windowActivated(WindowEvent e) {}
				@Override public void windowClosed(WindowEvent e) {}
				@Override public void windowClosing(WindowEvent e) {
					passiveList = passivePopUp.returnWeaponList();
					System.out.println(passiveList.toString());
				}
				@Override public void windowDeactivated(WindowEvent e) {}
				@Override public void windowDeiconified(WindowEvent e) {}
				@Override public void windowIconified(WindowEvent e) {}
				@Override public void windowOpened(WindowEvent e) {}
			});
			// DEBUG TEST
			//String testString = weaponPopUp.returnWeaponList();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(passiveList.toString());
	}
	
	//Added code
	public void actionPerformed(ActionEvent e) {
		System.out.println(e.getSource());
		Grid.enemyToDraw = this;
	}
	
	//set the x and y coordinates of a placed enemy in WaveScreen.java
	public void setLocation(int xLoc, int yLoc){
		System.out.println("INSIDE setLocation");
		enemyX = xLoc;
		enemyY = yLoc;
		
	}
	
	public void setRotation(int r) { rotation = r; }
	
	public void DEBUGPRINT(){
		System.out.println("I AM A DEBUG FOR ENEMY AT:(" + enemyX + "," + enemyY + ")");
	}
	
	public String DEBUGPRINTSTRING(){
		return "I AM A DEBUG FOR ENEMY AT:(" + enemyX + "," + enemyY + ")";
	}

	public Enemy cloneSelf(){
		Enemy e = new Enemy(this.Grid);
		e.weaponList = this.weaponList;
		e.passiveList = this.passiveList;
		e.enemyX = this.enemyX;
		e.enemyY = this.enemyY;
		e.maxWeapons = this.maxWeapons;
		e.rotation = this.rotation;
		e.type = this.type;
		e.imageFileName = this.imageFileName;
		return e;
	}
	
	@Override 
	public String toString(){
		String printedLine = "";
		printedLine += ("   Type=" + type);
		printedLine += (" Location=" + Integer.toString(enemyX) + "," + Integer.toString(enemyY));
		printedLine += (" Rotation=" + Integer.toString(rotation));
		printedLine += (" Weapons=");
		for(int i = 0; i < weaponList.size(); i++){
			printedLine += (weaponList.get(i));
			if(i != (weaponList.size() -1)) printedLine += (",");
		}
		System.out.println(passiveList.size());
		printedLine += (" Passives=");
		for(int i = 0; i < passiveList.size(); i++){
			printedLine += (passiveList.get(i));
			if(i != (passiveList.size() -1)) printedLine += (",");
		}
		printedLine += ("\n");
		return printedLine;
	}
}
