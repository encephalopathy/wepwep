package com.me.shootemupPEWPEW.player;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector3;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer.ShapeType;

public class Player {
	private Texture   texture;
	private Sprite    sprite;
	private Rectangle boundingBox;
	private Vector3   position;
	
	//TODO: The audio used by player will go here
	
	private float     displayHeight;
	private int       health;
	
	/**
	 * Constructor for the player's ship.
	 * 
	 * @param shipWidth The length of each side of the ship. Assumes the ship is a square.
	 * @param dispWidth Just as it says.
	 * @param dispHeight Same here as well. Used for calculating the proper position of the player.
	 * @return The player's ship, including collision, position, and drawing data.
	 */
	public Player(int shipWidth, float dispWidth, float dispHeight){
		
		//TODO: Perhaps clean this up a little bit?
		position = new Vector3(dispWidth/2 - shipWidth/2, 75, 0);
		texture = new Texture(Gdx.files.internal("textures/player_01.png"));
		sprite  = new Sprite(texture);
		//set the position and the scale of the sprite in one function
		sprite.setBounds(position.x - shipWidth / 2, position.y - shipWidth/2,
				         shipWidth * 2, shipWidth * 2);
		boundingBox = new Rectangle(position.x, position.y, shipWidth, shipWidth);
		
		displayHeight = dispHeight;
		health = 5;
	}
	
	
	/**
	 * Updates the ship's position and health during play. Read's input from the player,
	 * and checks for collisions. NOTE: This is where the conversion from screen coordinates
	 * to drawing coordinates takes place.
	 * 
	 * @return void
	 */
	public void update(){
		
		//are you touching the screen?
		if(Gdx.input.isTouched()){
			setPosition(Gdx.input.getX(), Gdx.input.getY());
		}
		
		//TODO: Did your ship get hit by a bullet or an enemy?	
	}
	
	
	/**
	 * Sets the position of the player, taking into account the various coordinate conversions
	 * that would otherwise make this a bitch to do. New coordinates are relative to the origin
	 * being placed on the bottom left corner of the screen.
	 * 
	 * @param x The player's new x position.
	 * @param y The player's new y position.
	 * @return void
	 */
	public void setPosition(int x, int y){
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
	 * Disposes of all disposable fields inside player.
	 * 
	 * @return void
	 */
	public void dispose(){
		texture.dispose();
		//TODO: Audio will be disposed in here once it's implemented
	}
}
