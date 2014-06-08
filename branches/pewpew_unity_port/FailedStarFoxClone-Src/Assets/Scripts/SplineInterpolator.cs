/**
 * STUFF DOWNLOADED FROM http://wiki.unity3d.com/index.php/Hermite_Spline_Controller
 * AUTHOR: Benoit FOULETIER (http://wiki.unity3d.com/index.php/User:Benblo)
 * MODIFIED BY F. Montorsi
 */

using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class SplineNode
{
	internal string Name;
	internal Vector3 Point;
	internal Quaternion Rot;
	internal float ArrivalTime;
	internal float BreakTime;
	internal Vector2 EaseIO;

	internal SplineNode(string n, Vector3 p, Quaternion q, float tArrival, float tBreak, Vector2 io) 
		{ Name = n; Point = p; Rot = q; ArrivalTime = tArrival; BreakTime = tBreak; EaseIO = io; }
	
	internal SplineNode(SplineNode o) 
		{ Name = o.Name; Point = o.Point; Rot = o.Rot; 
		  ArrivalTime = o.ArrivalTime; BreakTime = o.BreakTime; 
		  EaseIO = o.EaseIO; }
	
	// this is the constructor used by SplineController:
	
	internal SplineNode(string n, Transform t, float tBreak) 
		{ Name = n; Point = t.position; Rot = t.rotation; BreakTime = tBreak; }
	
	
	public float GetLeaveTime()
		{ return ArrivalTime + BreakTime; }
}

public enum eEndPointsMode { AUTO, AUTOCLOSED, EXPLICIT }
public enum eWrapMode { ONCE, LOOP }
public delegate void OnPathEndCallback();
public delegate void OnNodeArrivalCallback(int idxArrival, SplineNode nodeArrival);
public delegate void OnNodeLeavingCallback(int idxLeaving, SplineNode nodeLeaving);

public class SplineInterpolator : MonoBehaviour
{
	List<SplineNode> mNodes = new List<SplineNode>();
	
	eEndPointsMode mEndPointsMode = eEndPointsMode.AUTO;
	string mState = "";			// can be "Reset", "Stopped", "Once" or "Loop"
	bool mRotations;
	
	float mCurrentTime;
	int mCurrentIdx = 1;
	
	OnPathEndCallback mOnPathEndCallback;
	OnNodeArrivalCallback mOnNodeArrivalCallback;
	OnNodeLeavingCallback mOnNodeLeavingCallback;
	int mLastNodeCallback = 0;

	
	// --------------------------------------------------------------------------------------------
	// UNITY CALLBACKS
	// --------------------------------------------------------------------------------------------

	void Awake()
	{
		Reset();
	}
	
	void Update()
	{
		if (mState == "Reset" || mState == "Stopped" || mNodes.Count < 4)
			return;

		mCurrentTime += Time.deltaTime;

		if (mCurrentTime >= mNodes[mCurrentIdx + 1].ArrivalTime)
		{			
			// advance to next point in the path
			
			if (mCurrentIdx < mNodes.Count - 3)
			{
				mCurrentIdx++;
				
				// Inform that we have just arrived to the mCurrentIdx -th node!
				if (mOnNodeArrivalCallback != null)
					mOnNodeArrivalCallback(mCurrentIdx, mNodes[mCurrentIdx]);
			}
			else
			{
				if (mState != "Loop")
				{
					mState = "Stopped";

					// We stop right in the end point
					transform.position = mNodes[mNodes.Count - 2].Point;

					if (mRotations)
						transform.rotation = mNodes[mNodes.Count - 2].Rot;

					// We call back to inform that we are ended
					if (mOnNodeArrivalCallback != null)
						mOnNodeArrivalCallback(mCurrentIdx+1, mNodes[mCurrentIdx+1]);
					if (mOnPathEndCallback != null)
						mOnPathEndCallback();
				}
				else
				{
					mCurrentIdx = 1;
					mCurrentTime = 0;
				}
			}
		}

		if (mState != "Stopped")
		{
			if (mCurrentTime >= mNodes[mCurrentIdx].GetLeaveTime())
			{	
				if (mLastNodeCallback < mCurrentIdx && mOnNodeLeavingCallback != null)
				{
					// Inform that we have just left the mCurrentIdx-th node!
					mOnNodeLeavingCallback(mCurrentIdx, mNodes[mCurrentIdx]);
					mLastNodeCallback++;
				}
				//else: callback has already been called
				
				// Calculates the t param between 0 and 1
				float param = GetNormalizedTime(mCurrentIdx, mCurrentTime, mCurrentIdx+1);
	
				// Smooth the param
				param = MathUtils.Ease(param, mNodes[mCurrentIdx].EaseIO.x, mNodes[mCurrentIdx].EaseIO.y);
				
				// Move attached transform
				transform.position = GetHermiteInternal(mCurrentIdx, param);
				
				/*
				// simulate human walking (FIXME)
				Vector3 tmp = new Vector3(transform.position.x, transform.position.y, transform.position.z);
				tmp.y += 0.7f * Mathf.Sin (7*mCurrentTime);
				transform.position = tmp;*/
	
				if (mRotations)
				{
					// Rotate attached transform
					transform.rotation = GetSquad(mCurrentIdx, param);
				}
			}
			// else: we are in the "stop time" for the mCurrentIdx-th node
		}
	}
	
	
	// --------------------------------------------------------------------------------------------
	// PUBLIC MEMBERS
	// --------------------------------------------------------------------------------------------
	
	public void StartInterpolation(OnPathEndCallback endCallback, 
								   OnNodeArrivalCallback nodeArrival, 
								   OnNodeLeavingCallback nodeCallback, 
								   bool bRotations, eWrapMode mode)
	{
		if (mState != "Reset")
			throw new System.Exception("First reset, add points and then call here");

		mState = mode == eWrapMode.ONCE ? "Once" : "Loop";
		mRotations = bRotations;
		mOnPathEndCallback = endCallback;
		mOnNodeArrivalCallback = nodeArrival;
		mOnNodeLeavingCallback = nodeCallback;

		SetInput();
	}

	public void Reset()
	{
		mNodes.Clear();
		mState = "Reset";
		mCurrentIdx = 1;
		mCurrentTime = 0;
		mRotations = false;
		mEndPointsMode = eEndPointsMode.AUTO;
	}

	public void AddPoint(string name, Vector3 pos, Quaternion quat, 
						 float timeInSeconds, float timeStop, 
						 Vector2 easeInOut)
	{
		if (mState != "Reset")
			throw new System.Exception("Cannot add points after start");

		mNodes.Add(new SplineNode(name, pos, quat, timeInSeconds, timeStop, easeInOut));
	}
	
	public void SetAutoCloseMode(float joiningPointTime)
	{
		if (mState != "Reset")
			throw new System.Exception("Cannot change mode after start");

		mEndPointsMode = eEndPointsMode.AUTOCLOSED;

		mNodes.Add(new SplineNode(mNodes[0] as SplineNode));
		mNodes[mNodes.Count - 1].ArrivalTime = joiningPointTime;

		Vector3 vInitDir = (mNodes[1].Point - mNodes[0].Point).normalized;
		Vector3 vEndDir = (mNodes[mNodes.Count - 2].Point - mNodes[mNodes.Count - 1].Point).normalized;
		float firstLength = (mNodes[1].Point - mNodes[0].Point).magnitude;
		float lastLength = (mNodes[mNodes.Count - 2].Point - mNodes[mNodes.Count - 1].Point).magnitude;

		SplineNode firstNode = new SplineNode(mNodes[0] as SplineNode);
		firstNode.Point = mNodes[0].Point + vEndDir * firstLength;

		SplineNode lastNode = new SplineNode(mNodes[mNodes.Count - 1] as SplineNode);
		lastNode.Point = mNodes[0].Point + vInitDir * lastLength;

		mNodes.Insert(0, firstNode);
		mNodes.Add(lastNode);
	}

	public Vector3 GetHermiteAtTime(float t)
	{
		// find the indices of the two nodes used for spline interpolation
		// at time t
		int c;
		for (c = 0; c < mNodes.Count - 1 /* - 1 because we look at c+1 */; c++)
		{
			if (mNodes[c].ArrivalTime <= t && 
					t <= mNodes[c+1].ArrivalTime)
				break;
		}
		
		// ensure c is in the correct range
		if (c == mNodes.Count - 1)
			return mNodes[c].Point;			

		float param = GetNormalizedTime(c, t, c+1);		// c+1 is safe here thanks to prev check
		param = MathUtils.Ease(param, mNodes[c].EaseIO.x, mNodes[c].EaseIO.y);

		return GetHermiteInternal(c, param);
	}
	
	
	
	
	// --------------------------------------------------------------------------------------------
	// PRIVATE MEMBERS
	// --------------------------------------------------------------------------------------------
	
	void SetInput()
	{
		if (mNodes.Count < 2)
			throw new System.Exception("Invalid number of points");

		if (mRotations)
		{
			for (int c = 1; c < mNodes.Count; c++)
			{
				SplineNode node = mNodes[c];
				SplineNode prevNode = mNodes[c - 1];

				// Always interpolate using the shortest path -> Selective negation
				if (Quaternion.Dot(node.Rot, prevNode.Rot) < 0)
				{
					node.Rot.x = -node.Rot.x;
					node.Rot.y = -node.Rot.y;
					node.Rot.z = -node.Rot.z;
					node.Rot.w = -node.Rot.w;
				}
			}
		}

		if (mEndPointsMode == eEndPointsMode.AUTO)
		{
			mNodes.Insert(0, mNodes[0]);
			mNodes.Add(mNodes[mNodes.Count - 1]);
		}
		else if (mEndPointsMode == eEndPointsMode.EXPLICIT && (mNodes.Count < 4))
			throw new System.Exception("Invalid number of points");
	}

	void SetExplicitMode()
	{
		if (mState != "Reset")
			throw new System.Exception("Cannot change mode after start");

		mEndPointsMode = eEndPointsMode.EXPLICIT;
	}
	
	float GetNormalizedTime(int idxPrev, float t, int idxNext)
	{
		//DebugUtils.Assert(idxNext - idxPrev == 1);
			// we take two params just for clariness, but idxNext must be idxPrev+1 always
		
		if (t > mNodes[idxPrev].ArrivalTime && 
			t < mNodes[idxPrev].GetLeaveTime())
			return 0;
		
		float ret = (t - mNodes[idxPrev].GetLeaveTime()) / 
						(mNodes[idxNext].ArrivalTime - mNodes[idxPrev].GetLeaveTime());
		//DebugUtils.Assert(ret >= 0 && ret <= 1);
		return ret;
	}

	Quaternion GetSquad(int idxFirstPoint, float t)
	{
		Quaternion Q0 = mNodes[idxFirstPoint - 1].Rot;
		Quaternion Q1 = mNodes[idxFirstPoint].Rot;
		Quaternion Q2 = mNodes[idxFirstPoint + 1].Rot;
		Quaternion Q3 = mNodes[idxFirstPoint + 2].Rot;

		Quaternion T1 = MathUtils.GetSquadIntermediate(Q0, Q1, Q2);
		Quaternion T2 = MathUtils.GetSquadIntermediate(Q1, Q2, Q3);

		return MathUtils.GetQuatSquad(t, Q1, Q2, T1, T2);
	}
	
	Vector3 GetHermiteInternal(int idxFirstPoint, float t)
	{
        //DebugUtils.Assert(idxFirstPoint > 0 && idxFirstPoint < mNodes.Count - 2);
			// the spline can be computed only from the second node up to the penultimate node!
		if (idxFirstPoint == 0)
			return mNodes[0].Point;
		else if (idxFirstPoint == mNodes.Count - 1 ||
				 idxFirstPoint == mNodes.Count - 2)
			return mNodes[idxFirstPoint].Point;
		else if (idxFirstPoint > 0 && idxFirstPoint < mNodes.Count - 2)
		{
			float t2 = t * t;
			float t3 = t2 * t;
	
			Vector3 P0 = mNodes[idxFirstPoint - 1].Point;		// take previous node
			Vector3 P1 = mNodes[idxFirstPoint].Point;
			Vector3 P2 = mNodes[idxFirstPoint + 1].Point;		// take following node
			Vector3 P3 = mNodes[idxFirstPoint + 2].Point;		// take the following of the following!!
	
			float tension = 0.5f;	// 0.5 equivale a catmull-rom
	
			Vector3 T1 = tension * (P2 - P0);
			Vector3 T2 = tension * (P3 - P1);
	
			float Blend1 = 2 * t3 - 3 * t2 + 1;
			float Blend2 = -2 * t3 + 3 * t2;
			float Blend3 = t3 - 2 * t2 + t;
			float Blend4 = t3 - t2;
	
			return Blend1 * P1 + Blend2 * P2 + Blend3 * T1 + Blend4 * T2;
		}
		
		throw new System.Exception("logic error");
		//return new Vector3();		// to avoid warnings
	}
}