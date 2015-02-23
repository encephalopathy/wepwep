using UnityEngine;
using System.Collections;

public class DoubleShot : MonoBehaviour
{
    public float bulletSpeed = 10.0f; //currently unused
    [SerializeField] private GameObject bullet;
    [SerializeField] private GameObject spawnPt;
    [SerializeField] private AudioSource SoundEffect;
    [SerializeField] private string bulletName = "DoubleShot";
    [SerializeField] private int bulletVelocity = 30;
    [SerializeField] private float bulletLife = 10f;
    [SerializeField] private int bulletDamage = 1;
    private Transform spawnBullet;
    [SerializeField] private Vector3 bulletOffsetVector = new Vector3(1f, 0f, 0f);
    [SerializeField] private GameObject player;
    [SerializeField] private int energyCost = 15;
    [SerializeField] private float delayBetweenWaves = 0.2f; // higher number for a longer delay
    [SerializeField] private int numberOfWaves = 3;
    [SerializeField] private bool willRotate = false; // used for if the weapon will be used on a rotating turret on a boss or such
    [SerializeField] private float rotationStartingAngle = 45f; // starting angle
    [SerializeField] private float angleStep = 5f; // amount of rotation between each shot
    [SerializeField] private int bulletsPerWave = 18;
    [SerializeField] private float delayBetweenBullets = 0.5f;
    [SerializeField] private float enemyFireRate = 2;
    private float aEnemyFireRate;

    void start()
    {
        aEnemyFireRate = enemyFireRate;
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
            aEnemyFireRate -= Time.deltaTime;
            if (aEnemyFireRate <= 0)
            {
                StartCoroutine("fireDouble");
                aEnemyFireRate = enemyFireRate;
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
            if (willRotate)
            {
                for (int j = 0; j < numberOfWaves; j++)
                {
                    StartCoroutine("rotatingWave");
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
            else
            {
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
