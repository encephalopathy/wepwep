using UnityEngine;
using System.Collections;

public class radarShotLogic : MonoBehaviour
{
	
	
	public int damage = 15;
	public int NRGCost = 5;
	private float scaleSpeed = 1.5f;
	public GameObject spawnPt;
	public GameObject target;
	public GameObject bullet;
	public HomingCannon homingScript;
	private float radarRange = 45.0f;
	private HomingCannon homingCannon;

	void Update ()
	{
		if(this.transform.localScale.x < radarRange){
			this.transform.localScale += new Vector3(scaleSpeed, 0, scaleSpeed);
		}
	}
	
	void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.name == "BasicEnemy") //change later to tags for any enemy
		{
			target = other.gameObject;
			spawnPt = GameObject.Find("Right Blaster");
			homingCannon = spawnPt.GetComponent<HomingCannon>();
			homingCannon.spawnPt = spawnPt;
			homingCannon.fireHomingBullet();
			Destroy(this.gameObject);

		}
	}
	
}