
public final class Hater_SpeedUp extends Enemy {

	public Hater_SpeedUp(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_SpeedUp";
		maxWeapons = 1;
		maxPassives = 1;
		imageFileName = "src/sprites/enemy_07.png";
		setImageObject();
	}

}