using UnityEngine;
using System.Collections;

public class DESTROY : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	void OnTriggerEnter(Collider other)
	{
		if(other.name != "EnemyTrain" && other.tag == "Enemy")Destroy(other.gameObject);
	}
}
