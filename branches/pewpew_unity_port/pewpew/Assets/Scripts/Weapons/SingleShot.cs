using UnityEngine;
using System.Collections;

public class SingleShot : MonoBehaviour
{
    [SerializeField] private GameObject bullet;
    [SerializeField] private float bulletSpeed = 10.0f; //currently unused
    [SerializeField] private GameObject spawnPt;
    [SerializeField] private AudioSource SoundEffect;
    [SerializeField] private float bulletLife = 3f;
    private Transform spawnBullet;
    [SerializeField] private Vector3 bulletOffsetVector = new Vector3(0f, 0f, 0f);
    [SerializeField] private GameObject player;
    [SerializeField] private int energyCost = 15;
    [SerializeField] private float delayBetweenWaves = 0.2f; // higher number for a longer delay
    [SerializeField] private int numberOfWaves = 3;
    [SerializeField] private bool willRotate = false; // used for if the weapon will be used on a rotating turret on a boss or such
    [SerializeField] private float rotationStartingAngle = 45f; // starting angle
    [SerializeField] private float angleStep = 5f; // amount of rotation between each shot
    [SerializeField] private int bulletsPerWave = 18;
    [SerializeField] private float delayBetweenBullets = 0.5f;
    //[SerializeField] private bool SingleShotIsPlayerWeapon = true;
    [SerializeField] private float enemyFireRate = 2;
    private float aEnemyFireRate;

    void start()
    {
        aEnemyFireRate = enemyFireRate;
    }

    void Update()
    {
        //if (SingleShotIsPlayerWeapon)
        if (transform.parent.tag == "Player")
        {
            if (Input.GetButtonDown("Fire1"))
            {
                StartCoroutine("fireSingle");
            }
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss")
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
        //if (SingleShotIsPlayerWeapon)
        if (transform.parent.tag == "Player")
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
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss")
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