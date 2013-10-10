
public final class Hater_Normal extends Enemy {

	public Hater_Normal(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_Normal";
		maxWeapons = 1;
		maxPassives = 0;
		imageFileName = "src/sprites/enemy_01.png";
		setImageObject();
	}

}