/**
 * STUFF DOWNLOADED FROM http://wiki.unity3d.com/index.php/Hermite_Spline_Controller
 * AUTHOR: F. Montorsi
 */

using UnityEngine;
using System.Collections;

public class SplineNodeProperties : MonoBehaviour
{
	// this is just a simple placeholder for properties of a spline node
	// (additional to those of the Transform object associated to it!)
	// these properties get copied by the SplineController into SplineNode structures
	// (along with other properties)
	
	public float BreakTime = 0f;
	public string Name;
}
