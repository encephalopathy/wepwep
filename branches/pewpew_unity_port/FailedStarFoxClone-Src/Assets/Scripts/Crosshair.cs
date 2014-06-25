using UnityEngine;
using System.Collections;

public class Crosshair : MonoBehaviour {

	public Texture2D CrosshairImage;

	// Use this for initialization
	void Start () {
		Screen.showCursor = false; //Default mouse pointer disabled
	}
	
	// Update is called once per frame
	void Update () {
		//Screen.showCursor = false; //Default mouse pointer disabled
	}

	void OnGUI (){
		GUI.depth = 0;
		var mousePos = Event.current.mousePosition;
		GUI.DrawTexture (new Rect (mousePos.x - (CrosshairImage.width / 8), mousePos.y - (CrosshairImage.height / 8), CrosshairImage.width/4, CrosshairImage.height/4), CrosshairImage);
	}
}
