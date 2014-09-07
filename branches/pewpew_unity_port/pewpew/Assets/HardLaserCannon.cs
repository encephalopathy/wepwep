using UnityEngine;
using System.Collections;

public class HardLaserCannon : MonoBehaviour {

	public GameObject bullet;
	public GameObject spawnPt;
	public AudioSource pew;
	public int damage = 15;
	public int NRGCost = 5;
	private float radarLife = 2f;
	private Transform spawnBullet;
	private Vector3 tmpVector = new Vector3 (.5f, 0f, 0f);

	void Update ()
	{
		if (Input.GetButtonDown ("Fire1")) {
			StartCoroutine ("fire");
			pew.Play (0);
		}
	}
	
	IEnumerator fire ()
	{
		GameObject laserBeam = Instantiate (bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
		laserBeam.gameObject.name = "laserBeam";
		Destroy (laserBeam.gameObject, radarLife);
		return null;
	}
}
