using UnityEngine;
using System.Collections;

public class PlayerBulletHelper : MonoBehaviour
{

    public float velX;
    public float velY;
    public float velZ;

    public int damage = 1;
	public int NRGCost = 5;
    private bool hasCollided = false;

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update ()
	{
	   	this.gameObject.transform.Translate(Vector3.forward * 50 * Time.deltaTime);
        if (hasCollided == true)
        {
            this.collider.enabled = false;
            Debug.Log("playerBulletHelper: "+this.collider+" is " + this.collider.enabled);
        }
	}


    //Basic collision detection checking for two differently named objects
    void OnCollisionEnter(Collision theCollision)
    {
        if (theCollision.gameObject.name == "Bullet")
        {
            Debug.Log("Bullet hit the wall yo");
            //Destroy(theCollision.gameObject);
        }
        else 
        {
            //Destroy(this);
        }
    }

    void OnTriggerEnter(Collider other)
    {
        hasCollided = true;
        //this.collider.enabled = false;
        //Debug.Log("playerBulletHelper: "+this.collider+" is " + this.collider.enabled);
        Destroy(this.gameObject);
        //Debug.Log("PlayerBulletHelper.cs: We hit something");
		if (other.gameObject.tag == "Enemy" || other.gameObject.tag == "BossPart" || other.gameObject.tag == "Boss")
        //if (other.gameObject.name == "BasicEnemy" || other.gameObject.tag == "Enemy") //change later to tags for any enemy
        {
            if (other.gameObject.tag == "Enemy")
            {
                //Destroy(this.gameObject);
                EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
                enemylogic.doDamage(damage);
                //SDebug.Log("Up in here");
                //Debug.Log("PlayerBulletHelper.cs: We hit an enemy");
            }
            else if (other.gameObject.tag == "Boss")
            {
                //Debug.Log("playerBullethelper.cs: hitting a boss and the damage is "+damage);
                //Destroy(this.gameObject);
                EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
                enemylogic.doDamage(damage);
                ModifyBossHealthBar bossHealthBar = (ModifyBossHealthBar)other.gameObject.GetComponent(typeof(ModifyBossHealthBar));
                bossHealthBar.GetHit(damage);
            }
            else if (other.gameObject.tag == "BossPart")
            {
                //Destroy(this.gameObject);
                BossPartLogic bossPartLogic = (BossPartLogic)other.gameObject.GetComponent(typeof(BossPartLogic));
                bossPartLogic.doDamage(damage);
                //SDebug.Log("Up in here");
                //Debug.Log("PlayerBulletHelper.cs: hit a boss part");
            }
        }
    }

}