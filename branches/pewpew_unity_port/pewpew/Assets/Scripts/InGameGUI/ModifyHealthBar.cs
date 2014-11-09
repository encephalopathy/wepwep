using UnityEngine;
using System.Collections;

public class ModifyHealthBar : MonoBehaviour {

	public GameObject target;

	public void GetHit (int adj) {
		HealthBar PlayerHealthBar = (HealthBar)target.GetComponent("HealthBar");
		PlayerHealthBar.AdjustCurrentHealth(adj);
	} 
}
