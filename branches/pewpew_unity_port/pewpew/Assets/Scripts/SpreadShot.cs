using UnityEngine;
using System.Collections;

public class SpreadShot : MonoBehaviour
{

		public GameObject bullet;
		public float bulletSpeed = 10.0f; //currently unused
		public GameObject spawnPt;
		public AudioSource SoundEffect;
		public float bulletLife = 3f;
		public float firingAngle = 30f;
		public int numberOfBullets = 3;
		private Transform spawnBullet;
		private Vector3 tmpVector = new Vector3 (0f, 0f, 0f);
		public GameObject player;
        public int energyCost = 15;
        public float delayBetweenWaves = 0.2f; // higher number for a longer delay
        public int numberOfWaves = 3;
        public int numberOfArcs = 2;
        public float angleBetweenArcs = 10f;

		void Update ()
		{
				if (Input.GetButtonDown ("Fire1")) {
						StartCoroutine ("fireSpread");
				}
		}

		IEnumerator fireSpread ()
		{
				if (player.GetComponent<PlayerLogic> ().canFire (energyCost)) {
						if (!spawnPt) {
								spawnPt = GameObject.Find ("oneSpawn");
						}
						for (int j = 0; j < numberOfWaves; j++) {
								StartCoroutine ("wave");
								SoundEffect.Play (0);
								yield return new WaitForSeconds (delayBetweenWaves);
						}
						
			
				}
		}

		IEnumerator wave ()
		{
				float angle = (firingAngle / (numberOfBullets - 1));
				for (int i = 0; i < numberOfBullets; i++) {
						GameObject projectile = Instantiate (bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
						projectile.transform.rotation = Quaternion.Euler (0, (angle * i) - (firingAngle / 2), 0);
						projectile.gameObject.name = "TripleShot";
						Destroy (projectile.gameObject, bulletLife);
				}
		return null;
		}
}
