using UnityEngine;
using System.Collections;

public class ShieldLogic : MonoBehaviour {

    public int currentShieldHealth;
    public int maxShieldHealth = 25;
    public bool alive;

	// Use this for initialization
	public virtual void Start ()
    {
        currentShieldHealth = maxShieldHealth;
        alive = true;
	}
	
	// Update is called once per frame
	public virtual void Update ()
    {
	    
	}

    public virtual void doDamage(int amount)
    {
        currentShieldHealth -= amount;
        if (currentShieldHealth <= 0 && alive)
        {
            alive = false;
            this.renderer.enabled = false;
            this.collider.enabled = false;
        }
    }


}
