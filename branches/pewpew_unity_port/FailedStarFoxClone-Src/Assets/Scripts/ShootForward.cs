using UnityEngine;
using System.Collections;

public class ShootForward : MonoBehaviour
{
	public GameObject bullet;
	public float velocity = 10.0f;
	public GameObject spawnPt;
	public AudioSource pew;


	// Update is called once per frame
	void Update ()
	{
		if(Input.GetButtonDown("Fire1"))
		{
			// cache oneSpawn object in spawnPt, if not cached yet
			if (!spawnPt) spawnPt = GameObject.Find("oneSpawn");
			GameObject projectile = Instantiate(bullet, spawnPt.transform.position, Quaternion.identity) as GameObject;
			projectile.gameObject.name = "Bullet";
			// turn the projectile to hit.point
			//projectile.transform.LookAt(hit.point); 
			// accelerate it
			//projectile.rigidbody.velocity = projectile.transform.forward * velocity;
			//projectile.rigidbody.AddForce(transform.forward * ProjectileSpeed, ForceMode.VelocityChange);
			Destroy(projectile.gameObject, 3f);
			pew.Play(0);
			
			
			//Rigidbody newBullet = Instantiate(bullet,transform.position,transform.rotation) as Rigidbody;
			//newBullet.gameObject.name = "Bullet";
			//newBullet.AddForce(transform.forward*velocity,ForceMode.VelocityChange);
            //Destroy(newBullet.gameObject, 3f);

		}
	}


}
