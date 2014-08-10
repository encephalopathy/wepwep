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
    public Vector3 bulletOffSetVector = new Vector3(1f, 0f, 0f);
    public GameObject player;
    public int energyCost = 15;
    public float delayBetweenWaves = 0.2f; // higher number for a longer delay
    public int numberOfWaves = 3;

    void Update()
    {
        if (Input.GetButtonDown("Fire1"))
        {
            StartCoroutine("fireSingle");
        }
    }

    IEnumerator fireSingle()
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

    IEnumerator wave()
    {
            GameObject projectile1 = Instantiate(bullet, spawnPt.transform.position + bulletOffSetVector, Quaternion.identity) as GameObject;
            GameObject projectile2 = Instantiate(bullet, spawnPt.transform.position - bulletOffSetVector, Quaternion.identity) as GameObject;
            projectile1.transform.rotation = Quaternion.Euler(0, 0, 0);
            projectile2.transform.rotation = Quaternion.Euler(0, 0, 0);
            projectile1.gameObject.name = "SingleShot";
            projectile2.gameObject.name = "SingleShot";
            Destroy(projectile1.gameObject, bulletLife);
            Destroy(projectile2.gameObject, bulletLife);
            return null;
    }
}
