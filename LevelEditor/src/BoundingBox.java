
public abstract class BoundingBox {

	public abstract void onBoundingBoxClick(Object e, int eventType);
	
	//variables for boondingBooxes
	public int height = 25; 
	public int width = 25;
	public int imageHeight = 0;
	public int imageWidth = 0;
	public int enemyX;
	public int enemyY;
	public double rotation = 0;
	public double scaleX = 1;
	public double scaleY = 1;
	
}
