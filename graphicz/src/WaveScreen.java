//import processing.core.*;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.border.EmptyBorder;

import java.util.ArrayList;
import java.util.List;

public class WaveScreen extends JFrame {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private JPanel EnemyPlacementGrid;
	private List<Enemy> currentEnemyList = new ArrayList<Enemy>(); // holds the enemyObject that are created
	static Wave currentWave = new Wave(0, null); // the current wave you are working on
	static Level currentLevel = new Level(null, 0); // the current level you are working on
	private List<Wave> waveList = new ArrayList<Wave>(); // the list of waves you currently working on
	static List<Level> levelSet = new ArrayList<Level>(); // this contains ALL of the levels created; in a sense, the game.
	private String waveNameString = "";
	public static String waveExtensionString = ".pew";
	public String selectedEnemy = "enemy";
	public Enemy workingEnemy = new Enemy();
	public Enemy highlightedEnemy = new Enemy();
	JMenu LevelMenu = new JMenu(); // declarations of level menu
	JFrame levelPopUp = new JFrame(); // JFrame for the level naming popup
	// WeaponPopUp weaponPopUp = new WeaponPopUp();

	// border variables
	public final int enemyGridBorderTop = 100;
	public final int enemyGridBorderLeft = 100;
	public final int enemyGridBorderBottom = 100;
	public final int enemyGridBorderRight = 100;

	public int mouseX;
	public int mouseY;


	public static void main(String[] args) {
		
		Icon iconBlue= new ImageIcon("blue.gif");
		Icon iconShip = new ImageIcon("test.png");
		Icon iconWhite = new ImageIcon("white.gif");

		JFrame EditorScreen = new JFrame("Welcome to Pew Pew Developers cut");
		Container content = EditorScreen.getContentPane();
		content.setLayout(new BorderLayout());
		final PadDraw drawPad = new PadDraw();
		//content.add(drawPad);
		
		JPanel panel = new JPanel();
		//creates a JPanel
		panel.setPreferredSize(new Dimension(50, 400));
		panel.setMinimumSize(new Dimension(50, 400));
		panel.setMaximumSize(new Dimension(50, 400));
		//This sets the size of the panel
		
		JButton clearButton = new JButton("Clear");
		clearButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				drawPad.clear();
				for(int i = 0 ; i< 22 ; i++)
				{
					for( int j = 0; j < 16; j++) {
						drawPad.stage[i][j] = 0;
					}
				}
			}
		});
		clearButton.setPreferredSize(new Dimension(100,50));
		
		JButton shipButton = new JButton(iconShip);
		//blue button
		shipButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				drawPad.item = "test.png";
			}
		});
		
		shipButton.setPreferredSize(new Dimension(16, 16));
		
		JButton blueButton = new JButton(iconBlue);
		blueButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				drawPad.item = "blue.gif";
			}
		});
		
		JButton whiteButton = new JButton(iconWhite);
		whiteButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				drawPad.item = "white.gif";
			}
		});
		
		panel.add(shipButton);
		panel.add(blueButton);
		panel.add(whiteButton);
		panel.add(clearButton);
		
		content.setSize(100,150);
		content.add(panel, BorderLayout.WEST);
		EditorScreen.setSize(200, 200); 
		EditorScreen.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		EditorScreen.setVisible(false);
		WaveScreen frame = new WaveScreen();
		frame.add(content);				
		frame.add(drawPad);
		frame.setVisible(true);
	}

	public void SetEnemyList(List<Enemy> newList) {
		currentEnemyList = newList;
	}
	
	public WaveScreen()  {
		setTitle("Wave Editor");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, (400 + (2 * enemyGridBorderLeft)),
		(600 + (2 * enemyGridBorderTop))); // size of the entire frame
		setResizable(false);
		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		EnemyPlacementGrid = new JPanel();
		EnemyPlacementGrid.setDoubleBuffered(false);
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
		EnemyPlacementGrid.setBackground(new Color(152, 251, 152)); // creates the green part
		EnemyPlacementGrid.setBorder(new EmptyBorder(enemyGridBorderTop,
		enemyGridBorderLeft, enemyGridBorderBottom,
		enemyGridBorderRight));
		EnemyPlacementGrid.setLayout(new BorderLayout(0, 0));
		setContentPane(EnemyPlacementGrid);

		JPanel GameScreen = new JPanel();
		//GameScreen.setBounds(new Rectangle(0, 0, 400, 600));
		//GameScreen.setMaximumSize(new Dimension(400, 600));
	//	GameScreen.setToolTipText("Don't put shit in here");
	//	GameScreen.setBorder(null);
		//GameScreen.setBackground(Color.BLACK);
		EnemyPlacementGrid.add(GameScreen, BorderLayout.CENTER); // places it on top of EnemyPlacementGrid

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

		// creates the level menu and adds the ability to add new Levels
		LevelMenu = new JMenu("Level");
		JMenuItem newLevelItem = new JMenuItem("New Level");
		newLevelItem.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent event) { // this part is only run once it is clicked
				String s = (String) JOptionPane.showInputDialog(
						// set up for the popup menu
						levelPopUp, "Enter a name for this level.",
						"Time Selection", JOptionPane.PLAIN_MESSAGE, null,
						null, "");
				System.out.println(s);
				Level l = new Level(s, (levelSet.size() + 1)); // build a new
																// level
				levelSet.add(l); // adds a new level to the levelSet
				LevelMenu.add(l.levelWavesMenu);
				System.out.println("Level: " + l);
			}

		});
		LevelMenu.add(newLevelItem); // attach the newLevelItem under the
		menuBar.add(LevelMenu); // attach LevelMenu to the main menu bar

		final JMenu enemyChoiceMenu = new JMenu("Enemy");
		menuBar.add(enemyChoiceMenu);

		// adding in Honkey enemy option
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

		// adding in Redneck enemy option
		JMenuItem RedneckItem = new JMenuItem("Redneck");
		enemyChoiceMenu.add(RedneckItem);

		RedneckItem.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent event) {
				enemyChoiceMenu.setText("Redneck");
			}
		});

		// setting up the delete menu
		JMenu deleteMenu = new JMenu("Delete");
		menuBar.add(deleteMenu);

		// setting up the deleteWaveButton
		JMenuItem deleteWaveButton = new JMenuItem("Wave");
		deleteMenu.add(deleteWaveButton);
		deleteWaveButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent event) {
				if (currentWave == null) { // if no current wave
					System.out.println("No currentWave to delete.");
					return;
				}
				System.out.println(currentLevel.waveList.size());
				currentLevel.levelWavesMenu.remove(currentWave.waveButton);
				currentLevel.waveList.remove(currentWave);
				if (currentLevel.waveList.size() == 0) { // if no waves left
					currentWave = null;
				} else {
					currentWave = currentLevel.waveList.get(0);
				}
			}
		});

		// setting up the deleteLevelButton
		JMenuItem deleteLevelButton = new JMenuItem("Level");
		deleteMenu.add(deleteLevelButton);
		deleteLevelButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent event) {
				if (currentLevel == null) { // if no current level
					System.out.println("No currentLevel to delete.");
					return;
				}
				LevelMenu.remove(currentLevel.levelWavesMenu);
				levelSet.remove(currentLevel);
				if (levelSet.size() == 0) { // if no levels left
					currentLevel = null;
				} else {
					currentLevel = levelSet.get(0);
				}
			}
		});
	}

	public void PrintToFile(String filename) {
		// walk through each wave in each level, print out the contents of each
		// enemy and export to a
		// .pew file.
	}

}


class PadDraw extends JComponent{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Image image;
	Graphics2D graphics2D;
	int currentX, currentY, oldX, oldY;
	String item = "test.png";
	int stage[][] = new int[22][16]; // create 64 integers
	public PadDraw(){
		
		setDoubleBuffered(false);
		addMouseListener(new MouseAdapter(){
			public void mouseReleased (MouseEvent e){
				currentX = e.getX();
				currentY = e.getY();
				for(;;)
				{
					if(currentX % 25 == 0)
					{
					break;
					}
					currentX--;
				}
				
				for(;;)
				{
					if(currentY % 25 == 0)
					{
					break;
					}
					currentY--;
				}
				
				if(item.equals("test.png"))
				{
					stage[currentY/25][currentX/25] = 1;
				}
				else if (item.equals("blue.gif"))
				{
					stage[currentY/25][currentX/25] = 2;
				}
				else if (item.equals("white.gif"))
				{
					stage[currentY/25][currentX/25] = 0;
				}
				Image whiteOut = new ImageIcon("white.gif").getImage();
				Image imageTest = new ImageIcon( item).getImage();
				graphics2D.drawImage(whiteOut, currentX, currentY, 25, 25, null);
				graphics2D.drawImage(imageTest, currentX, currentY, 25, 25, null);
				System.out.println(currentX);
				System.out.println(currentY);
				repaint();
				for(int i = 0; i < 22;i++)
				{
					for(int j = 0; j < 16; j++)
					{
						System.out.print(stage[i][j]);
					}
					System.out.println();
				}
			}
		});
	}
	
	

	public void paintComponent(Graphics g){
		if(image == null){
			image = createImage(getSize().width, getSize().height);
			graphics2D = (Graphics2D)image.getGraphics();
			graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
			clear();
			System.out.println("image is null");
		}
		g.drawImage(image, 0, 0, null);
	}
	public void clear(){

		graphics2D.setPaint(Color.white);
		graphics2D.fillRect(0, 0, getSize().width, getSize().height);
		graphics2D.setPaint(Color.black);
		repaint();
	}
	public void blue()
	{
		graphics2D.setPaint(Color.blue);
		repaint();
	}
		public void red()
		{
			repaint();
		}
}











	
