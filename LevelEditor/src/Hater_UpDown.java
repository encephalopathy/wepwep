
public final class Hater_UpDown extends Enemy {

	public Hater_UpDown(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_UpDown";
		maxWeapons = 1;
		maxPassives = 1;
		imageFileName = "src/sprites/enemy_06.png";
		setImageObject();
	}

}
