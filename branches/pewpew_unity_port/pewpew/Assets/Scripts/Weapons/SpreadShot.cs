using UnityEngine;
using System.Collections;

public class SpreadShot : MonoBehaviour
{

    public GameObject bullet;
    public float bulletSpeed = 10.0f; //currently unused
    public GameObject spawnPt;
    public AudioSource SoundEffect;
    public float bulletLife = 3f;
    public float firingAngle = 30f;
    public int numberOfBullets = 3;
    private Transform spawnBullet;
    public Vector3 bulletOffsetVector = new Vector3(0f, 0f, 0f);
    public GameObject player;
    public int energyCost = 15;
    public float delayBetweenWaves = 0.2f; // higher number for a longer delay
    public int numberOfWaves = 3;
    public int numberOfArcs = 2;
    public float angleBetweenArcs = 10f;
    public bool willRotate = false; // used for if the weapon will be used on a rotating turret on a boss or such
    public float rotationStartingAngle = 45f; // starting angle
    public float angleStep = 5f; // amount of rotation between each shot
    public int bulletsPerWave = 18;
    public float delayBetweenBullets = 0.5f;

    void Update()
    {
        if (Input.GetButtonDown("Fire1"))
        {
            StartCoroutine("fireSpread");
        }
    }

    IEnumerator fireSpread()
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
        float angleStep = ((firingAngle - (angleBetweenArcs * (numberOfArcs - 1 ))) / (numberOfBullets - 1));
        float bulletsPerArc = Mathf.Ceil(numberOfBullets / numberOfArcs);

        for (int i = 1; i <= numberOfBullets; i++)
        {
            float rotationAngle = firingAngle/2 - ((i - 1) * angleStep) - ((Mathf.Ceil(i / bulletsPerArc) - 1) * angleBetweenArcs);
            GameObject projectile = Instantiate(bullet, spawnPt.transform.position + bulletOffsetVector, Quaternion.identity) as GameObject;
            projectile.transform.rotation = Quaternion.Euler(0, rotationAngle, 0);
            projectile.gameObject.name = "SpreadShot";
            Destroy(projectile.gameObject, bulletLife);
        }
        return null;
    }
}
