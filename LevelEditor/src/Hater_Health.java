
public final class Hater_Health extends Enemy {

	public Hater_Health(EnemyPlacementGrid Grid) {
		super(Grid);
		type = "com.game.enemies.Hater_Health";
		maxWeapons = 0;
		maxPassives = 2;
		imageFileName = "src/sprites/enemy_06.png";
		setImageObject();
	}

}