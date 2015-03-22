using UnityEngine;
using System.Collections;

public class Bullet : MonoBehaviour
{
	Rigidbody bulletRigidBody;
	public Bullet (Vector3 nposition, Quaternion nrotiation)
	{
		bulletRigidBody = new Rigidbody();
		bulletRigidBody.useGravity = false;
		bulletRigidBody.freezeRotation = true;
		bulletRigidBody.position = nposition;
		bulletRigidBody.rotation = nrotiation;
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

