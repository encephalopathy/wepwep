using UnityEngine;
using System.Collections;

public class MoveForward : MonoBehaviour
{
	public float speed = 1.0f;
	public GameObject ship;

	// Update is called once per frame
	void Update ()
	{
		if(ship)transform.position += transform.forward*speed*Time.deltaTime;
	}
}
