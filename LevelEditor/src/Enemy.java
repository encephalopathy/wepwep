import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter; //mouse stuff
import java.awt.event.MouseEvent;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.ImageIcon;
import javax.swing.JComponent; //testing
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
public class Enemy extends BoundingBox{
	
	//public variables
	public Enemy self = this;
	//public int enemyX;
	//public int enemyY;
	public double scaleX, scaleY = 1;
	//public int height = 25; 
	//public int width = 25;
	public int imageHeight, imageWidth = 0; //fuck that shit
	public String type = null;
	//public double rotation = 0;
	public int maxWeapons = 0;
	public List<String> weaponList = new ArrayList<String>(); //list of all the weapons
	public int maxPassives = 0;
	public List<String> passiveList = new ArrayList<String>(); //list of all the weapons
	public String imageFileName = "src/test.png"; //default image for an enemy
	public EnemyPlacementGrid Grid;
	JFrame rotationPopUp = new JFrame(); //FFrame for the Rotation pop up
	Image imageObject = null;
	
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
					weaponList = weaponPopUp.returnList();
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
					System.out.println("EXITING THE PASSIVE POP UP");
					passiveList = passivePopUp.returnList();
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
			e.printStackTrace();
		}
		//System.out.println(passiveList.toString());
	}
	
	
	
	//set the x and y coordinates of a placed enemy in WaveScreen.java
	public void setLocation(int xLoc, int yLoc){
		System.out.println("INSIDE setLocation");
		enemyX = xLoc;
		enemyY = yLoc;
		
	}
	
	public void setRotation() {
		System.out.println("THE ROTATION BEFORE CLOSING IS: " + rotation);
		String s = (String)JOptionPane.showInputDialog(  //set up for the popup menu
                rotationPopUp,
                "Select a rotation for this enemy. Leave empty for 0 rotation.",
                "Set Rotation",
                JOptionPane.PLAIN_MESSAGE, null,
                null, "");
	   if(s.length() == 0) {
		   rotation = 0;
		   System.out.println("s.length() WAS 0! NOTHING TYPED. rotation is: " + rotation);
		   return;
	   }
       int r = Integer.parseInt(s);
       rotation = r;
       System.out.println("THE ROTATION AFTER CLOSING IS: " + rotation);
	}
	
	
	public void setImageObject(){
		System.out.println("Creating Image Object for enemy!!");
		ImageIcon temp = new ImageIcon(imageFileName);
		imageHeight = temp.getIconHeight();
		imageWidth = temp.getIconWidth();
		//scaleY = (height/temp.getIconHeight());
		//scaleX = (width/temp.getIconWidth());
		this.imageObject = temp.getImage();
		//this.imageHeight = this.imageObject.getHeight(null);
		//this.imageWidth = this.imageObject.getWidth(null);
		System.out.println("YOOOOOOO!!!");
		System.out.println("Enemy.java: width: " + width + " height: " + height + " imageWidth:" + imageWidth + " imageHeight:" + imageHeight);
		scaleX = ((double) width)/imageWidth;
		scaleY = ((double) height)/imageHeight;
		
	}
	
	/*
	public String getToolTipText(MouseEvent e){
		String s = new String();
		return s;
	}
	*/
	
	public String setText(){
		String s = "";
		//type, x, y, rotation
		s += ("Type: " + type + "\n");
		s += ("X: "+ enemyX + "\n");
		s += ("Y: "+ enemyX + "\n");
		return s;
	}
	
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
		e.imageObject = this.imageObject;
		e.imageWidth = this.imageWidth;
		e.imageHeight = this.imageHeight;
		e.scaleX = this.scaleX;
		e.scaleY = this.scaleY;
		e.width = this.width;
		e.height = this.height;
		return e;
	}
	
	@Override 
	public String toString(){
		String printedLine = "";
		printedLine += ("   Type=" + type);
		printedLine += (" Location=" + Integer.toString(enemyX) + "," + Integer.toString(enemyY));
		int rot = (int)rotation; //temp to hold an integer version of the rotation
		printedLine += (" Rotation=" + Integer.toString(rot));
		printedLine += (" Weapons=");
		for(int i = 0; i < weaponList.size(); i++){
			printedLine += (weaponList.get(i));
			if(i != (weaponList.size() -1)) printedLine += (",");
		}
		//System.out.println(passiveList.size());
		printedLine += (" Passives=");
		for(int i = 0; i < passiveList.size(); i++){
			printedLine += (passiveList.get(i));
			if(i != (passiveList.size() -1)) printedLine += (",");
		}
		printedLine += ("\n");
		return printedLine;
	}

	@Override
	public void onBoundingBoxClick(Object sender, int eventType) {
		//this is where we will be deleting enemies!!! OMG!
		
	}
}
