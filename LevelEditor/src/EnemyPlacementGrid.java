import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.ImageIcon;
import javax.swing.JComponent;


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
				System.out.println("Inside mouseReleased event");
				System.out.println("What the hell is this thing? "+ enemyToDraw.getClass().getSimpleName());
				
				System.out.println(e.getSource());
				currentX = e.getX();
				currentY = e.getY();
				System.out.println(currentX);
				System.out.println(currentY);
				
				enemyToDraw.setLocation(currentX, currentY);
				
				/*
				Image imageObject = new ImageIcon( enemyToDraw.imageFileName).getImage();
				graphics2D.drawImage(imageObject, currentX, currentY, 25, 25, null);
				repaint();
				*/
				paintSprite(enemyToDraw);
			}
		});
	}
	
	
	//functions
	public void paintComponent(Graphics g){
		System.out.println("CALLED paintComponent");
		if(image == null){
			image = createImage(getSize().width, getSize().height);
			graphics2D = (Graphics2D)image.getGraphics();
			graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
			clear();
			System.out.println("image is null");
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
		Image imageObject = new ImageIcon( enemyToDraw.imageFileName).getImage();
		graphics2D.drawImage(imageObject, e.enemyX, e.enemyY, 25, 25, null);
		repaint();
	}
}
