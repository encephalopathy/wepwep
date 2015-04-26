using UnityEngine;
using System.Collections;

public class DoubleShotWeapon : MonoBehaviour {

	public GameObject bullet;
	public float velocity = 10.0f;
	public GameObject spawnPt;
	public AudioSource pew;
	public float BulletLife = 3f;
	private Transform spawnBullet;
	private Vector3 tmpVector = new Vector3(.5f,0f,0f);
	
	//shootforward is most likely a basis for another weapon, hence the following logic"
	public GameObject player;
	
	// Update is called once per frame
	void Update ()
	{
		if(Input.GetButtonDown("Fire1"))
		{
			// cache oneSpawn object in spawnPt, if not cached yet
			//myObject.GetComponent<MyScript>().MyFunction();
			if( player.GetComponent<PlayerLogic>().canFire(10, false)) {
				if (!spawnPt) 
				{
					spawnPt = GameObject.Find("oneSpawn");
				}
				GameObject projectile = Instantiate(bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
				GameObject projectile2 = Instantiate(bullet, spawnPt.transform.position - tmpVector, Quaternion.identity) as GameObject;
				projectile.gameObject.name = "DSBullet1";
				projectile2.gameObject.name = "DSBullet2";
				Destroy(projectile.gameObject, BulletLife);
				Destroy (projectile2.gameObject, BulletLife);
				pew.Play(0);
			}
			
		}
	}

}
