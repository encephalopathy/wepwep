using UnityEngine;
using System.Collections;

public class spawnCubes : MonoBehaviour {


	public GameObject enemy;
	// Use this for initialization
	void Start () {

		spawnWall();
	}
	
	// Update is called once per frame
	void Update () {
		//spawnWall();

	}
	 
	void spawnWall() {
		for(int i = 1; i < 5 ; i++) {
				GameObject cube = Instantiate(enemy) as GameObject;//GameObject.CreatePrimitive(PrimitiveType.Cube);
				foreach (Transform child in cube.transform)
				{
					child.gameObject.SetActive(true);
				} 
				//SplineController _splineController = (SplineController)cube.GetComponent(typeof(SplineController));
				//_splineController.FollowSpline();
				cube.AddComponent<Rigidbody>();
				cube.transform.position = new Vector3(i, i, 0);
			    cube.renderer.material.color = new Color(Random.Range(0.0f,1.0f),Random.Range(0.0f,1.0f),Random.Range(0.0f,1.0f));
				Destroy(cube.gameObject,2.5f);
		}
	}



}
