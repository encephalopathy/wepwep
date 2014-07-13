/**
 * STUFF DOWNLOADED FROM http://wiki.unity3d.com/index.php/Hermite_Spline_Controller
 * AUTHOR: Benoit FOULETIER (http://wiki.unity3d.com/index.php/User:Benblo)
 * MODIFIED BY F. Montorsi
 */

using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public enum eOrientationMode { NODE = 0, TANGENT }

[AddComponentMenu("Splines/Spline Controller")]
[RequireComponent(typeof(SplineInterpolator))]

public class SplineController : MonoBehaviour
{
	public GameObject SplineRoot;
	public float TimeBetweenAdjacentNodes = 10;
	public eOrientationMode OrientationMode = eOrientationMode.NODE;
	public eWrapMode WrapMode = eWrapMode.ONCE;
	public bool AutoStart = true;
	public bool AutoClose = true;
	public bool HideOnExecute = true;

	SplineInterpolator mSplineInterp;
	
	// for better performance we precompute the list of nodes and we re-use the
	// same SplineNode class used by SplineInterpolator (which is what does the real job);
	// however, we only fill in a small number of fields of each SplineNode;
	// in particular we copy here only the fields:
	//   - Point
	//   - Rot
	//   - BreakTime
	//   - Name
	SplineNode[] mSplineNodeInfo;
	
	
	// --------------------------------------------------------------------------------------------
	// UNITY CALLBACKS
	// --------------------------------------------------------------------------------------------

	void OnDrawGizmos()
	{
		//Debug.Log("drawing gizmos SplineController");
		SplineNode[] info = GetSplineNodes();
		if (info.Length < 2)
			return;

		SplineInterpolator interp = GetComponent(typeof(SplineInterpolator)) as SplineInterpolator;
		SetupSplineInterpolator(interp, info);
		interp.StartInterpolation(null, null, null, /* callbacks */
								  false /* no rotations */, WrapMode);

		Vector3 prevPos = info[0].Point;
		float endTime = GetDuration(info);
		
		Gizmos.color = Color.red;
		for (int c = 0; c <= 100; c++)
		{
			Vector3 currPos = interp.GetHermiteAtTime((float)c * endTime / 100.0f);
			
			/* USEFUL SANITY CHECK TO DO IN THE DEBUGGER*/
			if (float.IsNaN(currPos.x))
				Debug.Log("NaN while drawing gizmos!!!!"); // should never arrive here!
		
			//float mag = (currPos-prevPos).magnitude * 2;
			//Gizmos.color = new Color(mag, 0, 0, 1);
			Gizmos.DrawLine(prevPos, currPos);
			
			prevPos = currPos;
		}
	}

	void Start()
	{
		mSplineInterp = GetComponent(typeof(SplineInterpolator)) as SplineInterpolator;

		mSplineNodeInfo = GetSplineNodes();

		if (HideOnExecute)
			DisableNodeObjects();

		if (AutoStart)
			FollowSpline();
	}
	
	
	
	// --------------------------------------------------------------------------------------------
	// PUBLIC METHODS
	// --------------------------------------------------------------------------------------------
	
	/// <summary>
	/// Disables the spline objects, we don't need them outside design-time.
	/// </summary>
	public void DisableNodeObjects()
	{
		if (SplineRoot != null)
		{
			//SplineRoot.SetActiveRecursively(false);		// deprecated in Unity 4
			SplineRoot.SetActive(false);
		}
	}


	/// <summary>
	/// Starts the interpolation
	/// </summary>
	public void FollowSpline()
	{
		if (mSplineNodeInfo.Length > 0)
		{
			SetupSplineInterpolator(mSplineInterp, mSplineNodeInfo);
			mSplineInterp.StartInterpolation(null, null, null, true, WrapMode);
		}
	}

	/// <summary>
	/// Starts the interpolation
	/// </summary>
	public void FollowSpline(OnPathEndCallback endCallback, 
							 OnNodeArrivalCallback nodeCallback1, OnNodeLeavingCallback nodeCallback2)
	{
		if (mSplineNodeInfo.Length > 0)
		{
			SetupSplineInterpolator(mSplineInterp, mSplineNodeInfo);
			mSplineInterp.StartInterpolation(endCallback, nodeCallback1, nodeCallback2, true, WrapMode);
		}
	}
	
	
	// --------------------------------------------------------------------------------------------
	// PRIVATE HELPERS
	// --------------------------------------------------------------------------------------------
	
	float GetDuration(SplineNode[] info)
	{
		float endTime = -TimeBetweenAdjacentNodes;
		foreach (SplineNode e in info)
			endTime += TimeBetweenAdjacentNodes + e.BreakTime;
		
		return endTime;
	}
	
	void SetupSplineInterpolator(SplineInterpolator interp, SplineNode[] ninfo)
	{
		interp.Reset();
		
		float currTime = 0;
		for (uint c = 0; c < ninfo.Length; c++)
		{
			if (OrientationMode == eOrientationMode.NODE)
			{
				interp.AddPoint(ninfo[c].Name, ninfo[c].Point, 
								ninfo[c].Rot, 
								currTime, ninfo[c].BreakTime, 
								new Vector2(0, 1));
			}
			else if (OrientationMode == eOrientationMode.TANGENT)
			{
				Quaternion rot;
				Vector3 up = ninfo[c].Rot * Vector3.up;
				
				if (c != ninfo.Length - 1)		// is c the last point?
					rot = Quaternion.LookRotation(ninfo[c+1].Point - ninfo[c].Point, up);	// no, we can use c+1
				else if (AutoClose)
					rot = Quaternion.LookRotation(ninfo[0].Point - ninfo[c].Point, up);
				else
					rot = ninfo[c].Rot;

				interp.AddPoint(ninfo[c].Name, ninfo[c].Point, rot, 
								currTime, ninfo[c].BreakTime, 
								new Vector2(0, 1));
			}
			
			// when ninfo[i].StopHereForSecs == 0, then each node of the spline is reached at
			// Time.time == timePerNode * c (so that last node is reached when Time.time == TimeBetweenAdjacentNodes).
			// However, when ninfo[i].StopHereForSecs > 0, then the arrival time of node (i+1)-th needs
			// to account for the stop time of node i-th
			currTime += TimeBetweenAdjacentNodes + ninfo[c].BreakTime;
		}

		if (AutoClose)
			interp.SetAutoCloseMode(currTime);
	}

	/// <summary>
	/// Returns children transforms, sorted by name.
	/// </summary>
	SplineNode[] GetSplineNodes()
	{
		if (SplineRoot == null)
			return null;
		
		List<Component> components = 
			new List<Component>(SplineRoot.GetComponentsInChildren(typeof(Transform)));
		
		List<Transform> transforms = components.ConvertAll(c => (Transform)c);

		transforms.Remove(SplineRoot.transform);
		transforms.Sort(delegate(Transform a, Transform b)
		{
			return a.name.CompareTo(b.name);
		});
		
		
		// F. Montorsi modification: look for SplineNodeProperties objects
		// attached to the spline nodes found so far...
		List<SplineNode> info = new List<SplineNode>();
		foreach (Transform element in transforms)
    	{
			SplineNodeProperties p = element.GetComponent<SplineNodeProperties>();
			if (p != null)
				info.Add(new SplineNode(p.Name, element.transform, p.BreakTime));
			else
				info.Add(new SplineNode("", element.transform, 0));
		}

		return info.ToArray();
	}
}