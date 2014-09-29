using UnityEngine;
using System.Collections;

public class ModifyEnergyBar : MonoBehaviour {

	public GameObject target;

	public void GetHit (float adj) {
		EnergyBar PlayerEnergyBar = (EnergyBar)target.GetComponent("EnergyBar");
		PlayerEnergyBar.AdjustCurrentEnergy(adj);
	} 

	public void Set (float adj) {
		EnergyBar PlayerEnergyBar = (EnergyBar)target.GetComponent("EnergyBar");
		PlayerEnergyBar.SetCurrentEnergy(adj);
	}
}
