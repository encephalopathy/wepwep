using UnityEngine;
using System.Collections;

public class PlayerBulletHelper : MonoBehaviour
{
    //[SerializeField] private int playerBulletVelocity = 10;
    //[SerializeField] private float playerBulletLife = 5f;
    //[SerializeField] private int playerBulletDamage = 1;
    public int playerBulletVelocity = 10;
    public float playerBulletLife = 5f;
    public int playerBulletDamage = 1;
    private bool hasCollided = false;

	// Use this for initialization
    void Start()
    {
        Destroy(this.gameObject, playerBulletLife);
	}
	
	// Update is called once per frame
	void Update ()
	{
        if (hasCollided == true)
        {
            this.GetComponent<Collider>().enabled = false;
        }
	   	this.gameObject.transform.Translate(Vector3.forward * playerBulletVelocity * Time.deltaTime);
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
        //Destroy(this.gameObject);
        //this.collider.enabled = false;
        //Debug.Log("playerBulletHelper: "+this.collider+" is " + this.collider.enabled);
        //Debug.Log("PlayerBulletHelper.cs: We hit something");
		if (hasCollided != true || other.gameObject.tag == "Enemy" || other.gameObject.tag == "BossPart" || other.gameObject.tag == "Boss" || other.gameObject.tag == "Destroy")
        //if (other.gameObject.name == "BasicEnemy" || other.gameObject.tag == "Enemy") //change later to tags for any enemy
        {
            if (other.gameObject.tag == "Enemy")
            {
                //Destroy(this.gameObject);
                EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
                enemylogic.doDamage(playerBulletDamage);
                hasCollided = true;
                Destroy(this.gameObject);
                //Debug.Log("Up in here");
                //Debug.Log("PlayerBulletHelper.cs: We hit an enemy");
            }
            else if (other.gameObject.tag == "Boss")
            {
                //Debug.Log("playerBullethelper.cs: hitting a boss and the playerBulletDamage is "+playerBulletDamage);
                //Destroy(this.gameObject);
                BossLogic enemylogic = (BossLogic)other.gameObject.GetComponent(typeof(BossLogic));
                enemylogic.doDamage(playerBulletDamage);
                ModifyBossHealthBar bossHealthBar = (ModifyBossHealthBar)other.gameObject.GetComponent(typeof(ModifyBossHealthBar));
                bossHealthBar.GetHit(playerBulletDamage);
                hasCollided = true;
                Destroy(this.gameObject);
            }
            else if (other.gameObject.tag == "BossPart")
            {
                //Destroy(this.gameObject);
                BossPartLogic bossPartLogic = (BossPartLogic)other.gameObject.GetComponent(typeof(BossPartLogic));
                bossPartLogic.doDamage(playerBulletDamage);
                hasCollided = true;
                Destroy(this.gameObject);
                //SDebug.Log("Up in here");
                //Debug.Log("PlayerBulletHelper.cs: hit a boss part");
            }
            else if (other.gameObject.tag == "Destroy"){
                Destroy(this.gameObject);
            }
        }
    }

}