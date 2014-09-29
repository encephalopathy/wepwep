using UnityEngine;
using System.Collections;

public class CircleShot : MonoBehaviour
{

    public GameObject bullet;
    public float bulletSpeed = 10.0f; //currently unused
    public GameObject spawnPt;
    public AudioSource SoundEffect;
    public float bulletLife = 3f;
    private float firingAngle = 360f;
    public int numberOfBullets = 90;
    private Transform spawnBullet;
    public Vector3 bulletOffsetVector = new Vector3(0f, 0f, 0f);
    public GameObject player;
    public int energyCost = 15;
    public float delayBetweenWaves = 0.2f; // higher number for a longer delay
    public int numberOfWaves = 1;
    public bool isPlayerWeapon = true;
    public float enemyFireRate = 2;
    private float aEnemyFireRate;

    void start()
    {
        aEnemyFireRate = enemyFireRate;
    }

    void Update()
    {
        if (isPlayerWeapon)
        {
            if (Input.GetButtonDown("Fire1"))
            {
                StartCoroutine("fireCircle");
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

    IEnumerator fireCircle()
    {
        if (isPlayerWeapon)
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
        else
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
        float angleStep = (firingAngle/(numberOfBullets - 1));

        for (int i = 1; i <= numberOfBullets; i++)
        {
            float rotationAngle = firingAngle/2 - ((i - 1) * angleStep);
            GameObject projectile = Instantiate(bullet, spawnPt.transform.position + bulletOffsetVector, Quaternion.identity) as GameObject;
            projectile.transform.rotation = Quaternion.Euler(0, rotationAngle, 0);
            projectile.gameObject.name = "CircleShot";
            Destroy(projectile.gameObject, bulletLife);
        }
        return null;
    }
}
