using UnityEngine;
using System.Collections;

public class EnergyRegen : MonoBehaviour {

    private PlayerLogic playerEnergy;
    [SerializeField] private GameObject Player;
    [SerializeField] private int regenAmount = 1;
    [SerializeField] private float currentCooldownTime;
    [SerializeField] private float initialCooldownTime = 1;

    // Use this for initialization
    void Start()
    {
        currentCooldownTime = 0;
        playerEnergy = (PlayerLogic)Player.gameObject.GetComponent(typeof(PlayerLogic));
    }

	// Update is called once per frame
	void Update () {
        //Debug.Log("EnergyRegen, CurrentEnergy is " + playerEnergy.currentEnergy + ", MaxEnergy is " + playerEnergy.maxEnergy + ", currentCooldownTime is "+currentCooldownTime);

        if (playerEnergy.currentEnergy != playerEnergy.maxEnergy)
        {
            if (currentCooldownTime <= 0)
            {
                //Debug.Log("EnergyRegen, before currentEnergy change " + playerEnergy.currentEnergy);
                playerEnergy.currentEnergy += regenAmount;
                ModifyEnergyBar energyBar = (ModifyEnergyBar)GetComponent(typeof(ModifyEnergyBar));
                energyBar.GetHit(+regenAmount);
                //Debug.Log("EnergyRegen, after currentEnergy change " + playerEnergy.currentEnergy);
                currentCooldownTime = initialCooldownTime;
            }
            else
            {
                currentCooldownTime -= Time.deltaTime;
            }
        }
        else if (playerEnergy.currentEnergy == playerEnergy.maxEnergy)
        {
            currentCooldownTime = 0;
        }
	}
}
