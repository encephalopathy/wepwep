using UnityEngine;
using System.Collections;

public class DoubleShot : MonoBehaviour
{

    public GameObject bullet;
    public float bulletSpeed = 10.0f; //currently unused
    public GameObject spawnPt;
    public AudioSource SoundEffect;
    public float bulletLife = 3f;
    private Transform spawnBullet;
    public Vector3 bulletOffsetVector = new Vector3(1f, 0f, 0f);
    public GameObject player;
    public int energyCost = 15;
    public float delayBetweenWaves = 0.2f; // higher number for a longer delay
    public int numberOfWaves = 3;
    public bool willRotate = false; // used for if the weapon will be used on a rotating turret on a boss or such
    public float rotationStartingAngle = 45f; // starting angle
    public float angleStep = 5f; // amount of rotation between each shot
    public int bulletsPerWave = 18;
    public float delayBetweenBullets = 0.5f;
    public bool DoubleShotIsPlayerWeapon = true;
    public float enemyFireRate = 2;
    private float aEnemyFireRate;

    void start()
    {
        aEnemyFireRate = enemyFireRate;
    }

    void Update()
    {
        if (DoubleShotIsPlayerWeapon)
        {
            if (Input.GetButtonDown("Fire1"))
            {
                StartCoroutine("fireDouble");
            }
        }
        else
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
        if (DoubleShotIsPlayerWeapon)
        {
            Debug.Log("DoubleShotIsPlayerWeapon is "+DoubleShotIsPlayerWeapon);
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
        else
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
            projectile1.transform.rotation = spawnPt.transform.rotation;
            projectile2.transform.rotation = spawnPt.transform.rotation;
            projectile1.gameObject.name = "DoubleShot";
            projectile2.gameObject.name = "DoubleShot";
            Destroy(projectile1.gameObject, bulletLife);
            Destroy(projectile2.gameObject, bulletLife);
            return null;
    }
}
