using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class HealthBar : MonoBehaviour {

	private int MaxHealth = 100;
	public int CurrentHealth = 100; 
	private float HealthBarInitialLength;
	private float HealthBarCurrentLength;
	public Texture HealthBarBackground;
	public Texture Healthbar;
	public GameObject textObject;
	private Text healthText;

	// Use this for initialization
	void Start () {
		HealthBarInitialLength = Screen.width / 4;
		healthText = textObject.GetComponent<Text>();
		Debug.Log("HealthBar.cs is : " + healthText);
	}
	
	// Update is called once per frame
	void Update () {
		AdjustCurrentHealth (0) ;
		healthText.text = "Health : " + CurrentHealth;
	}

	void OnGUI () {
		float percentage = CurrentHealth / (float)MaxHealth;
		GUI.DrawTexture (new Rect (8, 8, HealthBarInitialLength + 4, 24), HealthBarBackground);
		GUI.DrawTextureWithTexCoords (new Rect (10, 10, HealthBarCurrentLength, 20), Healthbar, new Rect(0, 0, percentage, 1f));
	} 

	public void AdjustCurrentHealth (int adj) {
		CurrentHealth += adj;
		if(CurrentHealth < 0)
			CurrentHealth = 0;
		if(CurrentHealth > MaxHealth)
			CurrentHealth = MaxHealth;
		if(MaxHealth < 1)
			MaxHealth = 1;
		if (CurrentHealth == 0) {
			//game over stuff
		}
		HealthBarCurrentLength = (Screen.width / 4) * (CurrentHealth / (float)MaxHealth);	
	} 
}
