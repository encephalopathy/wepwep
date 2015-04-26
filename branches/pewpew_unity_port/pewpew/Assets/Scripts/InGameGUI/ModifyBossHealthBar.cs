using UnityEngine;
using System.Collections;

public class ModifyBossHealthBar : MonoBehaviour {

	public GameObject Boss;

	public void GetHit (int adj) {
		BossHealthBar BossHealthbar = (BossHealthBar)Boss.GetComponent("BossHealthBar");
		BossHealthbar.AdjustCurrentBossHealth(adj);
        //Debug.Log("modifybosshealthbar: adjusting health by "+adj);
	} 
}
