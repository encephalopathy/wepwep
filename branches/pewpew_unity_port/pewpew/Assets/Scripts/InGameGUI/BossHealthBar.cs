using UnityEngine;
using System.Collections;

public class BossHealthBar : MonoBehaviour {

	private int BossMaxHealth;
	private int BossCurrentHealth; 
	private float BossHealthBarInitialLength;
	private float BossHealthBarCurrentLength;
	public Texture BossHealthBarBackground;
	public Texture BossHealthbar;
    public GameObject BossObject;
    private EnemyLogic BossLogic;

	// Use this for initialization
	void Start ()
    {
		BossHealthBarInitialLength = Screen.width * 85 / 100;
        BossLogic = (EnemyLogic)BossObject.gameObject.GetComponent(typeof(EnemyLogic));
        BossMaxHealth = BossLogic.MaxHealth;
        BossCurrentHealth = BossMaxHealth;
	}
	
	// Update is called once per frame
	void Update ()
    {
		AdjustCurrentBossHealth (0) ; 
	}

	void OnGUI ()
    {
		float percentage = BossCurrentHealth / (float)BossMaxHealth;
		GUI.DrawTexture (new Rect (8, Screen.height - 25, BossHealthBarInitialLength + 4, 24), BossHealthBarBackground);
		GUI.DrawTextureWithTexCoords (new Rect (10, Screen.height - 23, BossHealthBarCurrentLength, 20), BossHealthbar, new Rect(0, 0, percentage, 1f));
	} 

	public void AdjustCurrentBossHealth (int adj) {
		BossCurrentHealth -= adj;
		if(BossCurrentHealth < 0)
			BossCurrentHealth = 0;
		if(BossCurrentHealth > BossMaxHealth)
			BossCurrentHealth = BossMaxHealth;
		if(BossMaxHealth < 1)
			BossMaxHealth = 1;
		if (BossCurrentHealth == 0) {
			//game over stuff
		}
		BossHealthBarCurrentLength = (Screen.width * 85 / 100) * (BossCurrentHealth / (float)BossMaxHealth);	
	} 
}
