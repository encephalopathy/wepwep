using UnityEngine;
using System.Collections;

public class BulletHelper : MonoBehaviour
{

    /*[SerializeField] private float enemyBulletVelocity = 10;
    [SerializeField] private float enemyBulletLife = 5f;
    [SerializeField] private int enemyBulletDamage = 15;*/
    public int enemyBulletVelocity = 10;
    public float enemyBulletLife = 5f;
    public int enemyBulletDamage = 15;
    //public int singleShotDamage = 0;

	// Use this for initialization
	void Start ()
    {
        Destroy(this.gameObject, enemyBulletLife);
	}
	
	// Update is called once per frame
	void Update ()
	{
        this.gameObject.transform.Translate(Vector3.forward * enemyBulletVelocity * Time.deltaTime);
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
        if (other.tag == "Player")
        {
            PlayerLogic playerlogic = (PlayerLogic)other.gameObject.GetComponent(typeof(PlayerLogic));
            playerlogic.doDamage(enemyBulletDamage);
            Destroy(this.gameObject);
            //Debug.Log("Up in here");
        }
        else if (other.tag == "PlayerShield")
        {
            ShieldLogic shieldLogic = (ShieldLogic)other.gameObject.GetComponent(typeof(ShieldLogic));
            shieldLogic.doDamage(enemyBulletDamage);
            Destroy(this.gameObject);
        }    
        else if (other.tag == "Destroy" || other.tag == "DestroyBullet")
        {
            Destroy(this.gameObject);
        }
    }

}
