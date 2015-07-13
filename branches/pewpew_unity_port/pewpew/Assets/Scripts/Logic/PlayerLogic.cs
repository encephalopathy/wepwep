using UnityEngine;
using System.Collections;
using UnityEngine.UI; //added for health UI

public class PlayerLogic : MonoBehaviour
{
    public float movementSpeed = 1.0f;
    public int invert = -1; //Negative 1 for invert, positive 1 for not
    

    public GameObject explosion;
    //public GameObject camera;

    public float maxX = 6.2f;
    public float maxZ = 2.3f;
    public int maxHealth = 100;
    public int currentHealth = 100;
	public float currentEnergy = 100;
	public float maxEnergy = 100;
    public float cooldownTime = 0;

	//UI Testing values; Make sure they are set up before running.
	public Slider healthBarSlider;
	public Text healthText;
	public Slider energyBarSlider;
	public Text energyText;

	/*private float previousX;
	private float previousY;*/
    private bool alive = true;
    public bool isFiring = false; //Do not touch

    public bool isPlayerInvincible = false;

	public int score = 0;

    void Start()
    {
        currentHealth = maxHealth;

		//UI Testing
		healthText.text = "Health: " + currentHealth;
		energyText.text = "Energy: " + currentEnergy;

		/*previousX = Input.GetAxis("Horizontal");
		previousY = Input.GetAxis("Vertical");*/
    }

    // Update is called once per frame
    void Update()
    {
		if(currentEnergy < maxEnergy) {
			currentEnergy+= 20f*Time.deltaTime;
			if(currentEnergy > maxEnergy){ 
				currentEnergy = maxEnergy;
			}

			energyBarSlider.value = ((float)currentEnergy / maxEnergy)*energyBarSlider.maxValue;
			energyText.text = "Energy: " + currentEnergy;

		}
        float horizontal = Input.GetAxisRaw("Horizontal");
        float vertical = Input.GetAxisRaw("Vertical");

        /*if (horizontal < 1 && horizontal > 0)
        {
            horizontal = 1;
        }
        else if(horizontal > -1 && horizontal < 0)
        {
            horizontal = -1;
        }
        if (vertical < 1 && vertical > 0)
        {
            vertical = 1;
        }
        else if (vertical > -1 && vertical < 0)
        {
            vertical = -1;
        }*/

        Vector3 direction = new Vector3(horizontal, 0, invert * vertical);
        //Vector3 finalDirection = new Vector3(horizontal, invert * vertical, 1.0f);
        //Debug.Log("direction is " + direction);

		if (Input.touchCount > 0 && 
		    Input.GetTouch(0).phase == TouchPhase.Moved) {
			
			// Get movement of the finger since last frame
			Vector2 touchDeltaPosition = Input.GetTouch(0).deltaPosition;
			direction = new Vector3(touchDeltaPosition.x, 0, invert * touchDeltaPosition.y);
		}

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


		ModifyEnergyBar eb = (ModifyEnergyBar)GetComponent(typeof(ModifyEnergyBar));
		eb.Set(currentEnergy);

        //transform.rotation = Quaternion.RotateTowards(transform.rotation, Quaternion.LookRotation(finalDirection), Mathf.Deg2Rad * 40.0f);
        if (cooldownTime > 0) cooldownTime -= Time.deltaTime;
    }

    public void doDamage(int amount)
    {
        //Debug.Log("PlayerLogic: damage is being dealt to the player.");
        if (!isPlayerInvincible)
        {
            //Debug.Log("PlayerLogic: player is not invincible and will take damage.");
            if (cooldownTime <= 0)
            {
                //Debug.Log("EnemyLogic: CurrentHealth before damage is " + currentHealth);
                currentHealth -= amount;

				//healthBarSlider.value -= .011f; //reduce health
				healthBarSlider.value = ((float)currentHealth / maxHealth)*healthBarSlider.maxValue;
				//Debug.Log ("test_healthBarSlider.value: " + healthBarSlider.value);
				healthText.text = "Health: " + currentHealth;

                //Debug.Log("EnemyLogic: CurrentHealth after damage is " + currentHealth);
                ModifyHealthBar hb = (ModifyHealthBar)GetComponent(typeof(ModifyHealthBar));
                hb.GetHit(-amount);
                cooldownTime = 1;
                //ShakeCamera other = (ShakeCamera)camera.GetComponent(typeof(ShakeCamera)); // taken out at the moment, may be added in for boss intros
                //other.DoShake();
            }
            if (currentHealth <= 0 && alive)
            {
                Instantiate(explosion, transform.position, transform.rotation);
                Destroy(this.gameObject);
                alive = false;
            }
        }
    }

    //Basic collision detection checking for two differently named objects
    void OnCollisionEnter(Collision theCollision)
    {
        if (theCollision.gameObject.name == "Wall")
        {
            //Debug.Log("Crashed into a wall!");
            doDamage(20);
        }
        //else if (theCollision.gameObject.name == "EnemyBullet")
        else if (theCollision.gameObject.tag == "EnemyBullet")
        {
            doDamage(theCollision.gameObject.gameObject.GetComponent<BulletHelper>().enemyBulletDamage);
            Destroy(theCollision.gameObject);
        }
       /* else if (theCollision.gameObject.name == "BasicEnemy")
        {
            doDamage(50);
            EnemyLogic other = (EnemyLogic)theCollision.gameObject.GetComponent(typeof(EnemyLogic));
            other.Die();
            Debug.Log("You crashed into a dude!!");
        }*/

    }

	void OnTriggerEnter(Collider other)
	{

		/*if (other.gameObject.name == "EnemyBullet")
		{
			doD1amage(15);
			Destroy(other.gameObject);
			//Debug.Log("You got shot!!");
		}*/
	}

	public bool canFire(int cost, bool continuousFire)
	{
		//Debug.Log(currentEnergy + " is the players nrg" );
		bool _canFire = false;
		if(currentEnergy > cost)
        {
            currentEnergy -= cost;
            _canFire = true;

            if (continuousFire)
            {
                isFiring = false;
            }
            else if (!continuousFire && !isFiring)
            {
                isFiring = true;
            }

			energyBarSlider.value = ((float)currentEnergy / maxEnergy)*energyBarSlider.maxValue;
			//Debug.Log ("test_energyBarSlider: " + energyBarSlider.value);
			energyText.text = "Energy: " + currentEnergy;

		}
		return _canFire;
	}
}
