import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

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
public class Enemy {
	
	//public variables
	public Enemy self = this;
	public int enemyX;
	public int enemyY;
	public String type = null;
	public int rotation = 0;
	public int maxWeapons = 0;
	public List<String> weaponList = new ArrayList<String>(); //list of all the weapons
	
	
	//object constructor
	public Enemy()
	{
		System.out.println("Creating a new Enemy Object");
		//DEBUGPRINT();

	}
	
	public void createWeaponList(){
		try {
			final WeaponPopUp weaponPopUp = new WeaponPopUp(maxWeapons);
			weaponPopUp.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			weaponPopUp.setVisible(true);
			// DEBUG TEST
			//String testString = weaponPopUp.returnWeaponList();
			//System.out.println(testString);
			weaponPopUp.addWindowListener(new WindowListener() {
				@Override public void windowActivated(WindowEvent e) {}
				@Override public void windowClosed(WindowEvent e) {}
				@Override public void windowClosing(WindowEvent e) {
					weaponList = weaponPopUp.returnWeaponList();
					System.out.println(weaponList.toString());
				}
				@Override public void windowDeactivated(WindowEvent e) {}
				@Override public void windowDeiconified(WindowEvent e) {}
				@Override public void windowIconified(WindowEvent e) {}
				@Override public void windowOpened(WindowEvent e) {}
			});
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void setLocation(int xLoc, int yLoc){
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
		Enemy e = new Enemy();
		e.weaponList = this.weaponList;
		e.enemyX = this.enemyX;
		e.enemyY = this.enemyY;
		e.maxWeapons = this.maxWeapons;
		e.rotation = this.rotation;
		e.type = this.type;
		return e;
	}
	
	@Override 
	public String toString(){
		String printedLine = "";
		printedLine += ("   Type=" + type);
		printedLine += (" Location=" + Integer.toString(enemyX) + "," + Integer.toString(enemyY));
		printedLine += (" Rotation=" + Integer.toString(rotation));
		printedLine += (" Weapons= ");
		for(int i = 0; i < weaponList.size(); i++){
			printedLine += (weaponList.get(i));
			if(i != (weaponList.size() -1)) printedLine += (",");
		}
		printedLine += ("\n");
		return printedLine;
	}
}
