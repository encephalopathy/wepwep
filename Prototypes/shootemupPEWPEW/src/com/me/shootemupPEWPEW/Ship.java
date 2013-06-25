package com.me.shootemupPEWPEW;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;


/**
 * Describes a space ship that appears during play, whether it is the player's ship
 * or an enemy.
 * 
 * @author Nick Patti
 */
public abstract class Ship {
	protected Texture   texture;
	protected Sprite    sprite;
	protected int       size = 64; //this is standard ship size
	protected Rectangle boundingBox;
	protected Vector2   position;
	private   float     displayHeight;
	private   int       health;
	
	
	/**
	 * Constructor for the player's ship. The position of the ship is halfway across the screen
	 * and about 
	 * 
	 * @param dispWidth Just as it says.
	 * @param dispHeight Same here as well. Used for calculating the proper position of the player.
	 * @return The player's ship, including collision, position, and drawing data.
	 */
	public Ship(float dispWidth, float dispHeight){
		
		//TODO: Perhaps clean this up a little bit?
		position = new Vector2(dispWidth/2 - size/2, 75);
		texture  = new Texture(Gdx.files.internal("textures/player_01.png"));
		sprite   = new Sprite(texture);
		//set the position and the scale of the sprite in one function
		sprite.setBounds(position.x - size / 2, position.y - size / 2,
				         size * 2, size * 2);
		boundingBox = new Rectangle(position.x, position.y, size, size);
		displayHeight = dispHeight;
		health = 5;
	}
	
	
	/**
	 * The constructor used for enemy ships. Can select the size, position,
	 * and texture name to create an enemy.
	 * 
	 * @param size The size of the ship in pixels
	 * @param startPosition The starting location of the ship
	 * @param textureName The internal file name of the texture to be used
	 * @param dispHeight Required to calculate proper position of this ship
	 * @return An enemy ship in the location, size, and texture specified
	 */
	public Ship(int shipSize, Vector2 startPosition, String textureName, float dispHeight){
		position = new Vector2(startPosition.x, startPosition.y);
		texture  = new Texture(Gdx.files.internal(textureName));
		sprite   = new Sprite(texture);
		sprite.setBounds(position.x - shipSize / 2, position.y - shipSize / 2, shipSize * 2, shipSize * 2);
		boundingBox = new Rectangle(position.x, position.y, shipSize, shipSize);
		displayHeight = dispHeight;
		health = 1;
	}
	
	
	//Check the inherited classes update() declaration for more information
	abstract void update();
	
	
	/**
	 * Sets the position of the ship, taking into account the various coordinate conversions
	 * that would otherwise make this a bitch to do. New coordinates are relative to the origin
	 * being placed on the bottom left corner of the screen.
	 * 
	 * @param x The ship's new x position.
	 * @param y The ship's new y position.
	 * @return void
	 */
	protected void setPosition(int x, int y){
		float offset = boundingBox.width/2;
		position.x = x - offset;
		position.y = displayHeight - y - offset;
		sprite.setPosition(position.x - offset, position.y - offset);
	}
	
	
	/**
	 * Draws the ship's sprite. This should be called after the SpriteBatch's begin(),
	 * but before it's end().
	 * 
	 * @param batch The SpriteBatch that the ship is drawn.
	 * @return void
	 */
	public void draw(SpriteBatch batch){
		sprite.draw(batch);
	}
	
	
	/**
	 * Draws the bounding box. Works like draw(SpriteBatch batch), but for
	 * the ShapeRenderer instead
	 * 
	 * @param shapeRenderer The ShapeRenderer that the box will be drawn with.
	 * @return void
	 */
	public void drawDebugRectangle(ShapeRenderer shapeRenderer){
		shapeRenderer.setColor(1, 1, 0, 1);
		shapeRenderer.box(position.x, position.y, 0, boundingBox.width, boundingBox.height, 0);
	}
	
	
	/**
	 * Useful getter method in case the ship's health needs to be used in another class,
	 * such as a UI element or something.
	 * 
	 * @return The ship's current health.
	 */
	public int getHealth(){
		return health;
	}
	
	
	/**
	 * Disposes of all disposable fields of the ship.
	 * 
	 * @return void
	 */
	public void dispose(){
		texture.dispose();
		//TODO: Audio will be disposed in here once it's implemented
	}
}
