package com.me.shootemupPEWPEW;

import com.badlogic.gdx.math.Vector2;


/**
 * Child class of the ship class. Defines an enemy based on given parameters
 * 
 * @author Nick Patti
 *
 */
public class Enemy extends Ship{

	
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
	public Enemy(int size, Vector2 startPosition, String textureName, float dispHeight){
		super(size, startPosition, textureName, dispHeight);
	}

	
	@Override
	/**
	 * Handles the behavior and collision detecting of the enemy.
	 * 
	 * @return void
	 */
	void update() {
		//TODO: Fill this in when you get to it
	}
}
