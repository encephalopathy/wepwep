

import java.awt.BorderLayout;
import java.awt.EventQueue;
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
import java.net.URL;
import java.nio.file.Path;

import javax.swing.JButton;
import javax.swing.JTextField;
import javax.swing.JEditorPane;
import javax.swing.JMenu;
import javax.swing.JMenuItem;

import java.awt.Dimension;
import java.awt.Rectangle;
import java.awt.event.InputMethodListener;
import java.awt.event.InputMethodEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;

import javax.swing.JTextPane;

public class WaveScreen extends JFrame {

	private JPanel EnemyPlacementGrid;
	//private
	private List<Enemy> currentEnemyList = new ArrayList<Enemy>(); //holds the enemyObject that are created
	private Wave currentWave = new Wave(null, 0);
	private List<Wave> waveList = new ArrayList<Wave>();
	private String waveNameString = "";
	public static String waveExtensionString = ".pew";
	public String selectedEnemy = "enemy";
	JMenu WaveMenu = new JMenu();
	
	public final int enemyGridBorderTop = 200; //
	public final int enemyGridBorderLeft = 200; //
	public final int enemyGridBorderBottom = 200; 
	public final int enemyGridBorderRight = 200; 
	

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
				System.out.println("X:" + mouseX + ", Y:" + mouseY );
				Enemy newEnemy = new Enemy(mouseX, mouseY);
				System.out.println("newEnemy object: " + newEnemy);
				currentEnemyList.add(newEnemy);
				System.out.println("The currentEnemyList is: " + currentEnemyList.size());
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
		
		JMenu LevelMenu = new JMenu("Level");
		menuBar.add(LevelMenu);
		
		WaveMenu = new JMenu("Wave");
		JMenuItem newWaveItem = new JMenuItem("New Wave");
		newWaveItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	        	   Wave w = new Wave(null, 0);
	               waveList.add(w);
	               CreateWaveMenuItem();
	               System.out.println("Wave: " + w);
	          }
		});
		WaveMenu.add(newWaveItem);
		menuBar.add(WaveMenu);
		
		final JMenu enemyChoiceMenu = new JMenu("Enemy");
		menuBar.add(enemyChoiceMenu);
		
		//adding in Honkey enemy option
		JMenuItem HonkeyItem = new JMenuItem("Honkey");
		enemyChoiceMenu.add(HonkeyItem);
		HonkeyItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	               enemyChoiceMenu.setText("Honkey");
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
		
		
	
	//public 

	}
	
	public void CreateWaveMenuItem(){
		//String timeString = "" + newWave.time;
		final JMenuItem newItem = new JMenuItem(String.valueOf(currentWave.time));
		WaveMenu.add(newItem);
		newItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	               //enemyChoiceMenu.setText("Honkey");
	        	   //String timeString = "" + newWave.time
	        	   String s = newItem.getText();
	        	   Search(s);
	        	   WaveMenu.setText(String.valueOf(currentWave.time));
	        	   //newWave.loadWave();
	        	   System.out.println("Current Wave: " + currentWave);
	          }
		});
	}
	
	public void Search(String s)
	{
		System.out.println("IN");
		System.out.println(waveList.size());
		int time = Integer.parseInt(s); //this is how you convert a sting to an int! just so you know...
		System.out.println("YEEEEAAAAAHHHHHH");
		for(int i = 0; i < waveList.size(); i++)
		{
			Wave w = waveList.get(i);
			//.get(i) does not work
			System.out.println("IN IN");
			if (waveList.get(i).time == time)
			{
				currentWave = waveList.get(i);
			}
		}
	}
	
	public void PrintToFile(String filename){
		
	}
	
	
}
