using UnityEngine;
using System.Collections;

public class EnemyLogic : MonoBehaviour
{

    [Tooltip("Use one of the Detonator prefabs, default is Detonator-Sounds")]
    public GameObject explosion;
    [Tooltip("Health is generally low (ie: small enemies usually have 1 HP to die in 1 hit).")]
    public int MaxHealth = 1;
    [Tooltip("Leave this alone, it'll get set automatically upon Game Start.")]
    public int CurrentHealth = 0;
    [Tooltip("If the enemy needs to drop a pickup, enable this and attach the Item Drop Logic script.")]
    [SerializeField] private bool itemDroppable = false;
    private bool alive = true;
    [Tooltip("Enabled if the enemy should die when the player runs into them.")]
    [SerializeField] private bool dieUponCollision = true;
    private bool hasSpawned = false;

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
                player.doDamage(player.currentHealth);
            }
            //Debug.Log("You crashed!");
        }
        else if (theCollision.gameObject.tag == "Destroy" && this.gameObject.tag == "Enemy")
        {
            if (!hasSpawned)
            {
				//Debug.Log ("HAS SPWANED ENEMY");
                hasSpawned = true;
            }
            else
            {
				//Debug.Log("ENEMY DESTROYED");
                Destroy(this.gameObject);
            }
        }

    }

}
