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
	
	//Constructor for a new Level
	public Level (String name, int level )
	{
		levelNumber = level;
		levelName = name;
		levelWavesMenu = new JMenu(name);
		
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
				Wave newWave = new Wave(t);	 //create a new wave
				System.out.println("INDEX OF THE NEW WAVE: " + newWave);
				waveList.add(newWave); //take that wave and add to this levels waveList
				levelWavesMenu.add(newWave.waveButton); //add the newWave's waveButton to the level's wave menu
				WaveScreen.currentWave = newWave; //sets the newly created wave to be the currentWave
				System.out.println("ADDRESS OF THE CURRENT WAVE: " + WaveScreen.currentWave);
			}
		});
		
		levelWavesMenu.add(newWaveButton); //add the newWaveButton to the levelWavesMenu
		
	}
	
	//adds a single wave to the Levels waveList field
	/*    PENDING REMOVAL
	public void AddWave(Wave newWave)
	{
		System.out.println("Adding Wave");
		waveList.add(newWave);
		System.out.println("Size of Level: " + waveList.size());
	}
	*/
	
	
}
