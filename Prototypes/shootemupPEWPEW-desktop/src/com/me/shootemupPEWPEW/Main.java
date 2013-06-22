package com.me.shootemupPEWPEW;

import com.badlogic.gdx.backends.lwjgl.LwjglApplication;
import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration;

public class Main {
	public static void main(String[] args) {
		LwjglApplicationConfiguration cfg = new LwjglApplicationConfiguration();
		cfg.title = "Shoot 'Em Up: PEW!! PEW!! Prototype";
		cfg.width = 720;
		cfg.height = 1280;
		
		new LwjglApplication(new ShootEmUpPEWPEW(), cfg);
	}
}
