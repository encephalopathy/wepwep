using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class CreateSplineCircle : MonoBehaviour {
	
	public float yRadius = 0f;
	public float xRadius = 0f;

	public GameObject SplineRoot;

	private bool applied = false;
	
	// Use this for initialization
	void Start () {
	}



	void OnDrawGizmos() {
		if (SplineRoot != null) {
			if (!applied) {
				CreateCircle();
				applied = true;
			}
		}
	}

	// Update is called once per frame
	void Update () {
	}


	void OnAwake() {

	}

	protected void CreateCircle()
	{
		
		List<Component> components = 
			new List<Component>(SplineRoot.GetComponentsInChildren(typeof(Transform)));
		
		List<Transform> transforms = components.ConvertAll(c => (Transform)c);
		
		transforms.Remove(SplineRoot.transform);
		transforms.Sort(delegate(Transform a, Transform b)
		                {
			return a.name.CompareTo(b.name);
		});

		Vector3 midpoint = Vector3.zero;
		int numberOfNodes = transforms.Count;
		foreach (Transform element in transforms)
		{
			midpoint += element.position;
		}
	
		midpoint = midpoint / numberOfNodes;
		Debug.Log("Midpoint: " + midpoint);
		int i = 0;
		foreach (Transform element in transforms)
		{
			element.position = new Vector3(midpoint.x + xRadius * Mathf.Cos((i * (2* Mathf.PI)) / numberOfNodes), midpoint.y, midpoint.z + yRadius * Mathf.Sin((i *2 * Mathf.PI) / numberOfNodes));
			++i;
		}
	}
}
