package com.me.shootemupPEWPEW;

import com.badlogic.gdx.ApplicationListener;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.audio.Music;
import com.badlogic.gdx.audio.Sound;
import com.badlogic.gdx.graphics.GL10;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.Texture.TextureFilter;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureRegion;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer.ShapeType;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector3;
import com.badlogic.gdx.utils.Array;

import com.me.shootemupPEWPEW.player.Player;

public class ShootEmUpPEWPEW implements ApplicationListener {
	
	private OrthographicCamera camera;
	private SpriteBatch batch;
	private ShapeRenderer shapeRenderer;
	
	//player data
	private Player           player;
	private Texture          playerBulletTexture;
	private Array<Rectangle> playerBullets;
	
	//TODO: enemy data declaration

	//TODO: sounds and music declarations
	
	@Override
	public void create() {		
		float w = Gdx.graphics.getWidth();
		float h = Gdx.graphics.getHeight();
		
		camera = new OrthographicCamera(w, h);
		batch = new SpriteBatch();
		shapeRenderer = new ShapeRenderer();
		
		player = new Player(64, w, h);
	}

	@Override
	public void dispose() {
		batch.dispose();
		shapeRenderer.dispose();
		player.dispose();
	}

	@Override
	public void render() {		
		
		//set the clear color, then clear the screen with that color
		Gdx.gl.glClearColor(0, 0, 0.4f, 1);
		Gdx.gl.glClear(GL10.GL_COLOR_BUFFER_BIT);
		
		//camera.update();
		player.update();
		
		//sprite batch work
		batch.begin();
		player.draw(batch);
		batch.end();
		
		//debug shape renderer
		shapeRenderer.begin(ShapeType.Line);
		player.drawDebugRectangle(shapeRenderer);
		shapeRenderer.end();
		
	}

	@Override
	public void resize(int width, int height) {
	}

	@Override
	public void pause() {
	}

	@Override
	public void resume() {
	}
}
