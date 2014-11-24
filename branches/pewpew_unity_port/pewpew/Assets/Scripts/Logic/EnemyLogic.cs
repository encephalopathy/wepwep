using UnityEngine;
using System.Collections;

public class EnemyLogic : MonoBehaviour
{

    public GameObject explosion;
    public int MaxHealth = 100;
    public int CurrentHealth;

    private bool alive = true;
	// Use this for initialization
	void Start () {
        //CurrentHealth = MaxHealth;
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    public void Die()
    {
        Instantiate(explosion, transform.position, transform.rotation);
        Destroy(this.gameObject);
    }

    public void doDamage(int amount)
    {
        //Debug.Log("EnemyLogic: CurrentHealth before damage is "+CurrentHealth);
        CurrentHealth -= amount;
        //Debug.Log("EnemyLogic: CurrentHealth after damage is "+CurrentHealth);
        if (CurrentHealth <= 0 && alive)
        {
            Die();
            alive = false;
        }
    }

    //Basic collision detection checking for two differently named objects
    void OnTriggerEnter(Collider theCollision)
    {
        //Debug.Log("An enemy got hit");
        
        if (theCollision.gameObject.name == "Ship")
        {
            Die();
            EnemyLogic other = (EnemyLogic)theCollision.gameObject.GetComponent(typeof(EnemyLogic));
            other.doDamage(50);
            //Debug.Log("You crashed!");
        }

    }

}
