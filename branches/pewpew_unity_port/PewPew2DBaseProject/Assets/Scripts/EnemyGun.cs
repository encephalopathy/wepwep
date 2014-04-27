using UnityEngine;
using System.Collections;

public class EnemyGun : MonoBehaviour
{
	private GameObject bullet = PrefabUtility.CreatePrefab("Assets/normalBullet.prefab", (GameObject)Selection.object, ReplacePrefabOptions.ReplaceNameBased);

	public float velocity = -10.0f;
    public float fireRate = 2;
    private float aFireRate;


		// Use this for initialization
		void Start ()
		{
            aFireRate = fireRate;
		}
	
		// Update is called once per frame
		void Update ()
		{
		    aFireRate -= Time.deltaTime;
			if (aFireRate <= 0 ) {
                GameObject newBullet = Instantiate(bullet, transform.position, transform.rotation) as GameObject;
				newBullet.name = "EnemyBullet";
				newBullet.rigidbody.AddForce(transform.forward*velocity,ForceMode.VelocityChange);
                Destroy(newBullet.gameObject, 3f);
			    aFireRate = fireRate;

			}
		}



}

