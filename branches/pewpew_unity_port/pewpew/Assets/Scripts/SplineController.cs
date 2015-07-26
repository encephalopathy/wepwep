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

	private float mTotalSegmentSpeed;
	protected Color currentColor;

	//Used to determine how fast or how slow we should be moving.  Default value to -1 means we move at whatever.
	public float Speed;


	protected SplineInterpolator mSplineInterp;
	
	// for better performance we precompute the list of nodes and we re-use the
	// same SplineNode class used by SplineInterpolator (which is what does the real job);
	// however, we only fill in a small number of fields of each SplineNode;
	// in particular we copy here only the fields:
	//   - Point
	//   - Rot
	//   - BreakTime
	//   - Name
	protected SplineNode[] mSplineNodeInfo;
	
	
	// --------------------------------------------------------------------------------------------
	// UNITY CALLBACKS
	// --------------------------------------------------------------------------------------------

	void OnDrawGizmos()
	{
		currentColor = Color.red;
		Gizmos.color = currentColor;
		DrawGoKitSplineController();
	}

	protected virtual void DrawGoKitSplineController() {
		SplineNode[] info = GetSplineNodes();
		if (info == null || info.Length < 2)
			return;
		
		SplineInterpolator interp = GetComponent(typeof(SplineInterpolator)) as SplineInterpolator;
		SetupSplineInterpolator(interp, info);
		interp.StartInterpolation(null, null, null, /* callbacks */
		                          false /* no rotations */, WrapMode);
		
		Vector3 prevPos = info[0].Point;
		float endTime = GetDuration(info);
		

		for (int c = 0; c <= 100; c++)
		{
			Vector3 currPos = interp.GetHermiteAtTime((float)c * endTime / 100.0f);
			
			/* USEFUL SANITY CHECK TO DO IN THE DEBUGGER*/
			if (float.IsNaN(currPos.x))
				//Debug.Log("NaN while drawing gizmos!!!!"); // should never arrive here!
			
			//float mag = (currPos-prevPos).magnitude * 2;
			Gizmos.color = currentColor;
			Gizmos.DrawLine(prevPos, currPos);

			
			prevPos = currPos;
		}
	}

	void Start()
	{
		OnStart();
	}

	protected virtual void OnStart() {
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
	public virtual void DisableNodeObjects()
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
	public virtual void FollowSpline(OnPathEndCallback endCallback, 
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
		interp.Clear();
	
		float currTime = 0;

		List<SplineNode> nInfoAsList = new List<SplineNode>(ninfo);

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
			currTime += ninfo[c].BreakTime;

			if (Speed <= 0 || Application.isEditor) {
				currTime += TimeBetweenAdjacentNodes;
			}
		}

        //Debug.Log("SplineController, there are " + eOrientationMode.NODE + " nodes currently");
		
		//Normalizes the speed by adjusting which times our spline interpolator
		//needs to arrive at a particular node before they are added to the actual
		//interpolator.
		if (Speed > 0 && Application.isPlaying) {
			ConstructCurve(interp, ninfo);
		}
		

		if (AutoClose)
			interp.SetAutoCloseMode(currTime);
	}

	/// <summary>
	/// Returns children transforms, sorted by name.
	/// </summary>
	protected SplineNode[] GetSplineNodes()
	{
		if (SplineRoot == null) {
			//Debug.Log("Spline root is null");
			return null;
		}
		
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
				info.Add(new SplineNode(element.gameObject.name, element.transform, 0));
		}
		//Debug.Log("Spline nodes created");
		//for (int i = 0; i < info.Count; ++i) {
			//Debug.Log("Spline Node: " + info[i].GetLeaveTime());
		//}
		return info.ToArray();
	}

	protected void ConstructCurve(SplineInterpolator interp, SplineNode[] nInfo) {
		if (Speed <= 0 && nInfo.Length < 3) return;
		float totalLength = 0;
		float[] curveLengths = new float[nInfo.Length];
		float[] nodeArrivalTimes = new float[nInfo.Length];
		float currTime = 0;
		uint c = 1;
		bool pathEnded = false;
        //Debug.Log("SplineController: nInfo.Length is " + nInfo.Length);

		//Cache the tag so we can reset it after we have calculated how fast the object should move.
		string actualTag = gameObject.tag;

		//Preserve the original position so that the object doesn't get deleted due to the simulation.
		Vector3 originalPosition = gameObject.transform.position;

		gameObject.tag = "Simulation";
		//Swap splines just in case we use mSplineInterp elsewhere.
		interp.StartInterpolation(
		
		//On Path End.
		() => {
			//Debug.Log("On Path Ended");
			pathEnded = true;
			
		},
		//On Node Arrival.
		(int idxArrival, SplineNode nodeArrival) => {
			curveLengths[c] = mTotalSegmentSpeed;
            //Debug.Log("SplineController: mTotalSegmentSpeed is " + mTotalSegmentSpeed);
			totalLength += mTotalSegmentSpeed;
			mTotalSegmentSpeed = 0;
			++c;
		},
		//On Node Callback
		(int idxLeavingSpline, SplineNode OnNodeArrivalCallback) => {
			//Debug.Log("On Node callback: " + idxLeavingSpline);
		
		}, false, eWrapMode.ONCE);

		//Starts the Simulation.
		float deltaTime = 0.00005f;
		float currentTime = 0f;
		while (!pathEnded) {
			interp.Update(currentTime);
			Vector3 currentVelocity = mSplineInterp.velocity;
			float currentSpeed = currentVelocity.magnitude;
			mTotalSegmentSpeed += currentSpeed;
			currentTime += deltaTime;
		}
        //Debug.Log("SplineController: totalLength is " + totalLength);
		interp.Clear();

		gameObject.transform.position = originalPosition;
		//From that, evaluate how much distance between each node makes up the curve and scale that time to be the break time.
		float totalTime = GetDuration(nInfo);
        //Debug.Log("SplineController: totalTime is " + totalTime);

		float averageSpeed = totalLength / totalTime;

		float timeToEnd = 0;
		float speedMultiplier = 0;
		for (int i = 0; i < curveLengths.Length; i++)
		{
			float hermiteLengthToEvaluate = curveLengths[i];
            //Debug.Log("SplineController: hermiteLengthToEvaluate is " + hermiteLengthToEvaluate);
			if (hermiteLengthToEvaluate > 0) {
				speedMultiplier = (hermiteLengthToEvaluate / totalLength) * (1 / Speed);
				timeToEnd = totalTime * speedMultiplier;
                //Debug.Log("SplineController: timeToEnd is " + timeToEnd);
			}

			interp.AddPoint(nInfo[i].Name, nInfo[i].Point, 
			                nInfo[i].Rot, 
			                timeToEnd + currTime, 0, 
			                new Vector2(0, 1));
			currTime += timeToEnd;
		}
		gameObject.tag = actualTag;
	}
}