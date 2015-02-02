using UnityEngine;
using System.Collections;

public class RegeneratingShield : ShieldLogic {

    [SerializeField] private float currentShieldCooldown;
    [SerializeField] private float initialShieldCooldown = 1;

    // Use this for initialization
    void start()
    {
        currentShieldCooldown = initialShieldCooldown;
    }

	// Update is called once per frame
	public override void Update ()
    {
        Debug.Log("passiveshield, alive is" + this.GetComponent<ShieldLogic>().alive + ", currentShieldHealth is " + this.GetComponent<ShieldLogic>().currentShieldHealth + ", maxShieldHealth is " + this.GetComponent<ShieldLogic>().maxShieldHealth);
        if (this.GetComponent<ShieldLogic>().alive == false)
        {
            if (currentShieldCooldown > 0)
            {
                currentShieldCooldown -= Time.deltaTime;
            }
            else
            {
                this.GetComponent<ShieldLogic>().currentShieldHealth = this.GetComponent<ShieldLogic>().maxShieldHealth;
                this.GetComponent<ShieldLogic>().alive = true;
                this.renderer.enabled = true;
                this.collider.enabled = true;
                currentShieldCooldown = initialShieldCooldown;
            }
        }
	}
}
