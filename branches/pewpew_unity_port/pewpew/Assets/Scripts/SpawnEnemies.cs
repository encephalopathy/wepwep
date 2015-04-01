using UnityEngine;
using System.Collections;

public class SpawnEnemies : MonoBehaviour
    {
    [Tooltip("The enemy game object that is contained in the wave.")] 
	public GameObject enemy;
	private bool spawned = false;
    
    [Tooltip("The time when the enemy spawns in seconds since the level starts.")]
    [SerializeField] private float spawnTime = 0;
    private GameObject enemyClone;
	// Use this for initialization
	void Start ()
    {
        enemyClone = Instantiate(enemy) as GameObject;
	}
	
	// Update is called once per frame
	void Update ()
    {
        if (spawnTime > 0.0)
        {
            spawnTime -= Time.deltaTime;
        }
        else
        {
            if (spawned)
            {

            }
            else
            {
                enemyClone.SetActive(true);
                spawned = false;
            }
        }
	}

    void Spawn()
    {
        GameObject cube = Instantiate(enemy) as GameObject;//GameObject.CreatePrimitive(PrimitiveType.Cube);
        cube.SetActive(true);
        //cube.transform.position = new Vector3(0, 0, 0);
        /*foreach (Transform child in cube.transform)
        {
            child.gameObject.SetActive(true);
        }*/
        //cube.transform.position = this.transform.position;
        //SplineController _splineController = (SplineController)cube.GetComponent(typeof(SplineController));
        //_splineController.FollowSpline();
    }

	void OnTriggerEnter(Collider other)
	{
		
		if (other.gameObject.name == "Spawner")
		{
			if(!spawned)Spawn();
			spawned = true;
			Destroy(this.gameObject);
		}
	}

}
