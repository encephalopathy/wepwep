using UnityEngine;
using System.Collections;

public class PlayerLaserBulletHelper : MonoBehaviour
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
    private bool maxLength = false;
    private Vector3 enemyPosition;
    //private GameObject upperBound;
    private float controlDistance = 2;
    private float laserDistance;
    private float laserScale;
    private Vector3 laserPosition;
    private Collider enemyCollider;

	void Start () {
		/*player = GameObject.Find("Ship");
		moveZ = player.transform.position.z + 2.0f;

		movementVector = new Vector3 (player.transform.position.x, 0, moveZ);
		this.gameObject.transform.position = movementVector;*/
        spawnPt = GameObject.Find("Blaster");
        moveZ = spawnPt.transform.position.z;
        this.gameObject.transform.position = spawnPt.transform.position;
        /*upperBound = GameObject.Find("DestroyBullet Front");
        controlDistance = upperBound.transform.position.z - spawnPt.transform.position.z;*/
        laserPosition = new Vector3();
	}

	void Update ()
	{
		if (Input.GetButton ("Fire1")) {
						/*movementVector = new Vector3 (player.transform.position.x, 0, moveZ);
						moveZ = moveZ + .5f;
						this.gameObject.transform.position = movementVector;*/
            /*this.gameObject.transform.position = new Vector3 (spawnPt.transform.position.x, 0, moveZ);
            moveZ += 0.5f;*/

            if (maxLength)
            {
                //enemyPosition.z - this.gameObject.transform.position.z;
                //laserScale = ( laserDistance / controlDistance ) / 2;
                laserDistance = enemyPosition.z - this.gameObject.transform.position.z;

                if (laserDistance != moveZ)
                {
                    //Debug.Log("PlayerLaserBulletHelper: laserDistance (" + laserDistance + ") does not equal moveZ (" + moveZ + ").");
                    moveZ = laserDistance;
                }
                //maxLength = false;
            }
            else
            {
                this.gameObject.transform.localScale += new Vector3(0, 0, 0.5f);
                moveZ = spawnPt.transform.position.z + this.gameObject.transform.localScale.z / 2; //divided by half to slow down the laser growth rate
            }
            laserPosition.Set(spawnPt.transform.position.x, 0, moveZ);
            this.gameObject.transform.position = laserPosition;
            /*if (!maxLength)
            {
                this.gameObject.transform.localScale += new Vector3(0, 0, 1);
            }
            moveZ = spawnPt.transform.position.z + this.gameObject.transform.localScale.z / 2;
            this.gameObject.transform.position = new Vector3(spawnPt.transform.position.x, 0, moveZ);*/
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

    void OnTriggerStay(Collider other)
    {
        //Debug.Log("playerLaserBulletHelper: OnTriggerStay is occurring with " + other + ".");
        if (hasCollided != true || other.gameObject.tag == "Enemy" || other.gameObject.tag == "BossPart" || other.gameObject.tag == "Boss" || other.gameObject.tag == "DestroyBullet")
        {
            if (other.gameObject.tag == "Enemy")
            {
                //Destroy(this.gameObject);
                EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
                enemylogic.doDamage(playerBulletDamage);
                hasCollided = true;
                enemyPosition = other.transform.position;
                //Debug.Log("playerLaserBulletHelper: enemyPosition is " + enemyPosition + ".");
                maxLength = true;
                //Destroy(this.gameObject);
                //Debug.Log("PlayerBulletHelper.cs: We hit an enemy");
                enemyCollider = other;
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
                enemyPosition = other.transform.position;
                maxLength = true;
                //Destroy(this.gameObject);
            }
            else if (other.gameObject.tag == "BossPart")
            {
                //Destroy(this.gameObject);
                BossPartLogic bossPartLogic = (BossPartLogic)other.gameObject.GetComponent(typeof(BossPartLogic));
                bossPartLogic.doDamage(playerBulletDamage);
                hasCollided = true;
                enemyPosition = other.transform.position;
                maxLength = true;
                //Destroy(this.gameObject);
                //Debug.Log("PlayerBulletHelper.cs: hit a boss part");
            }
            else if (other.gameObject.tag == "DestroyBullet")
            {
                enemyPosition = other.transform.position;

                maxLength = true;
            }
        }
    }

	/*void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.name == "BasicEnemy")
		{
			EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
			enemylogic.doDamage(damage);
		}
	}*/

    /*void OnTriggerEnter(Collider other)
    {
        //Destroy(this.gameObject);
        //this.collider.enabled = false;
        Debug.Log("PlayerLaserBulletHelper.cs: OnTriggerEnter has occurred with " + other + ".");
        if (hasCollided != true || other.gameObject.tag == "Enemy" || other.gameObject.tag == "BossPart" || other.gameObject.tag == "Boss" || other.gameObject.tag == "DestroyBullet")
        {
            if (other.gameObject.tag == "Enemy")
            {
                //Destroy(this.gameObject);
                EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
                enemylogic.doDamage(playerBulletDamage);
                hasCollided = true;
                enemyPosition = other.transform.position;
                maxLength = true;
                //Destroy(this.gameObject);
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
                enemyPosition = other.transform.position;
                maxLength = true;
                //Destroy(this.gameObject);
            }
            else if (other.gameObject.tag == "BossPart")
            {
                //Destroy(this.gameObject);
                BossPartLogic bossPartLogic = (BossPartLogic)other.gameObject.GetComponent(typeof(BossPartLogic));
                bossPartLogic.doDamage(playerBulletDamage);
                hasCollided = true;
                enemyPosition = other.transform.position;
                maxLength = true;
                //Destroy(this.gameObject);
                //Debug.Log("PlayerBulletHelper.cs: hit a boss part");
            }
            else if (other.gameObject.tag == "DestroyBullet")
            {
                enemyPosition = other.transform.position;
                maxLength = true;
            }
        }
    }

    void OnTriggerExit(Collider other)
    {
        //Destroy(this.gameObject);
        //this.collider.enabled = false;
        //Debug.Log("playerBulletHelper: "+this.collider+" is " + this.collider.enabled);
        Debug.Log("PlayerLaserBulletHelper.cs: OnTriggerExit has occurred with "+other+".");
        if (other.gameObject.tag == "Enemy" || other.gameObject.tag == "BossPart" || other.gameObject.tag == "Boss" || other.gameObject.tag == "DestroyBullet")
        //if (other.gameObject.name == "BasicEnemy" || other.gameObject.tag == "Enemy") //change later to tags for any enemy
        {
            if (other.gameObject.tag == "Enemy")
            {
                //Destroy(this.gameObject);
                EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
                enemylogic.doDamage(playerBulletDamage);
                //hasCollided = true;
                maxLength = true;
                enemyPosition = other.transform.position;
                //Destroy(this.gameObject);
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
                //hasCollided = true;
                maxLength = true;
                enemyPosition = other.transform.position;
                //Destroy(this.gameObject);
            }
            else if (other.gameObject.tag == "BossPart")
            {
                //Destroy(this.gameObject);
                BossPartLogic bossPartLogic = (BossPartLogic)other.gameObject.GetComponent(typeof(BossPartLogic));
                bossPartLogic.doDamage(playerBulletDamage);
                //hasCollided = true;
                maxLength = true;
                enemyPosition = other.transform.position;
                //Destroy(this.gameObject);
                //Debug.Log("PlayerBulletHelper.cs: hit a boss part");
            }
        }
    }*/
}
