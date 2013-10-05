
public final class Hater_MidScreen extends Enemy {

	public Hater_MidScreen(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_MidScreen";
		maxWeapons = 1;
		maxPassives = 1;
		imageFileName = "src/sprites/enemy_05.png";
		setImageObject();
	}

}
