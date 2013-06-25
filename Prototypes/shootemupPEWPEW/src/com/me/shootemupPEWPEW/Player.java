package com.me.shootemupPEWPEW;

import com.badlogic.gdx.Gdx;


/**
 * Child class of the ship class. Describes the player's ship and associated functions.
 * 
 * @author Nick Patti
 *
 */
public class Player extends Ship{

	
	/**
	 * Constructor for the player's ship. The position of the ship is halfway across the screen
	 * and about 
	 * 
	 * @param dispWidth Just as it says.
	 * @param dispHeight Same here as well. Used for calculating the proper position of the player.
	 * @return The player's ship, including collision, position, and drawing data.
	 */
	public Player(float dispWidth, float dispHeight){
		super(dispWidth, dispHeight);
	}

	
	@Override
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
}
