using UnityEngine;
using System.Collections;

public class PlayerBulletLaserHelper : MonoBehaviour
{
	public float velX;
	public float velY;
	public float velZ;

    public int playerBulletVelocity = 10;
    public int playerBulletDamage = 1;
    private bool hasCollided = false;
	public GameObject player;
	public Vector3 movementVector;
	public float moveZ = 0;
    private GameObject spawnPt;
    private bool canGrow = true;
    private float damageCooldown = 0.25f;

	void Start () {
		/*player = GameObject.Find("Ship");
		moveZ = player.transform.position.z + 2.0f;

		movementVector = new Vector3 (player.transform.position.x, 0, moveZ);
		this.gameObject.transform.position = movementVector;*/
        spawnPt = GameObject.Find("Blaster");
        moveZ = spawnPt.transform.position.z;
        this.gameObject.transform.position = spawnPt.transform.position;
	}

	void Update ()
	{
		if (Input.GetButton ("Fire1")) {
						/*movementVector = new Vector3 (player.transform.position.x, 0, moveZ);
						moveZ = moveZ + .5f;
						this.gameObject.transform.position = movementVector;*/
            this.gameObject.transform.position = new Vector3 (spawnPt.transform.position.x, 0, moveZ);
            moveZ += 0.5f;
		} else {
            Destroy(this.gameObject);
            moveZ = spawnPt.transform.position.z;
		}
        if (hasCollided)
        {
            damageCooldown -= Time.deltaTime;
            if (damageCooldown <= 0)
            {
                hasCollided = false;
                damageCooldown = 0.25f;
            }
        }

	}

    /*void onCollisionEnter(Collision theCollision)
    {
        if (theCollision.transform.tag == "Enemy" || theCollision.gameObject.tag == "BossPart" || theCollision.gameObject.tag == "Boss" || theCollision.gameObject.tag == "Destroy")
        {

        }
    }

	void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.name == "BasicEnemy")
		{
			EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
			enemylogic.doDamage(damage);
		}
	}*/
    void OnTriggerEnter(Collider other)
    {
        //Destroy(this.gameObject);
        //this.collider.enabled = false;
        //Debug.Log("playerBulletHelper: "+this.collider+" is " + this.collider.enabled);
        //Debug.Log("PlayerBulletHelper.cs: We hit something");
		if (hasCollided != true || other.gameObject.tag == "Enemy" || other.gameObject.tag == "BossPart" || other.gameObject.tag == "Boss" || other.gameObject.tag == "DestroyBullet" || other.gameObject.tag == "PlayerBullet")
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
			else if (other.gameObject.tag == "PlayerBullet"){ Debug.Log("Hitting player bullets");}
            else if (other.gameObject.tag == "DestroyBullet")
            {
                Destroy(this.gameObject);
            }
        }
    }
}
