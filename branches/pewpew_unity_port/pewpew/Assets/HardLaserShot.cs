using UnityEngine;
using System.Collections;

public class HardLaserShot : MonoBehaviour {
	
	public int damage = 15;
	public int NRGCost = 5;
	private float scaleSpeed = 1.5f;
	private float radarRange = 90.0f;
	private GameObject player;
	

	void Start () {
		player = GameObject.Find("Ship");

		this.transform.localPosition = new Vector3(0, 0, 0);

	}

	void Update ()
	{
		if(this.transform.localScale.x < radarRange){
			this.transform.localScale += new Vector3(0, 0, scaleSpeed);
			this.transform.position = new Vector3(0, 0, scaleSpeed);
		}
		this.transform.position = player.transform.position;
	}
	
	void OnTriggerStay(Collider other)
	{
		if (other.gameObject.name == "BasicEnemy") //change later to tags for any enemy
		{
			EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
			enemylogic.doDamage(damage);
		}
	}
}
