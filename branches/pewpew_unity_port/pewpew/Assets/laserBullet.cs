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
	public float moveZ = 0;

	void Start () {
		player = GameObject.Find("Ship");
		moveZ = player.transform.position.z + 2.0f;

		movementVector = new Vector3 (player.transform.position.x,0,moveZ);
		this.gameObject.transform.position = movementVector;
	}

	void Update ()
	{
		if (Input.GetButton ("Fire1")) {
						movementVector = new Vector3 (player.transform.position.x, 0, moveZ);
						moveZ = moveZ + .5f;
						this.gameObject.transform.position = movementVector;
		} else {
			this.gameObject.transform.Translate(0,0,1);
		}
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
