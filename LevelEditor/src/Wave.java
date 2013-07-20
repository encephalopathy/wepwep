import java.util.ArrayList;
import java.util.List;


public class Wave {

	int time = 0;
	private List<Enemy> waveEnemyList = new ArrayList<Enemy>();
	
	public Wave(List<Enemy> list, int t){
		time = t;
		waveEnemyList = list;
	}
	
	public void loadWave(){
		System.out.println("LOADED BITCHES");
		WaveScreen.SetEnemyList(waveEnemyList);
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
