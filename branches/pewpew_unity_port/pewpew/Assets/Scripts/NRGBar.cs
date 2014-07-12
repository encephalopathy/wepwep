using UnityEngine;
using System.Collections;

public class NRGBar : MonoBehaviour {

	private int MaxNRG = 100;
	public int CurrentNRG = 100; 
	private float NRGBarInitialLength; 
	private float NRGBarCurrentLength;
	public Texture NRGBarBackground;
	public Texture NRGBarTexture;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		AdjustCurrentNRG(0);
	}

	void OnGUI () {
		float percentage = CurrentNRG / (float)MaxNRG;
		GUI.DrawTexture (new Rect (8, 8, NRGBarInitialLength + 4, 24), NRGBarBackground);
		GUI.DrawTextureWithTexCoords (new Rect (10, 10, NRGBarCurrentLength, 20), NRGBarTexture, new Rect(0, 0, percentage, 1f));
	} 

	public void AdjustCurrentNRG (int adj) {
		CurrentNRG += adj;
		if(CurrentNRG < 0)
			CurrentNRG = 0;
		if(CurrentNRG > MaxNRG)
			CurrentNRG = MaxNRG;
		if(MaxNRG < 1)
			MaxNRG = 1;
		if (CurrentNRG == 0) {
			//game over stuff
		}
		NRGBarCurrentLength = (Screen.width / 4) * (CurrentNRG / (float)MaxNRG);	
	}
}
