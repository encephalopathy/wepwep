using UnityEngine;
using System.Collections;

public class ModifyBossHealthBar : MonoBehaviour {

	public GameObject target;

	public void GetHit (int adj) {
		BossHealthBar BossHealthbar = (BossHealthBar)target.GetComponent("BossHealthBar");
		BossHealthbar.AdjustCurrentBossHealth(adj);
        Debug.Log("modifybosshealthbar: adjusting health by "+adj);
	} 
}
