﻿using UnityEngine;
using System.Collections;

public class PlayerBulletHelper : MonoBehaviour
{

    public float velX;
    public float velY;
    public float velZ;

    public int damage = 15;
	public int NRGCost = 5;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update ()
	{
	   	this.gameObject.transform.Translate(Vector3.forward * 50 * Time.deltaTime);
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
        //Debug.Log("Up in here");
        if (other.gameObject.name == "BasicEnemy") //change later to tags for any enemy
        {
            EnemyLogic enemylogic = (EnemyLogic)other.gameObject.GetComponent(typeof(EnemyLogic));
            enemylogic.doDamage(damage);
            Destroy(this.gameObject);
            //SDebug.Log("Up in here");
        }
    }

}
