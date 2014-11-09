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
    [SerializeField] private float enemyFireRate = 2;
    private float aEnemyFireRate;

    void start()
    {
        aEnemyFireRate = enemyFireRate;
    }

	void Update ()
	{
        if (transform.parent.tag == "Player")
        {
            if (Input.GetButtonDown("Fire1"))
            {
                StartCoroutine("fire");
                pew.Play(0);
            }
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss")
        {
            aEnemyFireRate -= Time.deltaTime;
            if (aEnemyFireRate <= 0)
            {
                StartCoroutine("fire");
                aEnemyFireRate = enemyFireRate;
            }
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
