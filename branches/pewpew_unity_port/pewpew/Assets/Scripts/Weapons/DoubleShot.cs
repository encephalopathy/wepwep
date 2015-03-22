using UnityEngine;
using System.Collections;

public class DoubleShot : MonoBehaviour
{
    //public float bulletSpeed = 10.0f; //currently unused
    [Tooltip("Use the player/enemy bullet prefabs.")]
    [SerializeField] private GameObject bullet;
    [SerializeField] private string bulletName = "DoubleShot";
    [Tooltip("Speed of the bullet.")]
    [SerializeField] private int bulletVelocity = 30;
    [Tooltip("Amount of time before the bullet is destroyed automatically.")]
    [SerializeField] private float bulletLife = 10f;
    [SerializeField] private int bulletDamage = 5;
    [Tooltip("Game object whose forward Z vector determines which direction the bullets travel.")]
    [SerializeField] private GameObject spawnPt;
    [Tooltip("Enemies should not have sound effects unless they are bosses and/or using special weapons.")]
    [SerializeField] private AudioSource SoundEffect;
    private Transform spawnBullet;
    [Tooltip("Used if you want the bullet to not shoot from exactly where the Spawn Point is.")]
    [SerializeField] private Vector3 bulletOffsetVector = new Vector3(1f, 0f, 0f);
    [Tooltip("The Player game object is only necessary if the player is using the weapon.")]
    [SerializeField] private GameObject player;
    [Tooltip("Only the player will utilize the energy cost.")]
    [SerializeField] private int energyCost = 15;
    [Tooltip("The amount of waves of bullets that will be shot when the weapon is fired once. ie: 3 waves will shoot the weapon 3 times for 1 mouseclick.")]
    [SerializeField] private int numberOfWaves = 3;
    [Tooltip("The length of the delay between each automatically fired wave of bullets. A higher number will result in a longer delay.")]
    [SerializeField] private float delayBetweenWaves = 0.2f; // higher number for a longer delay
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
        //if (DoubleShotIsPlayerWeapon)
        if (transform.parent.tag == "Player")
        {
            if (Input.GetButtonDown("Fire1"))
            {
                StartCoroutine("fireDouble");
            }
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss")
        {
            aEnemyFireRateDelay -= Time.deltaTime;
            if (aEnemyFireRateDelay <= 0)
            {
                StartCoroutine("fireDouble");
                aEnemyFireRateDelay = enemyFireRateDelay;
            }
        }
    }

    IEnumerator fireDouble()
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
                Debug.Log("spawn point is false/null");
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
        GameObject projectile1 = Instantiate(bullet, spawnPt.transform.position + bulletOffsetVector, Quaternion.identity) as GameObject;
        GameObject projectile2 = Instantiate(bullet, spawnPt.transform.position - bulletOffsetVector, Quaternion.identity) as GameObject;
        if (transform.parent.tag == "Player")
        {
            projectile1.GetComponent<PlayerBulletHelper>().playerBulletDamage = bulletDamage;
            projectile1.GetComponent<PlayerBulletHelper>().playerBulletLife = bulletLife;
            projectile1.GetComponent<PlayerBulletHelper>().playerBulletVelocity = bulletVelocity;
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss" || transform.parent.tag == "BossPart")
        {
            projectile1.GetComponent<BulletHelper>().enemyBulletDamage = bulletDamage;
            projectile1.GetComponent<BulletHelper>().enemyBulletLife = bulletLife;
            projectile1.GetComponent<BulletHelper>().enemyBulletVelocity = bulletVelocity;
        }
        if (transform.parent.tag == "Player")
        {
            projectile2.GetComponent<PlayerBulletHelper>().playerBulletDamage = bulletDamage;
            projectile2.GetComponent<PlayerBulletHelper>().playerBulletLife = bulletLife;
            projectile2.GetComponent<PlayerBulletHelper>().playerBulletVelocity = bulletVelocity;
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss" || transform.parent.tag == "BossPart")
        {
            projectile2.GetComponent<BulletHelper>().enemyBulletDamage = bulletDamage;
            projectile2.GetComponent<BulletHelper>().enemyBulletLife = bulletLife;
            projectile2.GetComponent<BulletHelper>().enemyBulletVelocity = bulletVelocity;
        }
        projectile1.transform.rotation = spawnPt.transform.rotation;
        projectile2.transform.rotation = spawnPt.transform.rotation;
        projectile1.gameObject.name = bulletName;
        projectile2.gameObject.name = bulletName;
        /*Destroy(projectile1.gameObject, bulletLife);
        Destroy(projectile2.gameObject, bulletLife);*/
        return null;
    }
}
