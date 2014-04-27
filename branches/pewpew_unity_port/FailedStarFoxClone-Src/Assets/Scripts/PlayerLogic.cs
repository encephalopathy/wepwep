using UnityEngine;
using System.Collections;

public class PlayerLogic : MonoBehaviour
{
    public float movementSpeed = 1.0f;
    public int invert = -1; //Negative 1 for invert, positive 1 for not
    public static int maxHealth = 100;

    public GameObject explosion;
    public GameObject camera;

    public float maxX = 6.2f;
    public float maxZ = 2.3f;
    public int currentHealth = 100;
    public float cooldownTime = 0;

    void Start()
    {
        currentHealth = maxHealth;
    }

    // Update is called once per frame
    void Update()
    {
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");

        Vector3 direction = new Vector3(horizontal, 0, invert * vertical);
        Vector3 finalDirection = new Vector3(horizontal, invert * vertical, 1.0f);

        transform.position += direction * movementSpeed * Time.deltaTime;
        if (transform.position.x > maxX)
        {
            transform.position = new Vector3(maxX, transform.position.y, transform.position.z);
        }
        if (transform.position.x < -maxX)
        {
            transform.position = new Vector3(-maxX, transform.position.y, transform.position.z);
        }
        if (transform.position.z > maxZ)
        {
            transform.position = new Vector3(transform.position.x, transform.position.y, maxZ);
        }
        if (transform.position.z < -maxZ)
        {
            transform.position = new Vector3(transform.position.x, transform.position.y, -maxZ);
        }        


        //transform.rotation = Quaternion.RotateTowards(transform.rotation, Quaternion.LookRotation(finalDirection), Mathf.Deg2Rad * 40.0f);
        if (cooldownTime > 0) cooldownTime -= Time.deltaTime;
    }

    public void doDamage(int amount)
    {
        ShakeCamera other = (ShakeCamera)camera.GetComponent(typeof(ShakeCamera));
        other.DoShake();
        if (cooldownTime <= 0)
        {
            currentHealth -= amount;
            ModifyHealthBar hb = (ModifyHealthBar)GetComponent(typeof(ModifyHealthBar));
            hb.GetHit(-amount);
            cooldownTime = 1;
        }
        if (currentHealth <= 0)
        {
            Instantiate(explosion, transform.position, transform.rotation);
            Destroy(this.gameObject);
        }        
    }

    //Basic collision detection checking for two differently named objects
    void OnCollisionEnter(Collision theCollision)
    {
        if (theCollision.gameObject.name == "Wall")
        {
            Debug.Log("Crashed into a wall!");
            doDamage(20);
        }
        else if (theCollision.gameObject.name == "EnemyBullet")
        {
            doDamage(15);
            Destroy(theCollision.gameObject);
            Debug.Log("You got shot!!");
        }
       /* else if (theCollision.gameObject.name == "BasicEnemy")
        {
            doDamage(50);
            EnemyLogic other = (EnemyLogic)theCollision.gameObject.GetComponent(typeof(EnemyLogic));
            other.Die();
            Debug.Log("You crashed into a dude!!");
        }*/

    }

}
