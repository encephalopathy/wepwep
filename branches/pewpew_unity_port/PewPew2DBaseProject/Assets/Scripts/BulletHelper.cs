using UnityEngine;
using System.Collections;

public class BulletHelper : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}


    //Basic collision detection checking for two differently named objects
    void OnCollisionEnter(Collision theCollision)
    {
        if (theCollision.gameObject.name == "Bullet")
        {
            Debug.Log("Bullet hit the wall yo");
            Destroy(theCollision.gameObject);
        }
        else 
        {
            Destroy(this);
        }

    }

}
