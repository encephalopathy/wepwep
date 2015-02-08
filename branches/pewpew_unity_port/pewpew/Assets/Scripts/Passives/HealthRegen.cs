using UnityEngine;
using System.Collections;

public class HealthRegen : MonoBehaviour {

    private PlayerLogic playerHealth;
    [SerializeField] private GameObject Player;
    [SerializeField] private int regenAmount = 1;
    [SerializeField] private float currentCooldownTime;
    [SerializeField] private float initialCooldownTime = 1;

    // Use this for initialization
    void Start()
    {
        currentCooldownTime = 0;
        playerHealth = (PlayerLogic)Player.gameObject.GetComponent(typeof(PlayerLogic));
    }

	// Update is called once per frame
	void Update () {
        //Debug.Log("HealthRegen, CurrentHealth is " + playerHealth.currentHealth + ", MaxHealth is " + playerHealth.maxHealth + ", currentCooldownTime is "+currentCooldownTime);

        if (playerHealth.currentHealth != playerHealth.maxHealth)
        {
            if (currentCooldownTime <= 0)
            {
                //Debug.Log("HealthRegen, before currentHealth change " + playerHealth.currentHealth);
                playerHealth.currentHealth += regenAmount;
                ModifyHealthBar healthBar = (ModifyHealthBar)GetComponent(typeof(ModifyHealthBar));
                healthBar.GetHit(+regenAmount);
                //Debug.Log("HealthRegen, after currentHealth change " + playerHealth.currentHealth);
                currentCooldownTime = initialCooldownTime;
            }
            else
            {
                currentCooldownTime -= Time.deltaTime;
            }
        }
        else if (playerHealth.currentHealth == playerHealth.maxHealth)
        {
            currentCooldownTime = 0;
        }
	}
}
