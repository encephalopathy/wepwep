using UnityEngine;
using System.Collections;

public class BossPartLogic : MonoBehaviour
{

    public GameObject explosion;
    public int health = 100;
    public GameObject boss;
    public int damageModifier = 2;

    private bool alive = true;
	// Use this for initialization
	void Start ()
    {

	}
	
	// Update is called once per frame
	void Update ()
    {
	
	}

    public void Die()
    {
        Instantiate(explosion, transform.position, transform.rotation);
        Destroy(this.gameObject);
    }

    public void doDamage(int amount)
    {
        health -= amount;
        amount *= damageModifier;
        //boss.GetComponent<EnemyLogic>().doDamage(amount);
        BossLogic enemylogic = (BossLogic)boss.gameObject.GetComponent(typeof(BossLogic));
        enemylogic.doDamage(amount);
        ModifyBossHealthBar bossHealthBar = (ModifyBossHealthBar) boss.gameObject.GetComponent(typeof(ModifyBossHealthBar));
        bossHealthBar.GetHit(amount);
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
            //Die();
            EnemyLogic other = (EnemyLogic)theCollision.gameObject.GetComponent(typeof(EnemyLogic));
            other.doDamage(50);
            //Debug.Log("You crashed!");
        }

    }

}
