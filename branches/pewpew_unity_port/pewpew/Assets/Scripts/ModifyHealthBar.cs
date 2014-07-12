using UnityEngine;
using System.Collections;

public class ModifyHealthBar : MonoBehaviour {

	public GameObject target;

	public void GetHit (int adj) {
		Healthbar PlayerHealthBar = (Healthbar)target.GetComponent("Healthbar");
		PlayerHealthBar.AdjustCurrentHealth(adj);
	} 
}
