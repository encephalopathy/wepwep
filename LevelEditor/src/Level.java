import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPopupMenu;

/*
 * this will hold all the waves, so full of enemies... to kill!
 */

public class Level {

	int levelNumber; //number of the level
	String levelName;  //name of the level
	public List<Wave> waveList = new ArrayList<Wave>(); //list of waves contained in this level
	
	JMenuItem newWaveButton = new JMenuItem("New Wave"); //button to create a new wave
	public JMenu levelWavesMenu = null; 
	JPopupMenu wavePopup = null; //popUp menu to add name
	JFrame waveFrame = new JFrame(); //JFrame to hold the popUp menu
	
	public EnemyPlacementGrid Grid;
	
	//Constructor for a new Level
	public Level (String name, int level, EnemyPlacementGrid epgRef )
	{
		System.out.println("CREATING new Level");
		levelNumber = level;
		levelName = name;
		levelWavesMenu = new JMenu(name);
		
		Grid = epgRef;
		
		//menu set up
		newWaveButton.addActionListener(new ActionListener(){
			@Override
			public void actionPerformed(ActionEvent e) {  //this part is only run once it is clicked
				String s = (String)JOptionPane.showInputDialog( //set up for the popup menu
	                    waveFrame,
	                    "Enter a time for when this wave should appear.",
	                    "Time Selection",
	                    JOptionPane.PLAIN_MESSAGE, null,
	                    null, "");
				int t = Integer.parseInt(s);
				Wave newWave = new Wave(t, getSelf(), Grid);	 //create a new wave
				System.out.println("INDEX OF THE NEW WAVE: " + newWave);
				waveList.add(newWave); //take that wave and add to this levels waveList
				levelWavesMenu.add(newWave.waveButton); //add the newWave's waveButton to the level's wave menu
				
				//only needs to clear because it is setting you to the new wave which starts off empty
				Grid.clear();
				
				WaveScreen.currentWave = newWave; //sets the newly created wave to be the currentWave
				System.out.println("ADDRESS OF THE CURRENT WAVE: " + WaveScreen.currentWave);
			}
		});
		
		levelWavesMenu.add(newWaveButton); //add the newWaveButton to the levelWavesMenu
		
	}
	
	private Level getSelf(){
		return this;
	}
	
	@Override 
	public String toString(){
		String printedLine = "";
		printedLine += ("Name=" + levelName);
		printedLine += (" Number=" + levelNumber);
		printedLine += ("\n");
		for(int i = 0; i < waveList.size(); i++){
			printedLine += waveList.get(i);
		}
		return printedLine;
	}
	
}
