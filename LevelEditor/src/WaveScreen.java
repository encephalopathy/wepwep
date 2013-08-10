

import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.Image;
import java.util.List;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JMenuBar;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.file.Path;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.JEditorPane;
import javax.swing.JMenu;
import javax.swing.JMenuItem;

import java.awt.Dimension;
import java.awt.Rectangle;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.InputMethodListener;
import java.awt.event.InputMethodEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;


import javax.swing.JTextPane;

public class WaveScreen extends JFrame {

	private JPanel EnemyPlacementGrid;
	//private
	private List<Enemy> currentEnemyList = new ArrayList<Enemy>(); //holds the enemyObject that are created
	static Wave currentWave = new Wave(0, null); //the current wave you are working on 
	static Level currentLevel = new Level(null, 0); //the current level you are working on
	//private List<Wave> waveList = new ArrayList<Wave>(); //the list of waves you currently working on
	static List<Level> levelSet = new ArrayList<Level>(); //this contains ALL of the levels created; in a sense, the game.
	//private String waveNameString = "";
	public static String waveExtensionString = ".pew";
	public String selectedEnemy = "enemy";
	public Enemy workingEnemy = new Enemy();
	public Enemy highlightedEnemy = new Enemy();
	JMenu LevelMenu = new JMenu(); //declarations of level menu
	JFrame levelPopUp = new JFrame(); //JFrame for the level naming popup
	//WeaponPopUp weaponPopUp = new WeaponPopUp();
	
	//border variables
	public final int enemyGridBorderTop = 200; //
	public final int enemyGridBorderLeft = 200; //
	public final int enemyGridBorderBottom = 200; 
	public final int enemyGridBorderRight = 200; 
	
	//take out

	
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

	/*
	public static void LoadImage(String name){
		BufferedImage img = null;
		try {
		    img = ImageIO.read(new File(name+".jpg"));
		} catch (IOException e) {
		}
		try {
		    //URL url = new URL(getCodeBase(), "examples/strawberry.jpg");
		    URL url = new URL(name);
		    img = ImageIO.read(url);
		} catch (IOException e) {
		}
	}
	*/
	

	
	/**
	 * Create the frame.
	 */
	public WaveScreen() {
		//File newEnemyFile = new File
		//File enemyFile = new File(enemyFile, );
		setTitle("Wave Editor");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, (400 + (2 * enemyGridBorderLeft)), (600 + (2 * enemyGridBorderTop))); //size of the entire frame
		setResizable(false);
		
		
		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		
		
		/*
		 * This is the Grid where enemies will be placed. When clicked an enemy will be placed down on the location of the mouse.
		 */
		EnemyPlacementGrid = new JPanel();
		EnemyPlacementGrid.addMouseListener(new MouseAdapter() {
			//@Override
			public int mouseX;
			public int mouseY;
			public void mouseClicked(MouseEvent arg0) { //what happens when you click in the EnemyPlacementGrid
				System.out.println("Correct Area for placement");
				mouseX = arg0.getX();
				mouseY = arg0.getY();
				//System.out.println("X:" + mouseX + ", Y:" + mouseY );
				Enemy newEnemy = workingEnemy.cloneSelf();
				newEnemy.setLocation(mouseX, mouseY);
				//System.out.println("newEnemy object: " + newEnemy);
				//System.out.println(newEnemy.weaponList);
				//currentWave.addEnemy(newEnemy);
				System.out.print(currentLevel);
				
				//take out
				
				
			}
		});
		EnemyPlacementGrid.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent arg0) {
			}
		});
		EnemyPlacementGrid.addInputMethodListener(new InputMethodListener() {
			public void caretPositionChanged(InputMethodEvent arg0) {
			}
			public void inputMethodTextChanged(InputMethodEvent arg0) {
			}
		});
		EnemyPlacementGrid.setToolTipText("Put shit in here");
		EnemyPlacementGrid.setBackground(new Color(152, 251, 152)); //creates the green part
		EnemyPlacementGrid.setBorder(new EmptyBorder(enemyGridBorderTop, enemyGridBorderLeft, enemyGridBorderBottom, enemyGridBorderRight));
		EnemyPlacementGrid.setLayout(new BorderLayout(0, 0));
		setContentPane(EnemyPlacementGrid);
		
		//creating a new panel called GameScreen
		JPanel GameScreen = new JPanel();
		GameScreen.setBounds(new Rectangle(0, 0, 400, 600));
		GameScreen.setMaximumSize(new Dimension(400, 600));
		GameScreen.setToolTipText("Don't put shit in here");
		GameScreen.setBorder(null);
		GameScreen.setBackground(Color.BLACK);
		EnemyPlacementGrid.add(GameScreen, BorderLayout.CENTER); //places it on top of EnemyPlacementGrid
		
		
		JMenu FileMenu = new JMenu("File");
		menuBar.add(FileMenu);
		
		JMenuItem SaveButton = new JMenuItem("Save");
		FileMenu.add(SaveButton);
		
		JMenuItem SaveAsButton = new JMenuItem("Save As...");
		FileMenu.add(SaveAsButton);
		
		JMenuItem SaveWaveButton = new JMenuItem("Save Wave...");
		FileMenu.add(SaveWaveButton);
		
		JMenuItem OpenButton = new JMenuItem("Open...");
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
	                    "Time Selection",
	                    JOptionPane.PLAIN_MESSAGE, null,
	                    null, "");
				System.out.println(s);
				Level l = new Level(s, (levelSet.size()+1));  //build a new level
				levelSet.add(l); //adds a new level to the levelSet
				LevelMenu.add(l.levelWavesMenu); 
				System.out.println("Level: " + l);
			}
			
		});
		LevelMenu.add(newLevelItem); //attach the newLevelItem under the LevelMenu item
		menuBar.add(LevelMenu); //attach LevelMenu to the main menu bar
		
		final JMenu enemyChoiceMenu = new JMenu("Enemy");
		menuBar.add(enemyChoiceMenu);
		
		//adding in Honkey enemy option
		JMenuItem HonkeyItem = new JMenuItem("Honkey");
		enemyChoiceMenu.add(HonkeyItem);
		HonkeyItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	               enemyChoiceMenu.setText("Honkey");
	               Enemy_1 newDude = new Enemy_1();
	               newDude.createWeaponList();
	               workingEnemy = newDude;
	          }
	       });
		
		//adding in Redneck enemy option
		JMenuItem RedneckItem = new JMenuItem("Redneck");
		enemyChoiceMenu.add(RedneckItem);
		
		RedneckItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	               enemyChoiceMenu.setText("Redneck");
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
		
	
	//public 

	}
	
	public void PrintToFile(String filename){
		//walk through each wave in each level, print out the contents of each enemy and export to a
		//.pew file.
	}
	
	
}
