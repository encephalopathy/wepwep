using UnityEngine;
using System.Collections;

public class SpawnEnemies : MonoBehaviour {
	public GameObject enemy;
	private bool spawned = false;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void Spawn() {
			GameObject cube = Instantiate(enemy) as GameObject;//GameObject.CreatePrimitive(PrimitiveType.Cube);
			foreach (Transform child in cube.transform)
			{
				child.gameObject.SetActive(true);
			} 
			//cube.transform.position = this.transform.position;
            cube.transform.position = new Vector3(0, 0, 0);
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
