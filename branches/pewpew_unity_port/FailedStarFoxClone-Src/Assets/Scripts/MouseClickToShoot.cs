using UnityEngine;
using System.Collections;

public class MouseClickToShoot : MonoBehaviour {
	
	public GameObject character; //main character
	public GameObject bullet; // the bullet prefab
	public GameObject spawnPt; // holds the spawn point object
    public float ProjectileSpeed = 15;
    public AudioSource pew;

	// Use this for initialization
	void Start () {
	}
	
	void Update(){   
		if (Input.GetMouseButtonDown(0)){ // only do anything when the button is pressed:
			Ray ray = Camera.main.ScreenPointToRay (Input.mousePosition);
			RaycastHit hit;
			if (Physics.Raycast(ray, out hit)){
				Debug.DrawLine (character.transform.position, hit.point);
				// cache oneSpawn object in spawnPt, if not cached yet
				if (!spawnPt) spawnPt = GameObject.Find("oneSpawn");
				GameObject projectile = Instantiate(bullet, spawnPt.transform.position, Quaternion.identity) as GameObject;
                projectile.gameObject.name = "Bullet";
				// turn the projectile to hit.point
				projectile.transform.LookAt(hit.point); 
				// accelerate it
				projectile.rigidbody.velocity = projectile.transform.forward * ProjectileSpeed;
                //projectile.rigidbody.AddForce(transform.forward * ProjectileSpeed, ForceMode.VelocityChange);
                Destroy(projectile.gameObject, 3f);
                pew.Play(0);

			}
		}
	}
}
