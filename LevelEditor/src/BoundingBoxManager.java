import java.awt.Point;
import java.awt.geom.AffineTransform;
import java.util.Iterator;
import java.util.LinkedList;




/*
 * Manages the Bounding Boxes for Enemy collision Detection
 */

public class BoundingBoxManager {

	private static AffineTransform rotationMatrix = new AffineTransform();
	
	private static LinkedList<BoundingBox> boundingBoxes = new LinkedList<BoundingBox>();
	
	
	public synchronized static void addBoundingBox(BoundingBox l) {
		boundingBoxes.add(l);
	}
	
	public synchronized static BoundingBox removeBoundingBox(int x, int y) {
		//top left: x - (width/2), y - (height/2)
		//top right: x + (width/2), y - (height/2)
		//bottom left: x - (width/2), y + (height/2)
		//bottom right: x + (width/2), y + (height/2)
				
		Iterator<BoundingBox> boxes = boundingBoxes.iterator();
		BoundingBox temp = null;
		
		int counter = 0;
		
		while(boxes.hasNext()){
			counter++;
			System.out.println("BoundingBoxManager>counter: "+ counter);
			temp = boxes.next();
			System.out.println("BoundingBoxManager>Bounding Box: " + temp);
			Point topLeft = new Point(temp.enemyX - (temp.width/2), temp.enemyY - (temp.height/2));
			Point topRight = new Point(temp.enemyX + (temp.width/2), temp.enemyY - (temp.height/2));
			Point bottomLeft = new Point(temp.enemyX - (temp.width/2), temp.enemyY + (temp.height/2));
			Point bottomRight = new Point(temp.enemyX + (temp.width/2), temp.enemyY + (temp.height/2));
			
			
			if(temp.rotation == 0){
				if(x >= topLeft.x && y >= topLeft.y && x <= bottomRight.x && y <= bottomRight.y){
					System.out.println("BoundingBoxManager: Clicked A Bounding Box");
					boundingBoxes.remove(temp);
					return temp;
				}
			}
			else if (isPointInRotatedBoundingBox(x, y, temp)){
				boundingBoxes.remove(temp);
				return temp;
				
			}
		}
		return null;
	}
	
	/*
	 *  Checks to see if a point is in a bounding box.  If the math looks too confusing, don't worry about it. IT WORKS!
	 *  
	 *  ...No seriously, DO NOT TOUCH THIS!!!
	 *  
	 *  TO DO: Optimize this shit if we find waves have, like, over 200 enemies... but that would be dumb so don't do that.
	 */
	public static boolean isPointInRotatedBoundingBox(int mouseX, int mouseY, BoundingBox bbToCheck) {
			if(bbToCheck.rotation != 0){
				//rotationMatrix = AffineTransform.getRotateInstance(bbToCheck.rotation, bbToCheck.enemyX, bbToCheck.enemyY);
				Point topLeft = new Point(0,0);
				Point topRight = new Point(bbToCheck.imageWidth, 0);
				Point bottomLeft = new Point(0, bbToCheck.imageHeight);
				Point bottomRight = new Point(bbToCheck.imageWidth, bbToCheck.imageHeight);
				
				rotationMatrix.setToIdentity();
				rotationMatrix.translate(bbToCheck.enemyX, bbToCheck.enemyY);
				double rot = Math.toRadians(bbToCheck.rotation);
				rotationMatrix.rotate(rot);
				rotationMatrix.scale(bbToCheck.scaleX, bbToCheck.scaleY);
				rotationMatrix.translate( -(bbToCheck.imageWidth/2), -(bbToCheck.imageHeight/2));
				
				rotationMatrix.transform(topLeft, topLeft);
				rotationMatrix.transform(topRight, topRight);
				rotationMatrix.transform(bottomRight, bottomRight);
				rotationMatrix.transform(bottomLeft, bottomLeft);
				
				//CROSS PRODUCTS!!
				boolean leftBoundaryCheck = isPointRightOf(topLeft, topRight, mouseX, mouseY);
				boolean rightBoundaryCheck = isPointRightOf(topRight, bottomRight, mouseX, mouseY);
				boolean topBoundaryCheck = isPointRightOf(bottomRight, bottomLeft, mouseX, mouseY);
				boolean bottomBoundaryCheck = isPointRightOf(bottomLeft, topLeft, mouseX, mouseY);
				
				/*
				System.out.println("leftBoundaryCheck: " + leftBoundaryCheck);
				System.out.println("rightBoundaryCheck: " + rightBoundaryCheck);
				System.out.println("topBoundaryCheck: " + topBoundaryCheck);
				System.out.println("bottomBoundaryCheck: " + bottomBoundaryCheck);
				*/
				
				if (leftBoundaryCheck && rightBoundaryCheck  && topBoundaryCheck && bottomBoundaryCheck) {
					System.out.println("BoundingBoxManager: Clicked A Bounding Box");
					return true;
				}
			}
			return false;
	}
	
	public static boolean isPointRightOf(Point p1, Point p2, int mouseX, int mouseY) {
		return ((p2.x - p1.x)*(mouseY - p1.y) - (p2.y - p1.y)*(mouseX - p1.x)) > 0;
	}

	
}
