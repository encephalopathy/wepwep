
public final class Hater_Homing extends Enemy {

	public Hater_Homing(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_Homing";
		maxWeapons = 0;
		maxPassives = 1;
		imageFileName = "src/sprites/enemy_03.png";
		setImageObject();
	}

}