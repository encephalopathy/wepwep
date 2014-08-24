using UnityEngine;
using System.Collections;

public class LaserShot : MonoBehaviour
{
	
	public GameObject bullet;
	public float velocity = 100.0f;
	public GameObject spawnPt;
	public AudioSource pew;
	public float BulletLife = 3f;
	private float bulletSpread = 180f;
	private int numberOfBullets = 90;
	private Transform spawnBullet;
	private Vector3 tmpVector = new Vector3 (.5f, 0f, 500.0f);
	public GameObject player;
	
	void Update ()
	{
		if (Input.GetButtonDown ("Fire1")) {
			StartCoroutine ("fireSpread");
		}
		else {
			StopCoroutine("fireSpread");
		}
	}
	
	IEnumerator fireSpread ()
	{
		if (player.GetComponent<PlayerLogic> ().canFire (30)) {
			if (!spawnPt) {
				spawnPt = GameObject.Find ("oneSpawn");
			}
				StartCoroutine("wave");
				pew.Play (0);
			
		}
		return null;
	}
	IEnumerator wave ()
	{	
		for (int i = numberOfBullets; i > 0; i--) {
			GameObject projectile = Instantiate (bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
			projectile.gameObject.name = "LaserShot";
			yield return new WaitForSeconds (.01f);
			Destroy (projectile.gameObject, BulletLife);
		}
		
	}
	
	
	
}