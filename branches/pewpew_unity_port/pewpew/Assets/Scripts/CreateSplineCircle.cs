using UnityEngine;
using System.Collections;
using System.Collections.Generic;
/// <summary>
/// Creates a circle from the existing set of nodes on a spline interpolator, the nodes can be anywhere but the centroid of the 
/// circle is calculated based on the average distance from each node.
///</summary>
public class CreateSplineCircle : MonoBehaviour {

	//How long the circle should be in the x-axis.
	public float yRadius = 0f;

	//How long the circle should be in the z-axis.
	public float xRadius = 0f;

	//The root of the spline interpolator I want to modify.
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
		if (numberOfNodes <= 1) return;
		foreach (Transform element in transforms)
		{
			midpoint += element.position;
		}
	
		midpoint = midpoint / numberOfNodes;

		int i = 0;
		foreach (Transform element in transforms)
		{
			element.position = new Vector3(midpoint.x + xRadius * Mathf.Cos((i * (2* Mathf.PI)) / numberOfNodes), midpoint.y, midpoint.z + yRadius * Mathf.Sin((i *2 * Mathf.PI) / numberOfNodes));
			++i;
		}

		transforms[numberOfNodes - 1].position = transforms[0].position;
	}
}
