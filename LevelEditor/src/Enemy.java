
/**
 * will create basic enemies
 * 
 */
public class Enemy {
	
	//public variables
	public int enemyX;
	public int enemyY;
	public String type;
	public String weapon;
	
	//object constructor
	public Enemy(int xLoc, int yLoc)
	{
		System.out.println("Creating a new Enemy Object");
		enemyX = xLoc;
		enemyY = yLoc;
		System.out.println("enemyX: " + enemyX + ", enemyY: " + enemyY);
	}
	

}
