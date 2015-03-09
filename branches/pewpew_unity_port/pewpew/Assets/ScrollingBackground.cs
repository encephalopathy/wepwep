using UnityEngine;
using System.Collections;

public class ScrollingBackground : MonoBehaviour {


	public float scrollSpeed = 0;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		float offset = Time.time * scrollSpeed;
		GetComponent<Renderer>().material.SetTextureOffset ("_MainTex", new Vector2 (0, -offset));
	}
}
