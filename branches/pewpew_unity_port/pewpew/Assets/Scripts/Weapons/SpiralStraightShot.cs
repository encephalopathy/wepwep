using UnityEngine;
using System.Collections;

public class SpiralStraightShot : MonoBehaviour
{

    public GameObject bullet;
    public float velocity = 10.0f;
    public GameObject spawnPt;
    public AudioSource pew;
    public float BulletLife = 3f;
    private float angle = 360f;
    public int numberOfBullets = 90;
    public int numberOfWaves = 5;
    private Transform spawnBullet;
    private Vector3 tmpVector = new Vector3(0f, 0f, 0f);
    public GameObject player;
    public bool clockwise = true;
    public int energyCost = 75;

    void Update()
    {
        if (Input.GetButtonDown("Fire1"))
        {
            StartCoroutine("fireCircle");
        }
    }

    IEnumerator fireCircle()
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
                Destroy(projectile.gameObject, BulletLife);
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
                Destroy(projectile.gameObject, BulletLife);
            }
        }
    }
}
