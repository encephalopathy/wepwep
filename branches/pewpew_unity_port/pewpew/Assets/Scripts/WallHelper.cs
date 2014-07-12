using UnityEngine;
using System.Collections;

public class WallHelper : MonoBehaviour
{

		// Use this for initialization
		void Start ()
		{
	
		}
	
		// Update is called once per frame
		void Update ()
		{
	
		}

	//Basic collision detection checking for two differently named objects
	void OnTriggerEnter(Collider theCollision){
				if (theCollision.gameObject.name == "Bullet") {
						Debug.Log ("Bullet hit the wall yo");
						Destroy (theCollision.gameObject);
				} else if (theCollision.gameObject.name == "Jet") {
						Debug.Log ("You hit the wall");
						Destroy (theCollision.gameObject);
				}

		}

}

