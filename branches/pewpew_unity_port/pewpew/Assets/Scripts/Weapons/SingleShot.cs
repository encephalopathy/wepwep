using UnityEngine;
using System.Collections;

public class SingleShot : MonoBehaviour
{
    public GameObject bullet;
    public float bulletSpeed = 10.0f; //currently unused
    public GameObject spawnPt;
    public AudioSource SoundEffect;
    public float bulletLife = 3f;
    private Transform spawnBullet;
    public Vector3 bulletOffsetVector = new Vector3(0f, 0f, 0f);
    public GameObject player;
    public int energyCost = 15;
    public float delayBetweenWaves = 0.2f; // higher number for a longer delay
    public int numberOfWaves = 3;
    public bool willRotate = false; // used for if the weapon will be used on a rotating turret on a boss or such
    public float rotationStartingAngle = 45f; // starting angle
    public float angleStep = 5f; // amount of rotation between each shot
    public int bulletsPerWave = 18;
    public float delayBetweenBullets = 0.5f;
    public bool SingleShotIsPlayerWeapon = true;
    public float enemyFireRate = 2;
    private float aEnemyFireRate;

    void start()
    {
        aEnemyFireRate = enemyFireRate;
    }

    void Update()
    {
        if (SingleShotIsPlayerWeapon)
        {
            if (Input.GetButtonDown("Fire1"))
            {
                StartCoroutine("fireSingle");
            }
        }
        else
        {
            aEnemyFireRate -= Time.deltaTime;
            if (aEnemyFireRate <= 0)
            {
                StartCoroutine("fireSingle");
                aEnemyFireRate = enemyFireRate;
            }
        }
    }

    IEnumerator fireSingle()
    {
        if (SingleShotIsPlayerWeapon)
        {
            if (player.GetComponent<PlayerLogic>().canFire(energyCost))
            {
                if (!spawnPt)
                {
                    spawnPt = GameObject.Find("oneSpawn");
                }
                if (willRotate)
                {
                    for (int j = 0; j < numberOfWaves; j++)
                    {
                        StartCoroutine("rotatingWave");
                        if (SoundEffect != null)
                        {
                            SoundEffect.Play(0);
                        }
                        else
                        {
                            Debug.Log("sound effects are null in SingleShot");
                        }
                        yield return new WaitForSeconds(delayBetweenWaves);
                    }
                }
                else
                {
                    for (int j = 0; j < numberOfWaves; j++)
                    {
                        StartCoroutine("wave");
                        if (SoundEffect != null)
                        {
                            SoundEffect.Play(0);
                        }
                        else
                        {
                            Debug.Log("sound effects are null in SingleShot");
                        }
                        yield return new WaitForSeconds(delayBetweenWaves);
                    }
                }
                player.GetComponent<PlayerLogic>().isFiring = false;
            }
        }
        else
        {
            if (!spawnPt)
            {
                spawnPt = GameObject.Find("oneSpawn");
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
            GameObject projectile = Instantiate(bullet, spawnPt.transform.position + bulletOffsetVector, Quaternion.identity) as GameObject;
            //projectile.transform.rotation = Quaternion.Euler(0, 0, 0);
            projectile.transform.rotation = spawnPt.transform.rotation;
            projectile.gameObject.name = "SingleShot";
            Destroy(projectile.gameObject, bulletLife);
            return null;
    }

    IEnumerator rotatingWave()
    {
        while (true)
        {
            // left to right
            for (int i = 0; i < bulletsPerWave; i++)
            {
                GameObject projectile = Instantiate(bullet, spawnPt.transform.position + bulletOffsetVector, Quaternion.identity) as GameObject;
                projectile.transform.rotation = Quaternion.Euler(0, (angleStep * i) - rotationStartingAngle, 0);
                projectile.gameObject.name = "SingleShot";
                yield return new WaitForSeconds(delayBetweenBullets);
                Destroy(projectile.gameObject, bulletLife);
            }
            // right to left
            for (int i = bulletsPerWave; i > 0; i--)
            {
                GameObject projectile = Instantiate(bullet, spawnPt.transform.position + bulletOffsetVector, Quaternion.identity) as GameObject;
                projectile.transform.rotation = Quaternion.Euler(0, (angleStep * i) - rotationStartingAngle, 0);
                projectile.gameObject.name = "SingleShot";
                yield return new WaitForSeconds(delayBetweenBullets);
                Destroy(projectile.gameObject, bulletLife);
            }
        }
        
    }
}