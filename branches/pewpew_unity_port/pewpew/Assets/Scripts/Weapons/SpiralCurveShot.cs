using UnityEngine;
using System.Collections;

public class SpiralCurveShot : MonoBehaviour
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
    public int numberOfWaves = 99;
    private int angleShiftValue = 0;
    public int angleShiftIncrement = 7;

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
                SoundEffect.Play(0);
                yield return new WaitForSeconds(delayBetweenWaves);
            }
            player.GetComponent<PlayerLogic>().isFiring = false;

        }
    }

    IEnumerator wave()
    {
        float angleStep = (firingAngle/(numberOfBullets - 1));

        for (int i = 1; i <= numberOfBullets; i++)
        {
            //float rotationAngle = firingAngle/2 - ((i - 1) * angleStep - angleShiftValue);
            float rotationAngle = -i * angleStep - angleShiftValue;
            GameObject projectile = Instantiate(bullet, spawnPt.transform.position + bulletOffsetVector, Quaternion.identity) as GameObject;
            projectile.transform.rotation = Quaternion.Euler(0, rotationAngle, 0);
            projectile.gameObject.name = "SpiralCurveShot";
            Destroy(projectile.gameObject, bulletLife);
            angleShiftValue = angleShiftValue + angleShiftIncrement;
        }
        return null;
    }
}
