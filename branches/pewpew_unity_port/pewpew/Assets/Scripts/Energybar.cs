using UnityEngine;
using System.Collections;

public class Energybar : MonoBehaviour {

	private float MaxEnergy = 100;
	public float CurrentEnergy = 100; 
	private float EnergyBarInitialLength; 
	private float EnergyBarCurrentLength;
	public Texture EnergyBarBackground;
	public Texture EnergyBar;

	// Use this for initialization
	void Start () {
		EnergyBarInitialLength = Screen.width / 4; 
	}
	
	// Update is called once per frame
	void Update () {
		//AdjustCurrentEnergy (0) ; 
	}

	void OnGUI () {
		float percentage = CurrentEnergy / (float)MaxEnergy;
		GUI.DrawTexture (new Rect (8, 50, 24, EnergyBarInitialLength + 4), EnergyBarBackground);
		GUI.DrawTextureWithTexCoords (new Rect (10, 52 + EnergyBarInitialLength, 20, -EnergyBarCurrentLength), EnergyBar, new Rect(0, 0, 1f, -percentage));
	}

	public void SetCurrentEnergy (float adj) {
		CurrentEnergy = adj;
		if(CurrentEnergy < 0)
			CurrentEnergy = 0;
		if(CurrentEnergy > MaxEnergy)
			CurrentEnergy = MaxEnergy;
		if(MaxEnergy < 1)
			MaxEnergy = 1;
		if (CurrentEnergy == 0) {
			//game over stuff
		}
		EnergyBarCurrentLength = (Screen.width / 4) * (CurrentEnergy / (float)MaxEnergy);
		}

	public void AdjustCurrentEnergy (float adj) {
		CurrentEnergy += adj;
		if(CurrentEnergy < 0)
			CurrentEnergy = 0;
		if(CurrentEnergy > MaxEnergy)
			CurrentEnergy = MaxEnergy;
		if(MaxEnergy < 1)
			MaxEnergy = 1;
		if (CurrentEnergy == 0) {
			//game over stuff
		}
		EnergyBarCurrentLength = (Screen.width / 4) * (CurrentEnergy / (float)MaxEnergy);	
	} 
}
