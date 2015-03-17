using UnityEngine;
using System.Collections;

public class PlayerBombHelper : MonoBehaviour
{
    //[SerializeField] private int bulletVelocity = 10;

    [SerializeField] private int damage = 10;
    private bool hasCollided = false;
    private float damageCooldown = 0.25f;

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update ()
	{
        /*if (hasCollided == true)
        {

            damageCooldown -= Time.deltaTime;
            if (damageCooldown <= 0)
            {
                damageCooldown = 0.25f;
                hasCollided = false;
            }
        }*/
	   	//this.gameObject.transform.Translate(Vector3.forward * bulletVelocity * Time.deltaTime);
	}


    //Basic collision detection checking for two differently named objects
    /*void OnCollisionEnter(Collision theCollision)
    {
        //xDebug.Log("playerBombHelper, on collision enter with " + theCollision);
        if (theCollision.gameObject.tag == "EnemyBullet")
        {
            
        }
        else 
        {
            //Destroy(this);
        }
    }*/

    void OnTriggerEnter(Collider other)
    {
        //Destroy(this.gameObject);
        //this.collider.enabled = false;
        //Debug.Log("playerBombHelper: "+this.collider+" is " + this.collider.enabled + " and has collided with "+other);
		if (hasCollided == false && (other.gameObject.tag == "BossPart" || other.gameObject.tag == "Boss"))
        //if (other.gameObject.name == "BasicEnemy" || other.gameObject.tag == "Enemy") //change later to tags for any enemy
        {
            //Debug.Log("playerBombHelper: has collided with a "+other.gameObject.tag);
            if (other.gameObject.tag == "Boss")
            {
                //Debug.Log("playerBombHelper.cs: hitting a boss and the damage is "+damage);
                //Destroy(this.gameObject);
                BossLogic bosslogic = (BossLogic)other.gameObject.GetComponent(typeof(BossLogic));
                bosslogic.doDamage(damage);
                ModifyBossHealthBar bossHealthBar = (ModifyBossHealthBar)other.gameObject.GetComponent(typeof(ModifyBossHealthBar));
                bossHealthBar.GetHit(damage);
                //hasCollided = true;
                //Destroy(this.gameObject);
            }
            else if (other.gameObject.tag == "BossPart")
            {
                //Debug.Log("playerBombHelper.cs: hitting a boss part and the damage is " + damage);
                //Destroy(this.gameObject);
                BossPartLogic bossPartLogic = (BossPartLogic)other.gameObject.GetComponent(typeof(BossPartLogic));
                bossPartLogic.doDamage(damage);
                //hasCollided = true;
                //Destroy(this.gameObject);
                //SDebug.Log("Up in here");
            }
            /*Debug.Log("playerBombHelper.cs: hasCollided = true");
            hasCollided = true;*/
        }
        if (other.gameObject.tag == "Enemy")
        {
            //Destroy(this.gameObject);
            EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
            enemylogic.doDamage(damage);
            //hasCollided = true;
            //Destroy(this.gameObject);
            Debug.Log("playerBombHelper.cs: hitting an enemy");
        }
        if (other.gameObject.tag == "EnemyBullet")
        {
            //Debug.Log("playerBombHelper.cs: hitting enemy bullet");
            other.gameObject.GetComponent<Collider>().enabled = false;
            other.gameObject.GetComponent<Renderer>().enabled = false;
        }
    }

    /*void OnTriggerStay(Collider other)
    {
        if (other.gameObject.tag == "EnemyBullet")
        {
            Debug.Log("playerBombHelper.cs: still colliding with " + other);
        }
    }*/
}