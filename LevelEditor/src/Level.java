import java.util.ArrayList;
import java.util.List;

/*
 * this will hold all the waves, so full of enemies... to kill!
 */

public class Level {

	int levelNumber;
	public List<Wave> waveList = new ArrayList<Wave>();
	
	//Constructor
	public Level (int level )
	{
		levelNumber = level;
	}
	
	public void AddWave(Wave newWave)
	{
		System.out.println("Adding Wave");
		waveList.add(newWave);
		System.out.println("Size of Level: " + waveList.size());
	}
	
}
