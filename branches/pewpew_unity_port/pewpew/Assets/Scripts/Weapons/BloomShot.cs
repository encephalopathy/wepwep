using UnityEngine;
using System.Collections;

public class BloomShot : MonoBehaviour
{
	
	public GameObject bullet;
	public float velocity = 10.0f;
	public GameObject spawnPt;
	public AudioSource pew;
	public float BulletLife = 3f;
	private float bulletSpread = 180f;
	private int numberOfBullets = 90;
	private Transform spawnBullet;
	private Vector3 tmpVector = new Vector3 (.5f, 0f, 0f);
	public GameObject player;
	
	void Update ()
	{
		if (Input.GetButtonDown ("Fire1")) {
			StartCoroutine ("fireSpread");
		}
	}
	
	IEnumerator fireSpread ()
	{
		if (player.GetComponent<PlayerLogic> ().canFire (75)) {
			if (!spawnPt) {
				spawnPt = GameObject.Find ("oneSpawn");
			}
			for (int j = 0; j < 5; j++) {
				StartCoroutine ("wave");
				StartCoroutine ("wave2");
				yield return new WaitForSeconds (.5f);
			}
			pew.Play (0);
            player.GetComponent<PlayerLogic>().isFiring = false;
		}
	}
	
	IEnumerator wave ()
	{
		float angle = (bulletSpread / (numberOfBullets - 1));
		for (int i = 0; i < numberOfBullets; i++) {
			GameObject projectile = Instantiate (bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
			projectile.transform.rotation = Quaternion.Euler (0, (angle * i) - (bulletSpread / 2), 0);
			projectile.gameObject.name = "TripleShot";
			yield return new WaitForSeconds (.001f);
			Destroy (projectile.gameObject, BulletLife);
		}
		for (int i = numberOfBullets; i > 0; i--) {
			GameObject projectile = Instantiate (bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
			projectile.transform.rotation = Quaternion.Euler (0, (angle * i) - (bulletSpread / 2), 0);
			projectile.gameObject.name = "TripleShot";
			yield return new WaitForSeconds (.001f);
			Destroy (projectile.gameObject, BulletLife);
		}
	}
	
	IEnumerator wave2 ()
	{
		float angle = (bulletSpread / (numberOfBullets - 1));
		
		for (int i = numberOfBullets; i > 0; i--) {
			GameObject projectile = Instantiate (bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
			projectile.transform.rotation = Quaternion.Euler (0, (angle * i) - (bulletSpread / 2), 0);
			projectile.gameObject.name = "TripleShot";
			yield return new WaitForSeconds (.001f);
			Destroy (projectile.gameObject, BulletLife);
		}
		for (int i = 0; i < numberOfBullets; i++) {
			GameObject projectile = Instantiate (bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
			projectile.transform.rotation = Quaternion.Euler (0, (angle * i) - (bulletSpread / 2), 0);
			projectile.gameObject.name = "TripleShot";
			yield return new WaitForSeconds (.001f);
			Destroy (projectile.gameObject, BulletLife);
		}
	}
	
	
	
}
