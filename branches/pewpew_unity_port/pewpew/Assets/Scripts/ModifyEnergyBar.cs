using UnityEngine;
using System.Collections;

public class ModifyEnergyBar : MonoBehaviour {

	public GameObject target;

	public void GetHit (float adj) {
		Energybar PlayerEnergyBar = (Energybar)target.GetComponent("Energybar");
		PlayerEnergyBar.AdjustCurrentEnergy(adj);
	} 

	public void Set (float adj) {
		Energybar PlayerEnergyBar = (Energybar)target.GetComponent("Energybar");
		PlayerEnergyBar.SetCurrentEnergy(adj);
	}
}
