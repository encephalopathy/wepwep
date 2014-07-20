using UnityEngine;
using System.Collections;

public class TrippleShot : MonoBehaviour
{

		public GameObject bullet;
		public float velocity = 10.0f;
		public GameObject spawnPt;
		public AudioSource pew;
		public float BulletLife = 3f;
		private float bulletSpread = 30f;
		private int numberOfBullets = 3;
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
				if (player.GetComponent<PlayerLogic> ().canFire (15)) {
						if (!spawnPt) {
								spawnPt = GameObject.Find ("oneSpawn");
						}
						for (int j = 0; j < 3; j++) {
								StartCoroutine ("wave");
								pew.Play (0);
								yield return new WaitForSeconds (.2f);
						}
						
			
				}
		}

		IEnumerator wave ()
		{
				float angle = (bulletSpread / (numberOfBullets - 1));
				for (int i = 0; i < numberOfBullets; i++) {
						GameObject projectile = Instantiate (bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
						projectile.transform.rotation = Quaternion.Euler (0, (angle * i) - (bulletSpread / 2), 0);
						projectile.gameObject.name = "TripleShot";
						Destroy (projectile.gameObject, BulletLife);
				}
		return null;
		}
	

	
	
}
