using UnityEngine;
using System.Collections;

public class ShootForward : MonoBehaviour
{
	public GameObject bullet;
	public float velocity = 10.0f;
	public GameObject spawnPt;
	public AudioSource pew;
	public float BulletLife = 3f;

	//shootforward is most likely a basis for another weapon, hence the following logic"
	public GameObject player;

	// Update is called once per frame
	void Update ()
	{
		if(Input.GetButtonDown("Fire1"))
		{
			// cache oneSpawn object in spawnPt, if not cached yet
			//myObject.GetComponent<MyScript>().MyFunction();
			if( player.GetComponent<PlayerLogic>().canFire(10)) {
				if (!spawnPt) spawnPt = GameObject.Find("oneSpawn");
				GameObject projectile = Instantiate(bullet, spawnPt.transform.position, Quaternion.identity) as GameObject;
				projectile.gameObject.name = "Bullet";
				Destroy(projectile.gameObject, BulletLife);
				pew.Play(0);
			}

		}
	}


}
