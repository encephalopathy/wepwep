

import java.awt.BorderLayout;
import java.awt.EventQueue;
//import java.awt.Image;
import java.util.List;
import java.util.ArrayList;
import java.util.Scanner;



//import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JMenuBar;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedWriter;
import java.io.File;
//import java.io.File;
//import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
//import java.io.UnsupportedEncodingException;
//import java.nio.file.Path;




//import javax.swing.ImageIcon;
//import javax.swing.JButton;
//import javax.swing.JDialog;
//import javax.swing.JLabel;
import javax.swing.JOptionPane;
//import javax.swing.JTextField;
//import javax.swing.JEditorPane;
import javax.swing.JMenu;
import javax.swing.JMenuItem;

import java.awt.Dimension;
import java.awt.Rectangle;
//import java.awt.event.ComponentEvent;
//import java.awt.event.ComponentListener;
//import java.awt.event.InputMethodListener;
//import java.awt.event.InputMethodEvent;
//import java.awt.event.KeyAdapter;
//import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
//import java.awt.event.WindowEvent;
//import java.awt.event.WindowListener;


import java.awt.image.BufferedImage; //test
import java.lang.reflect.*;

//import javax.swing.JTextPane;

public class WaveScreen extends JFrame {

	//private JPanel EnemyPlacementGrid;
	private List<Enemy> currentEnemyList = new ArrayList<Enemy>(); //holds the enemyObject that are created
	static Wave currentWave;// = new Wave(0, null); //the current wave you are working on 
	static Level currentLevel;// = new Level(null, 0); //the current level you are working on
	//private List<Wave> waveList = new ArrayList<Wave>(); //the list of waves you currently working on
	static List<Level> levelSet = new ArrayList<Level>(); //this contains ALL of the levels created; in a sense, the game.
	//private String waveNameString = "";
	public static String waveExtensionString = ".pew";
	public String selectedEnemy = "enemy";
	public Enemy workingEnemy;
	public Enemy highlightedEnemy;
	JMenu LevelMenu = new JMenu(); //declarations of level menu
	JFrame levelPopUp = new JFrame(); //JFrame for the level naming pop up
	JFrame savePopUp = new JFrame(); //JFrame for the Save pop up
	JFrame openPopUp = new JFrame(); //JFrame for the Open pop up
	JFrame rotationPopUp = new JFrame(); //FFrame for the Rotation pop up
	//WeaponPopUp weaponPopUp = new WeaponPopUp();
	public EnemyPlacementGrid Grid;
	
	//border variables
	public final int enemyGridBorderTop = 100; 
	public final int enemyGridBorderLeft = 200; //
	public final int enemyGridBorderBottom = 150; //
	public final int enemyGridBorderRight = 200; 
	
	//take out
	public BufferedImage img;
	
	//public static Image img;
	/**
	 * Launch the application.
	 */
	public void SetEnemyList(List<Enemy> newList){
		currentEnemyList = newList;
	}
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					WaveScreen frame = new WaveScreen();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	
	/**
	 * Create the frame.
	 */
	public WaveScreen() {
		//File newEnemyFile = new File
		//File enemyFile = new File(enemyFile, );
		setTitle("Wave Editor");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, (400 + (2 * enemyGridBorderLeft)), (600 + (2 * enemyGridBorderBottom))); //size of the entire frame
		setResizable(false);
		Grid = new EnemyPlacementGrid();
		currentLevel = new Level(null, 0, Grid);
		currentWave = new Wave(0, null, Grid);
		workingEnemy = new Enemy(Grid);
		highlightedEnemy = new Enemy(Grid);

		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		
		
		/*
		 * This is the Grid where enemies will be placed. When clicked an enemy will be placed down on the location of the mouse.
		 */
		//EnemyPlacementGrid = new JPanel();
		//EnemyPlacementGrid.addMouseListener(new MouseAdapter() {
		Grid.addMouseListener(new MouseAdapter() {
			//@Override
			public int mouseX;
			public int mouseY;
			public void mousePressed(MouseEvent arg0) { //what happens when you click in the EnemyPlacementGrid
				System.out.println("Correct Area for placement");
				mouseX = arg0.getX();
				mouseY = arg0.getY();
				//System.out.println("X:" + mouseX + ", Y:" + mouseY );
				Enemy newEnemy = workingEnemy.cloneSelf();
				newEnemy.setLocation(mouseX, mouseY);
				//System.out.println("newEnemy object: " + newEnemy);
				//System.out.println(newEnemy.weaponList);				
				currentWave.addEnemy(newEnemy);
				System.out.print(newEnemy);
				Grid.enemyToDraw = newEnemy;
								
			}
		});
		
		Grid.setToolTipText("Place Enemies Here!!!");
		Grid.setBackground(new Color(152, 251, 152)); //creates the green part
		Grid.setBorder(new EmptyBorder(enemyGridBorderTop, enemyGridBorderLeft, enemyGridBorderBottom, enemyGridBorderRight));
		Grid.setLayout(new BorderLayout(0, 0));
		add(Grid);
		
		//creating a new panel called GameScreen, the Black colored zone
		JPanel GameScreen = new JPanel();
		GameScreen.setBounds(new Rectangle(0, 0, 400, 600));
		GameScreen.setMaximumSize(new Dimension(400, 600));
		GameScreen.setToolTipText("Don't put shit in here");
		GameScreen.setBorder(null);
		GameScreen.setBackground(Color.BLACK);
		//EnemyPlacementGrid.add(GameScreen, BorderLayout.CENTER); //places it on top of EnemyPlacementGrid
		Grid.add(GameScreen, BorderLayout.CENTER);
		
		JMenu FileMenu = new JMenu("File");
		menuBar.add(FileMenu);
		
		JMenuItem SaveButton = new JMenuItem("Save");
		SaveButton.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent arg0) {
				try {
					String s = (String)JOptionPane.showInputDialog(  //set up for the popup menu
		                    savePopUp,
		                    "Enter a name for this file.",
		                    "Save To File",
		                    JOptionPane.PLAIN_MESSAGE, null,
		                    null, "");
				    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(s+".pew", true)));
				    for (int i = 0; i < levelSet.size(); i++){
				    	out.print(levelSet.get(i));
				    }
				    out.close();
				} catch (IOException e) {
				    //oh noes!
				}
			}
			
		});
		FileMenu.add(SaveButton);
		
		//Does Nothing
		/*
		JMenuItem SaveAsButton = new JMenuItem("Save As..."); 
		FileMenu.add(SaveAsButton);
		*/
		
		//Does Nothing
		/*
		JMenuItem SaveWaveButton = new JMenuItem("Save Wave...");
		FileMenu.add(SaveWaveButton);
		*/
		
		//Use for finding file
		JMenuItem OpenButton = new JMenuItem("Open");
		OpenButton.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent arg0) {
				try {
					String s = (String)JOptionPane.showInputDialog(  //set up for the popup menu
		                    openPopUp,
		                    "Select a File to open. Enter path to desired file.",
		                    "Open File",
		                    JOptionPane.PLAIN_MESSAGE, null,
		                    null, "");
					
					//Clear out the data structure already set up i.e. unload the data that is already here
					
					String line = null;
					String[] tokens = null;
 					Scanner in = new Scanner(new File(s+".pew"));
 					
 					//temps for building
					Level l = null;
					Wave w = null;
					Enemy enemy = null;
 					
					while(in.hasNextLine()){
						line = in.nextLine();
						System.out.println("LINE PARSED: " + line);
						tokens = line.split("\\s+");
						
						/*
						for(int i = 0; i < tokens.length; i++){
							System.out.println("tokens[" + i + "] " + tokens[i]);
						}
						*/
						for(int i = 0; i < tokens.length; i++){
							//System.out.println("FOR LOOP; tokens[" + i + "]" + tokens[i]);
							int equalsIndex = tokens[i].indexOf("=");
							if(equalsIndex == -1) {
								//System.out.println("HIT A BLANK TOKEN! SKIP IT!!!'");
								continue;
							}
							//System.out.println("= FOUND AT: " + equalsIndex);
							String sub = tokens[i].substring(0,equalsIndex);
							//System.out.println("sub IS: " + sub);
							
							if(sub.equals("Name")){
								//System.out.println("sub is: " + sub);
								//Create a new level with this name. Number should be set up for you
								String levelName = tokens[i].substring(equalsIndex + 1);
								//System.out.println(levelName);
								l = new Level(levelName, (levelSet.size()+1), Grid);  //build a new level
								levelSet.add(l); //adds a new level to the levelSet
								LevelMenu.add(l.levelWavesMenu);
							}
							
							//don't need to read in number since it is generated when building a level
							//don't need to read in types since it is generated during export
							
							else if(sub.equals("Time")){
								//create a new wave with this time
								System.out.println("sub is: " + sub);
								String time = tokens[i].substring(equalsIndex + 1);
								System.out.println("time is: " + time);
								int t = Integer.parseInt(time);
								System.out.println("t is: " + t);
								//attach the wave in to the correct Level
								System.out.println("what is l: " + l);
								w = new Wave(t, l, Grid);
								System.out.println("what is w.time: " + w.time);
								l.waveList.add(w);
								l.levelWavesMenu.add(w.waveButton);
							}
							
							else if(sub.equals("Type")){
								String enemyType = tokens[i].substring(tokens[i].lastIndexOf(".") + 1);
								System.out.println("enemyType IS: " + enemyType);
								try{
									Class enemyClass = Class.forName(enemyType);
									Class[] gridArray = {Grid.getClass()};
									Constructor enemyConstructor = enemyClass.getConstructor(gridArray);
									
									Object[] parameters = {Grid};
									enemy = (Enemy)enemyConstructor.newInstance(parameters);

									
								//And there is this crap...
								}catch (ClassNotFoundException ex){
									ex.printStackTrace();
							    }catch (NoSuchMethodException ex){
							    	ex.printStackTrace();
							    }catch (SecurityException ex) {
							    	ex.printStackTrace();
							    }catch (InstantiationException ex) {
							    	ex.printStackTrace();
							    }catch (IllegalAccessException ex) {
							    	ex.printStackTrace();
							    }catch (InvocationTargetException ex) {
							    	ex.printStackTrace();
							    }
								
								System.out.println(enemy);
								w.addEnemy(enemy);
								
							}
							
							else if(sub.equals("Location")) {
								//put in properties
								String coordinates = tokens[i].substring(equalsIndex + 1);
								String[] xy = coordinates.split(",");
								//System.out.println(xy.length);
								enemy.setLocation(Integer.parseInt(xy[0]), Integer.parseInt(xy[1]));
								//System.out.println("enemy location: " + enemy.enemyX + " " + enemy.enemyY);
								Grid.enemyToDraw = enemy;
							}
							
							else if(sub.equals("Rotation")) {
								//put in properties
								String rotation = tokens[i].substring(equalsIndex + 1);
								int r = Integer.parseInt(rotation);
								enemy.rotation = r;
								//System.out.println("rotation is: " + enemy.rotation);
							}
							
							else if(sub.equals("Weapons")) {
								//populate weaponlist
								String weaponsString = tokens[i].substring(equalsIndex + 1);
								String[] weapons = weaponsString.split(",");
								for(int j = 0; j < weapons.length; j++){
									enemy.weaponList.add(weapons[j]);
								}
								//System.out.println("enemy.weaponlist is: " + enemy.weaponList);
							}
							
							else if(sub.equals("Passives")) {
								//populate passivelist
								String passivesString = tokens[i].substring(equalsIndex + 1);
								String[] passive = passivesString.split(",");
								for(int k = 0; k < passive.length; k++){
									enemy.passiveList.add(passive[k]);
								}
								//System.out.println("enemy.passivelist is: " + enemy.passiveList);
							}

							
						}
						
					}
					
					in.close();
					
				} catch (IOException e) {
					System.out.println("Error inside Open ActionListener. Check that the file exists.");
				    e.printStackTrace();
				}
			}
			
		});
		FileMenu.add(OpenButton);
		
		//creates the level menu and adds the ability to add new Levels
		LevelMenu = new JMenu("Level");
		JMenuItem newLevelItem = new JMenuItem("New Level");
		newLevelItem.addActionListener(new ActionListener() {
			@Override	
			public void actionPerformed(ActionEvent event) {  //this part is only run once it is clicked
				String s = (String)JOptionPane.showInputDialog(  //set up for the popup menu
	                    levelPopUp,
	                    "Enter a name for this level.",
	                    "Level Name",
	                    JOptionPane.PLAIN_MESSAGE, null,
	                    null, "");
				System.out.println(s); 
				Level l = new Level(s, (levelSet.size()+1), Grid);  //build a new level
				levelSet.add(l); //adds a new level to the levelSet
				LevelMenu.add(l.levelWavesMenu); 
				System.out.println("Level: " + l);
			}
			
		});
		LevelMenu.add(newLevelItem); //attach the newLevelItem under the LevelMenu item
		menuBar.add(LevelMenu); //attach LevelMenu to the main menu bar
		
		final JMenu enemyChoiceMenu = new JMenu("Enemy");
		menuBar.add(enemyChoiceMenu);
		
		//adding in Hater_Normal enemy option
		JMenuItem Hater_NoramlItem = new JMenuItem("Hater_Normal");
		enemyChoiceMenu.add(Hater_NoramlItem);
		Hater_NoramlItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	        	   System.out.println("CREATING A NEW Enemy_1");
	               enemyChoiceMenu.setText("Hater_Normal");
	               Hater_Normal newDude = new Hater_Normal(Grid);
	               newDude.setRotation();
	               newDude.createWeaponList(); //generates the weapons and passive pop ups
	               workingEnemy = newDude;
	          }
	       });
		
		//adding in Hater_HalfStrafe enemy option
		JMenuItem Hater_HalfStrafeItem = new JMenuItem("Hater_HalfStrafe");
		enemyChoiceMenu.add(Hater_HalfStrafeItem);
		Hater_HalfStrafeItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	               System.out.println("CREATING A NEW Enemy_2");
	        	   enemyChoiceMenu.setText("Hater_HalfStrafe");
	        	   Hater_HalfStrafe newDude = new Hater_HalfStrafe(Grid);
	        	   newDude.setRotation();
	        	   newDude.createWeaponList(); //generates the weapons and passive pop ups
	        	   workingEnemy = newDude;
	           }
	       });
		
		//adding in Hater_Homing enemy option
		JMenuItem Hater_HomingItem = new JMenuItem("Hater_Homing");
		enemyChoiceMenu.add(Hater_HomingItem);
		Hater_HomingItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	               System.out.println("CREATING A NEW Enemy_3");
	        	   enemyChoiceMenu.setText("Hater_HomingItem");
	        	   Hater_Homing newDude = new Hater_Homing(Grid);
	        	   newDude.setRotation();
	        	   newDude.createWeaponList(); //generates the weapons and passive pop ups
	        	   workingEnemy = newDude;
	           }
	       });
		
		//setting up the delete menu
		JMenu deleteMenu = new JMenu("Delete");
		menuBar.add(deleteMenu);
		
		//setting up the deleteWaveButton
		JMenuItem deleteWaveButton = new JMenuItem("Wave");
		deleteMenu.add(deleteWaveButton);
		deleteWaveButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent event) {
				if(currentWave == null){ //if no current wave
					System.out.println("No currentWave to delete.");
					return;
				}
				System.out.println(currentLevel.waveList.size());
				currentLevel.levelWavesMenu.remove(currentWave.waveButton);
				currentLevel.waveList.remove(currentWave);
				Grid.clear();
				if(currentLevel.waveList.size() == 0){ //if no waves left
					currentWave = null;
				}
				else {
					currentWave = currentLevel.waveList.get(0);
				}
			}
		});
		
		//setting up the deleteLevelButton
		JMenuItem deleteLevelButton = new JMenuItem("Level");
		deleteMenu.add(deleteLevelButton);
		deleteLevelButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent event) {
				if(currentLevel == null){ //if no current level
					System.out.println("No currentLevel to delete.");
					return;
				}
				LevelMenu.remove(currentLevel.levelWavesMenu);
				levelSet.remove(currentLevel);
				if(levelSet.size() == 0){ //if no levels left
					currentLevel = null;
				}
				else{
					currentLevel = levelSet.get(0);
				}
			}
		});
		

	}
	
	public void PrintToFile(String filename){
		//walk through each wave in each level, print out the contents of each enemy and export to a
		//.pew file.
	}
	
	
}
