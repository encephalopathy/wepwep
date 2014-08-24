using UnityEngine;
using System.Collections;

public class laserBullet : MonoBehaviour {
	public float velX;
	public float velY;
	public float velZ;
	
	public int damage = 15;
	public int NRGCost = 5;
	public GameObject player;
	public Vector3 movementVector;
	public float moveZ;

	void Start () {
		player = GameObject.Find("Ship");
		moveZ = player.transform.position.z + 2.0f;
		movementVector = new Vector3 (player.transform.position.x,0,moveZ);
		this.gameObject.transform.position = movementVector;
	}

	void Update ()
	{
		movementVector = new Vector3 (player.transform.position.x,0,moveZ);
		moveZ++;
		this.gameObject.transform.position = movementVector;
	}
	
	void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.name == "BasicEnemy")
		{
			EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
			enemylogic.doDamage(damage);
		}
	}

}
