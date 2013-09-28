
public final class Hater_Normal extends Enemy {

	public Hater_Normal(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_Normal";
		maxWeapons = 2;
		maxPassives = 3;
		imageFileName = "src/test2.png";
		setImageObject();
	}

}