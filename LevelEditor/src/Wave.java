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
	JMenuItem waveButton = null;
	
	//constructor for wave
	public Wave( int t){
		time = t;
		
		//menu set up
		waveButton = new JMenuItem(Integer.toString(t));
		waveButton.addActionListener(new ActionListener(){
			@Override
			public void actionPerformed(ActionEvent e) {
				//will make a call to load wave
				
			}
		});
	}
	
	public void loadWave()
	{
		//need to set the currentWave to this newly created wave
			
	}
	
	public List<Enemy> getWave(){
		return waveEnemyList;
	}
	
	public void setWave(Enemy e){
		System.out.println("WAVE: " + time + " " + e.DEBUGPRINTSTRING());
		waveEnemyList.add(e);
	}
	
	public void setWave(List<Enemy> enemyList){
		waveEnemyList = enemyList;
	}
}
