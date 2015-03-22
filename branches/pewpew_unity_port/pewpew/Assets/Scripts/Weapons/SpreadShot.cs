using UnityEngine;
using System.Collections;

public class SpreadShot : MonoBehaviour
{
    [Tooltip("Use the player/enemy bullet prefabs.")]
    [SerializeField] private GameObject bullet;
    [SerializeField] private string bulletName = "SpreadShot";
    [Tooltip("Speed of the bullet.")]
    [SerializeField] private int bulletVelocity = 30;
    [Tooltip("Amount of time before the bullet is destroyed automatically.")]
    [SerializeField] private float bulletLife = 10f;
    [SerializeField] private int bulletDamage = 1;
    [Tooltip("Game object whose forward Z vector determines which direction the bullets travel.")]
    [SerializeField] private GameObject spawnPt;
    [Tooltip("Enemies should not have sound effects unless they are bosses and/or using special weapons.")]
    [SerializeField] private AudioSource SoundEffect;
    //[SerializeField] private float bulletLife = 3f;
    [Tooltip("The full span of the angle that bullets will fire through. Center of the angle is aligned with the forward vector (ie: 30 degree angle will have 15 degrees to each side of the 0).")]
    [SerializeField] private float firingAngle = 30f;
    [Tooltip("Total amount of bullets that will be shot per wave. Please use numbers that break the angle up nicely (ie: for a 30 degree angle, 3 bullets will work nicely).")]
    [SerializeField] private int numberOfBullets = 3;
    /*[Tooltip("Used if you want the bullet to not shoot from exactly where the Spawn Point is.")]
    [SerializeField] private Vector3 bulletOffsetVector = new Vector3(0f, 0f, 0f);*/
    [Tooltip("The Player game object is only necessary if the player is using the weapon.")]
    [SerializeField] private GameObject player;
    [Tooltip("Only the player will utilize the energy cost.")]
    [SerializeField] private int energyCost = 15;
    [Tooltip("The amount of waves of bullets that will be shot when the weapon is fired once. ie: 3 waves will shoot the weapon 3 times for 1 mouseclick.")]
    [SerializeField] private int numberOfWaves = 3;
    [Tooltip("The length of the delay between each automatically fired wave of bullets. A higher number will result in a longer delay.")]
    [SerializeField] private float delayBetweenWaves = 0.2f; // higher number for a longer delay
    [Tooltip("the number of arcs determines how many sections the total angle is split into.")]
    [SerializeField] private int numberOfArcs = 1;
    [Tooltip("The angle between each arc, does not apply on the outside (between the arc and the edge of the full angle).")]
    [SerializeField] private float angleBetweenArcs = 10f;
    [Tooltip("The delay between each time an enemy fires the weapon. A higher number will result in a longer delay.")]
    [SerializeField] private float enemyFireRateDelay = 2;
    private float aEnemyFireRateDelay;
    /*[Tooltip("Toggles whether or not the weapon will shoot straight forward or rotate while shooting. Functionality needs testing.")]
    [SerializeField] private bool willRotate = false; // used for if the weapon will be used on a rotating turret on a boss or such
    [Tooltip("The starting angle of rotation when rotating and firing. Value will be subtracted from 0.")]
    [SerializeField] private float rotationStartingAngle = 45f; // starting angle
    [Tooltip("The amount of rotation between each shot.")]
    [SerializeField] private float rotationAngleStep = 5f; // amount of rotation between each shot
    [Tooltip("The total amount of automatically fired bullets per one weapon fire.")]
    [SerializeField] private int bulletsPerWave = 18;
    [Tooltip("The delay between each automatically fired bullet.")]
    [SerializeField] private float delayBetweenBullets = 0.5f;*/
   

    void start()
    {
        aEnemyFireRateDelay = enemyFireRateDelay;
    }

    void Update()
    {
        if (transform.parent.tag == "Player")
        {
            if (Input.GetButtonDown("Fire1"))
            {
                StartCoroutine("fireSpread");
            }
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss")
        {
            aEnemyFireRateDelay -= Time.deltaTime;
            if (aEnemyFireRateDelay <= 0)
            {
                StartCoroutine("fireSpread");
                aEnemyFireRateDelay = enemyFireRateDelay;
            }
        }
    }

    IEnumerator fireSpread()
    {
        if (transform.parent.tag == "Player")
        {
            if (player.GetComponent<PlayerLogic>().canFire(energyCost))
            {
                if (!spawnPt)
                {
                    spawnPt = GameObject.Find("oneSpawn");
                }
                for (int j = 0; j < numberOfWaves; j++)
                {
                    StartCoroutine("wave");
                    SoundEffect.Play(0);
                    yield return new WaitForSeconds(delayBetweenWaves);
                }
                player.GetComponent<PlayerLogic>().isFiring = false;
            }
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss")
        {
            if (!spawnPt)
            {
                spawnPt = GameObject.Find("oneSpawn");
            }
            for (int j = 0; j < numberOfWaves; j++)
            {
                StartCoroutine("wave");
                /*if (SoundEffect != null)
                {
                    SoundEffect.Play(0);
                }
                else
                {
                    Debug.Log("sound effects are null in SingleShot");
                }*/
                yield return new WaitForSeconds(delayBetweenWaves);
            }
        }
    }

    IEnumerator wave()
    {
        float angleStep = ((firingAngle - (angleBetweenArcs * (numberOfArcs - 1))) / (numberOfBullets - 1));
        //Debug.Log("Spreadshot: anglestep is " + angleStep);
        float bulletsPerArc = Mathf.Ceil(numberOfBullets / numberOfArcs);

        for (int i = 1; i <= numberOfBullets; i++)
        {
            //float rotationAngle = firingAngle/2 - ((i - 1) * angleStep) - ((Mathf.Ceil(i / bulletsPerArc) - 1) * angleBetweenArcs);
            float rotationAngle = (-1 * firingAngle / 2 + ((i - 1) * angleStep) + ((Mathf.Ceil(i / bulletsPerArc) - 1) * angleBetweenArcs)) + transform.eulerAngles.y;
            GameObject projectile = Instantiate(bullet, spawnPt.transform.position, Quaternion.identity) as GameObject;
            if (transform.parent.tag == "Player")
            {
                projectile.GetComponent<PlayerBulletHelper>().playerBulletDamage = bulletDamage;
                projectile.GetComponent<PlayerBulletHelper>().playerBulletLife = bulletLife;
                projectile.GetComponent<PlayerBulletHelper>().playerBulletVelocity = bulletVelocity;
            }
            else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss" || transform.parent.tag == "BossPart")
            {
                projectile.GetComponent<BulletHelper>().enemyBulletDamage = bulletDamage;
                projectile.GetComponent<BulletHelper>().enemyBulletLife = bulletLife;
                projectile.GetComponent<BulletHelper>().enemyBulletVelocity = bulletVelocity;
            }
            projectile.transform.rotation = Quaternion.Euler(spawnPt.transform.rotation.x, rotationAngle, spawnPt.transform.rotation.z);
            projectile.gameObject.name = bulletName;
            //Destroy(projectile.gameObject, bulletLife);
        }
        return null;
    }
}