using UnityEngine;
using System.Collections;

public class HomingShot : MonoBehaviour {

	public int damage = 100;
	public int NRGCost = 5;
	private GameObject target;
	public GameObject radar;
	public Vector3 towardTarget;
	private float towardTargetNormal = 2.5f;
	private float towardTargetUrgent = 7.0f;

	void Start () {
		radar = GameObject.Find("radarCollider");
		target = radar.GetComponent<radarShotLogic>().target;
	}

	void Update ()
	{
		StartCoroutine ("followTarget");
	//	this.gameObject.transform.Rotate(Vector3.forward * Time.deltaTime * 100);
		this.gameObject.transform.Translate(towardTarget * Time.deltaTime );
	}

	IEnumerator followTarget() {
		if(target.gameObject != null) {
			if (target.gameObject.transform.position.x > this.transform.position.x) {
				towardTarget += new Vector3 (towardTargetNormal, 0, 0);
			} else {
				towardTarget += new Vector3 (-towardTargetNormal, 0, 0);
			}
			
			if (target.gameObject.transform.position.z > this.transform.position.z) {
				towardTarget += new Vector3 (0, 0, towardTargetNormal);
			} else {
				towardTarget += new Vector3 (0, 0, -towardTargetUrgent);
			}

		}
		else {
			Destroy(this.gameObject);
		}
		yield return new WaitForSeconds (.25f);
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
