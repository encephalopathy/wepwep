using UnityEngine;
using System.Collections;

public class SpiralStraightShot : MonoBehaviour
{
    [SerializeField] private GameObject bullet;
    [SerializeField] private float velocity = 10.0f;
    [SerializeField] private GameObject spawnPt;
    [SerializeField] private AudioSource pew;
    //[SerializeField] private float BulletLife = 3f;
    [SerializeField] private float angle = 360f;
    [SerializeField] private int numberOfBullets = 90;
    [SerializeField] private int numberOfWaves = 5;
    [SerializeField] private Vector3 tmpVector = new Vector3(0f, 0f, 0f);
    [SerializeField] private GameObject player;
    [SerializeField] private bool clockwise = true;
    [SerializeField] private int energyCost = 75;
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
                StartCoroutine("spiralStraight");
            }
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss")
        {
            aEnemyFireRate -= Time.deltaTime;
            if (aEnemyFireRate <= 0)
            {
                StartCoroutine("spiralStraight");
                aEnemyFireRate = enemyFireRate;
            }
        }
    }

    IEnumerator spiralStraight()
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
                    yield return new WaitForSeconds(.5f);
                }
                pew.Play(0);
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
            }
        }
    }

    IEnumerator wave()
    {
        float angleStep = (angle/(numberOfBullets - 1));
        if (clockwise == true)
        {
            for (int i = 0; i < numberOfBullets; i++)
            {
                GameObject projectile = Instantiate(bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
                projectile.transform.rotation = Quaternion.Euler(0, (angleStep * i) - (angle / 2), 0);
                projectile.gameObject.name = "SpiralStraightShot";
                yield return new WaitForSeconds(.001f);
                //Destroy(projectile.gameObject, BulletLife);
            }
        }
        else
        {
            for (int i = numberOfBullets; i > 0; i--)
            {
                GameObject projectile = Instantiate(bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
                projectile.transform.rotation = Quaternion.Euler(0, (angleStep * i) - (angle / 2), 0);
                projectile.gameObject.name = "SpiralStraightShot";
                yield return new WaitForSeconds(.001f);
                //Destroy(projectile.gameObject, BulletLife);
            }
        }
    }
}
