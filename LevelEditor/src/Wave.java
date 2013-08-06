import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JMenuItem;
//import javax.swing.JOptionPane;


public class Wave {

	public int time = 0; //the time that the wave will begin
	private List<Enemy> waveEnemyList = new ArrayList<Enemy>();
	public JMenuItem waveButton = null;
	private Level parentLevel;
	
	//constructor for wave
	public Wave(int t, Level l){
		time = t;
		parentLevel = l;
		//menu set up
		waveButton = new JMenuItem(Integer.toString(t));  //button for a given wave
		waveButton.addActionListener(new ActionListener(){ //by clicking on it, you change the current wave
			@Override
			public void actionPerformed(ActionEvent e) {
				//will make a call to load wave
				System.out.println("Before: " + WaveScreen.currentWave);
				loadWave();
				System.out.println("The current Wave has been changed: " + WaveScreen.currentWave);
			}
		});
	}
	
	public void loadWave()
	{
		//need to set the currentWave to this newly created wave
		WaveScreen.currentWave = this;	
		WaveScreen.currentLevel = parentLevel;
	}
	
	public List<Enemy> getWave(){
		return waveEnemyList;
	}
	
	public void addEnemy(Enemy e){
		System.out.println("WAVE: " + time + " " + e.DEBUGPRINTSTRING());
		waveEnemyList.add(e);
	}
	
	public void addEnemyList(List<Enemy> enemyList){
		waveEnemyList = enemyList;
	}
	
	public String printOut(){
		return waveEnemyList.toString();
	}
	
	@Override
	public String toString(){
		String printedLine = "";
		printedLine += ("Time=" + Integer.toString(time));
		printedLine += ("\n");
		for(int i = 0; i < waveEnemyList.size(); i++){
			printedLine += waveEnemyList.get(i);
		}
		return printedLine;
	}
}
