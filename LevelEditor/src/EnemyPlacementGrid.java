import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.geom.AffineTransform;

import javax.swing.ImageIcon;
import javax.swing.JComponent;
import javax.swing.SwingUtilities;


public class EnemyPlacementGrid extends JComponent{
	
	//Functions
	private static final long serialVersionUID = 1L;
	Image image;
	Graphics2D graphics2D;
	int currentX, currentY;
	String item = "test.png";
	
	//assume this is a field that sets the enemies sprite location in the "green zone"
	public Enemy enemyToDraw;	
	
	//Constructor
	public EnemyPlacementGrid(){
			
		setDoubleBuffered(false);
		addMouseListener(new MouseAdapter(){
			public void mouseReleased (MouseEvent e){
				if(SwingUtilities.isLeftMouseButton(e) && enemyToDraw != null){
					//System.out.println(e.getSource());
					currentX = e.getX();
					currentY = e.getY();
					enemyToDraw.setLocation(currentX, currentY);
					System.out.println("Drawing an enemy of type in MOUSE RELEASED: " + enemyToDraw);
					paintSprite(enemyToDraw);
				}
			}
		});
	}
	
	//functions
	public void paintComponent(Graphics g){
		//System.out.println("CALLED paintComponent");
		if(image == null){
			image = createImage(getSize().width, getSize().height);
			graphics2D = (Graphics2D)image.getGraphics();
			graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
			clear();
		}
		g.drawImage(image, 0, 0, null);
	}
	
	public void clear(){
		graphics2D.setPaint(Color.white);
		graphics2D.clearRect(0, 0, getSize().width, getSize().height);
		graphics2D.setPaint(Color.black);
		repaint();
	}
	
	public void paintSprite(Enemy e){
		//Image imageObject = new ImageIcon(enemyToDraw.imageFileName).getImage();
		double d = e.rotation * (Math.PI/180); //graphics2D needs a double for rotation
		//FUCK THIS NONSENSE!
		AffineTransform transform = new AffineTransform();
		transform.translate((double)e.enemyX, (double)e.enemyY);
		transform.rotate(d);
		transform.scale(e.scaleX, e.scaleY);
		System.out.println("and I swear: " + e.scaleX +  " by the moon and stars in the sky: " + e.scaleY);
		transform.translate( -((e.imageWidth/2) - (e.width/2)), -((e.imageHeight/2) - (e.width/2)) );
		graphics2D.drawImage(e.imageObject, transform, null);
		
		BoundingBoxManager.addBoundingBox(e);
		
		//graphics2D.drawImage(e.imageObject, e.enemyX, e.enemyY, 25, 25, null);
		System.out.println("PAST THE DRAW");
		repaint();
	}

}
