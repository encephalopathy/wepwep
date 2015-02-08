using UnityEngine;
using System.Collections;

public class BulletHelper : MonoBehaviour
{

    [SerializeField] private float bulletVelocity = 10;
    [SerializeField] private float bulletLife = 5f;
    [SerializeField] private int damage = 15;


	// Use this for initialization
	void Start ()
    {
        Destroy(this.gameObject, bulletLife);
	}
	
	// Update is called once per frame
	void Update ()
	{
        this.gameObject.transform.Translate(Vector3.forward * bulletVelocity * Time.deltaTime);
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
            playerlogic.doDamage(damage);
            Destroy(this.gameObject);
            //Debug.Log("Up in here");
        }
        else if (other.tag == "PlayerShield")
        {
            ShieldLogic shieldLogic = (ShieldLogic)other.gameObject.GetComponent(typeof(ShieldLogic));
            shieldLogic.doDamage(damage);
            Destroy(this.gameObject);
        }    
        else if (other.tag == "Destroy")
        {
            Destroy(this.gameObject);
        }
    }

}
