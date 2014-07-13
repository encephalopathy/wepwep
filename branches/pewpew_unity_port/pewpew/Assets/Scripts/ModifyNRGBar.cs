using UnityEngine;
using System.Collections;

public class ModifyNRGBar : MonoBehaviour {

	public GameObject target;
	
	public void useNRG (int adj) {
		NRGBar PlayerNRGBar = (NRGBar)target.GetComponent("NRGbar");
		PlayerNRGBar.AdjustCurrentNRG(adj);
	} 
}
