
public final class Hater_SineWave extends Enemy {

	public Hater_SineWave(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_SineWave";
		maxWeapons = 1;
		maxPassives = 1;
		imageFileName = "src/sprites/enemy_04.png";
		setImageObject();
	}

}