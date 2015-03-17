using UnityEngine;
using System.Collections;

public class EnemyLogic : MonoBehaviour
{

    public GameObject explosion;
    public int MaxHealth = 1;
    public int CurrentHealth;
    [SerializeField] private bool itemDroppable = false;
    private bool alive = true;
    [SerializeField] private bool dieUponCollision = true;

	// Use this for initialization
	void Start () {
        CurrentHealth = MaxHealth;
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    public virtual void Die()
    {
        Instantiate(explosion, transform.position, transform.rotation);
        if (itemDroppable)
        {
            this.gameObject.GetComponent<ItemDropLogic>().SpawnItem();
        }
        //Debug.Log("EnemyLogic, enemy Die()");
        Destroy(this.gameObject);
        //this.gameObject.GetComponent<ItemDropLogic>().
    }

    public virtual void doDamage(int amount)
    {
        CurrentHealth -= amount;
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
        
        //if (theCollision.gameObject.name == "Ship")
        if (theCollision.gameObject.tag == "Player")
        {
            if (dieUponCollision)
            {
                Die();
                PlayerLogic player = (PlayerLogic)theCollision.gameObject.GetComponent(typeof(PlayerLogic));
                player.doDamage(50);
            }
            else
            {
                PlayerLogic player = (PlayerLogic)theCollision.gameObject.GetComponent(typeof(PlayerLogic));
                player.doDamage(1000000000);
            }
            //Debug.Log("You crashed!");
        }
        else if (theCollision.gameObject.tag == "Destroy")
        {
            Destroy(this.gameObject);
        }

    }

}
