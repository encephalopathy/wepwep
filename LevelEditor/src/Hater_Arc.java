
public final class Hater_Arc extends Enemy {

	public Hater_Arc(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_Arc";
		maxWeapons = 1;
		maxPassives = 1;
		imageFileName = "src/sprites/enemy_06.png";
		setImageObject();
	}

}
