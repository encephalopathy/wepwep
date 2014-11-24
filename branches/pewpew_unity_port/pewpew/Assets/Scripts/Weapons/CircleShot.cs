using UnityEngine;
using System.Collections;

public class CircleShot : MonoBehaviour
{
    [SerializeField] private GameObject bullet;
    [SerializeField] private float bulletSpeed = 10.0f; //currently unused
    [SerializeField] private GameObject spawnPt;
    [SerializeField] private AudioSource SoundEffect;
    [SerializeField] private float bulletLife = 3f;
    [SerializeField] private float firingAngle = 360f;
    [SerializeField] private int numberOfBullets = 90;
    [SerializeField] private Vector3 bulletOffsetVector = new Vector3(0f, 0f, 0f);
    [SerializeField] private GameObject player;
    [SerializeField] private int energyCost = 15;
    [SerializeField] private float delayBetweenWaves = 0.2f; // higher number for a longer delay
    [SerializeField] private int numberOfWaves = 1;
    [SerializeField] private float enemyFireRate = 2;
    private float aEnemyFireRate;

    void start()
    {
        aEnemyFireRate = enemyFireRate;
    }

    void Update()
    {
        if (transform.parent.tag == "Player")
        {
            if (Input.GetButtonDown("Fire1"))
            {
                StartCoroutine("fireCircle");
            }
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss")
        {
            aEnemyFireRate -= Time.deltaTime;
            if (aEnemyFireRate <= 0)
            {
                StartCoroutine("fireCircle");
                aEnemyFireRate = enemyFireRate;
            }
        }
    }

    IEnumerator fireCircle()
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