package waveEditorPackage;

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
import com.jgoodies.forms.factories.DefaultComponentFactory;
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
	private List<String> enemyList = new ArrayList<String>();
	private List<String> waveList = new ArrayList<String>();
	private List<String> aiList = new ArrayList<String>();
	private String waveNameString = "";
	public static String waveExtensionString = ".pew";
	public String seletedEnemy = "enemy";

	/**
	 * Launch the application.
	 */
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
		setBounds(100, 100, 500, 400);
		
		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		
		/*
		 * This is the Grid where enemies will be placed. When clicked an enemy will be placed down on the location of the mouse.
		 */
		EnemyPlacementGrid = new JPanel();
		EnemyPlacementGrid.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent arg0) {
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
		EnemyPlacementGrid.setBackground(new Color(152, 251, 152));
		EnemyPlacementGrid.setBorder(new EmptyBorder(5, 5, 5, 5));
		EnemyPlacementGrid.setLayout(new BorderLayout(0, 0));
		setContentPane(EnemyPlacementGrid);
		
		JPanel GameScreen = new JPanel();
		GameScreen.setBounds(new Rectangle(0, 0, 400, 600));
		GameScreen.setMaximumSize(new Dimension(400, 600));
		GameScreen.setToolTipText("Don't put shit in here");
		GameScreen.setBorder(null);
		GameScreen.setBackground(Color.BLACK);
		EnemyPlacementGrid.add(GameScreen, BorderLayout.CENTER);
		
		JMenu FileMenu = new JMenu("File");
		menuBar.add(FileMenu);
		
		JMenuItem SaveButton = new JMenuItem("Save");
		FileMenu.add(SaveButton);
		
		JMenuItem SaveAsButton = new JMenuItem("Save As...");
		FileMenu.add(SaveAsButton);
		
		JMenuItem OpenButton = new JMenuItem("Open...");
		FileMenu.add(OpenButton);
		
		JMenu LevelMenu = new JMenu("Level");
		menuBar.add(LevelMenu);
		
		JMenu WaveMenu = new JMenu("Wave");
		menuBar.add(WaveMenu);
		
		final JMenu enemyChoiceMenu = new JMenu("Enemy");
		menuBar.add(enemyChoiceMenu);
		JMenuItem HonkeyItem = new JMenuItem("Honkey");
		enemyChoiceMenu.add(HonkeyItem);
		
		HonkeyItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	               enemyChoiceMenu.setText("Honkey");
	          }
	       });
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
	
	public void PrintToFile(String filename){
		
	}
}
