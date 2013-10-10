
public final class Hater_HalfStrafe extends Enemy {

	public Hater_HalfStrafe(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_HalfStrafe";
		maxWeapons = 1;
		maxPassives = 0;
		imageFileName = "src/sprites/enemy_02.png";
		setImageObject();
	}

}