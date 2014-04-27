using UnityEngine;
using System.Collections;

public class Bullet : MonoBehaviour
{
	Rigidbody rigidbody;
	public Bullet (Vector3 nposition, Quaternion nrotiation)
	{
		rigidbody = new Rigidbody();
		rigidbody.useGravity = false;
		rigidbody.freezeRotation = true;
		rigidbody.position = nposition;
		rigidbody.rotation = nrotiation;
	}

		//Basic collision detection checking for two differently named objects
	void OnCollisionEnter(Collision theCollision){
		if(theCollision.gameObject.name == "Floor"){
			Debug.Log("Hit the floor");
		}else if(theCollision.gameObject.name == "Wall"){
			Debug.Log("Hit the wall");
		}

	}
}

