using UnityEngine;
using System.Collections;

public class HomingCannon : MonoBehaviour
{
	
	public GameObject bullet;
	public GameObject homingBullet;
	public GameObject spawnPt;
	public AudioSource pew;
	public int damage = 15;
	public int NRGCost = 5;
	private float radarLife = 2f;
	private Transform spawnBullet;
	private Vector3 tmpVector = new Vector3 (.5f, 0f, 0f);
	private GameObject targetObject;
	
	void Update ()
	{
		if (Input.GetButtonDown ("Fire1")) {
			StartCoroutine ("fireRadar");
			pew.Play (0);
		}
	}

	IEnumerator fireRadar ()
	{
		for(int i =0; i< 10; i++) {
			GameObject radar = Instantiate (bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
			radar.gameObject.name = "radarCollider";
			yield return new WaitForSeconds (.2f);
			Destroy (radar.gameObject, radarLife);
		}
		
	}



	public void fireHomingBullet()
	{
		GameObject homingShot = Instantiate (homingBullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
		homingShot.gameObject.name = "homingBullet";
		Destroy (homingShot.gameObject, radarLife);

	}


	
	
}