using UnityEngine;
using System.Collections;

public class EnemyLogic : MonoBehaviour
{

    public GameObject explosion;
    public int health = 100;

    private bool alive = true;
	// Use this for initialization
	void Start () {
	
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
        health -= amount;
        if (health <= 0 && alive)
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
            PlayerLogic other = (PlayerLogic)theCollision.gameObject.GetComponent(typeof(PlayerLogic));
            other.doDamage(50);
            //Debug.Log("You crashed!");
        }

    }

}
