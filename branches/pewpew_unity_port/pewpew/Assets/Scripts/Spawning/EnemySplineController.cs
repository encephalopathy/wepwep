using UnityEngine;
using System.Collections;
using System.Collections.Generic;

[AddComponentMenu("Splines/Spline Controller")]
[RequireComponent(typeof(SplineInterpolator))]

/// <summary>
/// Enemy spline controller.
/// Enemy Spline Controller holds all the spline roots, the splines which are used to animate our enemies, in an array
/// called Spawn Group.  Every Spline has its own color and can be manipulated in the editor screen.  There is a event handler you can subscrine to
/// called "OnSplineSwapped" if you want to listen to when a spline has swapped for the enemy that owns this spline controller.  This is useful for when we need an enemy to switch to a different
/// path based on in-game events.  We can switch to a different spline by grabbing this component and setting the "SplineToExecute: property to a
/// different number.  The "SplineToExcute" flag maps an index in the array so be careful not to set the SplineToExecute property to value that is not
/// contained within the length of the array.
/// </summary>
public class EnemySplineController : SplineController {
	/// <summary>
	/// The spawn group: A colection of splines that make up which enemy flights paths that this game object can switch to.
	/// </summary>
	public GameObject[] SpawnGroup;
	private bool _hasSwappedSpline;
	public SplineSwappedEventHandler OnSplineSwapped;
	public int SplineToExecute;
    private int oldSplineToExecute;

	/// <summary>
	/// Sets which spline to activate within the SpawnGroup, the default value for this is zero.
	/// </summary>
	/// <value>The spline to execute.</value>



	// Use this for initialization
	void Start () {
		OnStart();
	}
	
	// Update is called once per frame
	void Update ()
    {
        /*Debug.Log("EnemySplineController: activeInHierarchy is " + SpawnGroup[SplineToExecute].activeInHierarchy + " and activeSelf is " + SpawnGroup[SplineToExecute].activeSelf + " SplineToExecute is " + SplineToExecute);
        if (SpawnGroup[SplineToExecute].activeInHierarchy)
        {
            SpawnGroup[SplineToExecute].SetActive(false);
        }
        if (oldSplineToExecute != SplineToExecute)
        {
            SpawnGroup[oldSplineToExecute].SetActive(false);
            SpawnGroup[SplineToExecute].SetActive(true);
        }*/
        
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
			SplineRoot = SpawnGroup[SplineToExecute];
		}
	}

	protected override void OnStart() {
		mSplineInterp = GetComponent(typeof(SplineInterpolator)) as SplineInterpolator;

		if (SplineToExecute < SpawnGroup.Length) {
			SplineRoot = SpawnGroup[SplineToExecute];

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

	/// <summary>
	/// Disables the spline objects, we don't need them outside design-time.
	/// </summary>
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

/// <summary>
/// The Spline Swapped Event Handler is used to register functions that want to listen to when a spline has switched for this
/// EnemySplineController.
/// </summary>
public delegate void SplineSwappedEventHandler(EnemySplineController sender, int splineNumber);
