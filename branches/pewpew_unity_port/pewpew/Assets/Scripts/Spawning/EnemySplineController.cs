using UnityEngine;
using System.Collections;
using System.Collections.Generic;

[AddComponentMenu("Splines/Spline Controller")]
[RequireComponent(typeof(SplineInterpolator))]

public class EnemySplineController : SplineController {
	public GameObject[] SpawnGroup;
	public bool isSpawning = false;
	public int _splineToExecute = 0;
	public int SplineToExecute { 
		get {
			return _splineToExecute;
		} 
		set {
			if (value < SpawnGroup.Length) {
				SpawnGroup[_splineToExecute].SetActive(false);
				SpawnGroup[value].SetActive(true);
			}
			_splineToExecute = value;
		}
	}



	// Use this for initialization
	void Start () {
		OnStart();
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	protected override void DrawGoKitSplineController ()
	{
		List<SplineNode> splineNodes = new List<SplineNode>();
		for (int i = 0; i < SpawnGroup.Length; ++i) {
			ChangeGizmoColor(i);
			SplineRoot = SpawnGroup[i];
			base.DrawGoKitSplineController();
		}
		if (SpawnGroup.Length > 0) {
			SplineRoot = SpawnGroup[_splineToExecute];
		}
	}

	protected override void OnStart() {
		mSplineInterp = GetComponent(typeof(SplineInterpolator)) as SplineInterpolator;

		if (SplineToExecute < SpawnGroup.Length) {
			SplineRoot = SpawnGroup[_splineToExecute];

			mSplineNodeInfo = GetSplineNodes();
		}
		
		if (HideOnExecute)
			DisableNodeObjects();

		if (AutoStart)
			FollowSpline();
	}

	public override void FollowSpline (OnPathEndCallback endCallback, OnNodeArrivalCallback nodeCallback1, OnNodeLeavingCallback nodeCallback2)
	{
		base.FollowSpline (endCallback, nodeCallback1, nodeCallback2);
	}

	public override void DisableNodeObjects ()
	{
		for (int i = 0; i < SpawnGroup.Length; ++i) {
			if (SpawnGroup[i] != null) {
				SpawnGroup[i].SetActive(false);
			}
		}
	}

	private void ChangeGizmoColor(int i) {
		switch (i) {
			case 0:
				Gizmos.color = Color.red;
				break;
			case 1:
				Gizmos.color = Color.green;
				break;
			case 2:
				//Orange.
				Gizmos.color = new Color(255, 155, 0);
			break;
			default:
				Color newColor = Gizmos.color;
				if (i % 2 == 0) {
					newColor.r += 50f;
				}
				else if (i % 3 == 0) {
					newColor.g += 50f;
				}
				else if (Gizmos.color.b % 5 == 0) {
					newColor.b += 50f;
				}
				Gizmos.color = newColor;
			break;
		}
	}

}
