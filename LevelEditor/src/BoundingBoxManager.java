import java.awt.Point;
import java.awt.geom.AffineTransform;
import java.util.Iterator;
import java.util.LinkedList;




/*
 * Manages the Bounding Boxes for Enemy collision Detection
 */

public class BoundingBoxManager {

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
			else if (isPointInRotatedBoundingBox(x, y, temp, topLeft, topRight, bottomRight, bottomLeft)){
				boundingBoxes.remove(temp);
				return temp;
				
			}
		}
		return null;
	}
	
	/*
	 *  Checks to see if a point is in a bounding box.  If the math looks too confusing, don't worry about it. IT WORKS!
	 */
	public static boolean isPointInRotatedBoundingBox(int mouseX, int mouseY, BoundingBox bbToCheck, Point topLeft, Point topRight, Point bottomRight, Point bottomLeft) {
			if(bbToCheck.rotation != 0){
				AffineTransform rotationMatrix = AffineTransform.getRotateInstance(bbToCheck.rotation, bbToCheck.enemyX, bbToCheck.enemyY);
				rotationMatrix.transform(topLeft, topLeft);
				rotationMatrix.transform(topRight, topRight);
				rotationMatrix.transform(bottomRight, bottomRight);
				rotationMatrix.transform(bottomLeft, bottomLeft);
				
				Point leftSide = new Point(topLeft.x - bottomLeft.x, topLeft.y - bottomLeft.y);
				Point topSide = new Point(topRight.x - topLeft.x, topRight.y - topLeft.y);
				Point rightSide = new Point(bottomRight.x - topRight.x, bottomRight.y - topRight.y);
				Point bottomSide = new Point(bottomLeft.x - bottomRight.x, bottomLeft.y - bottomRight.y);
				
				Point mouseClickPos = new Point(mouseX, mouseY);
				
				//CROSS PRODUCTS!!
				float leftBoundaryCheck = crossProduct(leftSide, mouseClickPos);
				float rightBoudaryCheck = crossProduct(rightSide, mouseClickPos);
				float topBoundaryCheck = crossProduct(topSide, mouseClickPos);
				float bottomBoundaryCheck = crossProduct(bottomSide, mouseClickPos);
				
				if (leftBoundaryCheck > 0 && rightBoudaryCheck > 0  && topBoundaryCheck > 0 && bottomBoundaryCheck > 0) {
					System.out.println("BoundingBoxManager: Clicked A Bounding Box");
					return true;
				}
			}
			return false;
	}
	
	public static float crossProduct(Point p1, Point p2) {
		return p1.x * p2.y -  p2.x * p1.y;
	}

	
}
