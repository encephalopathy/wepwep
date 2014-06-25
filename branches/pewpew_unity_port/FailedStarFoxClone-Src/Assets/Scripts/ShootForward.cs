using UnityEngine;
using System.Collections;

public class ShootForward : MonoBehaviour
{
	public Rigidbody bullet;
	public float velocity = 10.0f;

	// Update is called once per frame
	void Update ()
	{
		if(Input.GetButtonDown("Fire1"))
		{
			Rigidbody newBullet = Instantiate(bullet,transform.position,transform.rotation) as Rigidbody;
			newBullet.gameObject.name = "Bullet";
			newBullet.AddForce(transform.forward*velocity,ForceMode.VelocityChange);
            Destroy(newBullet.gameObject, 3f);

		}
	}


}
