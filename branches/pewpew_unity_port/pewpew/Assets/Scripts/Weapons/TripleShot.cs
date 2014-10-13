using UnityEngine;
using System.Collections;

public class TripleShot : MonoBehaviour
{
    [SerializeField] private GameObject bullet;
    [SerializeField] private float velocity = 10.0f;
    [SerializeField] private GameObject spawnPt;
    [SerializeField] private AudioSource pew;
    [SerializeField] private float BulletLife = 3f;
    [SerializeField] private float bulletSpread = 30f;
    [SerializeField] private int numberOfBullets = 3;
    [SerializeField] private Vector3 tmpVector = new Vector3(0f, 0f, 0f);
    [SerializeField] private GameObject player;
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
                StartCoroutine("fireSpread");
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

    IEnumerator fireSpread()
    {
        if (transform.parent.tag == "Player")
        {
            if (player.GetComponent<PlayerLogic>().canFire(15))
            {
                if (!spawnPt)
                {
                    spawnPt = GameObject.Find("oneSpawn");
                }
                for (int j = 0; j < 3; j++)
                {
                    StartCoroutine("wave");
                    pew.Play(0);
                    yield return new WaitForSeconds(.2f);
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
            for (int j = 0; j < 3; j++)
            {
                StartCoroutine("wave");
                pew.Play(0);
                yield return new WaitForSeconds(.2f);
            }
        }
    }

    IEnumerator wave()
    {
        float angle = (bulletSpread / (numberOfBullets - 1));
        for (int i = 0; i < numberOfBullets; i++)
        {
            GameObject projectile = Instantiate(bullet, spawnPt.transform.position + tmpVector, Quaternion.identity) as GameObject;
            projectile.transform.rotation = Quaternion.Euler(0, (angle * i) - (bulletSpread / 2), 0);
            projectile.gameObject.name = "TripleShot";
            Destroy(projectile.gameObject, BulletLife);
        }
        return null;
    }
}
