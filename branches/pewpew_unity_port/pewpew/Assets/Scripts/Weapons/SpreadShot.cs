using UnityEngine;
using System.Collections;

public class SpreadShot : MonoBehaviour
{
    [SerializeField] private GameObject bullet;
    [SerializeField] private float bulletSpeed = 10.0f; //currently unused
    [SerializeField] private GameObject spawnPt;
    [SerializeField] private AudioSource SoundEffect;
    //[SerializeField] private float bulletLife = 3f;
    [SerializeField] private float firingAngle = 30f;
    [SerializeField] private int numberOfBullets = 3;
    [SerializeField] private Vector3 bulletOffsetVector = new Vector3(0f, 0f, 0f);
    [SerializeField] private GameObject player;
    [SerializeField] private int energyCost = 15;
    [SerializeField] private float delayBetweenWaves = 0.2f; // higher number for a longer delay
    [SerializeField] private int numberOfWaves = 3;
    [SerializeField] private int numberOfArcs = 1;
    [SerializeField] private float angleBetweenArcs = 10f;
    [SerializeField] private bool willRotate = false; // used for if the weapon will be used on a rotating turret on a boss or such
    [SerializeField] private float rotationStartingAngle = 45f; // starting angle
    [SerializeField] private float rotationAngleStep = 5f; // amount of rotation between each shot
    [SerializeField] private int bulletsPerWave = 18;
    [SerializeField] private float delayBetweenBullets = 0.5f;
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
                StartCoroutine("fireSpread");
                aEnemyFireRate = enemyFireRate;
            }
        }
    }

    IEnumerator fireSpread()
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
        float angleStep = ((firingAngle - (angleBetweenArcs * (numberOfArcs - 1))) / (numberOfBullets - 1));
        //Debug.Log("Spreadshot: anglestep is " + angleStep);
        float bulletsPerArc = Mathf.Ceil(numberOfBullets / numberOfArcs);

        for (int i = 1; i <= numberOfBullets; i++)
        {
            //float rotationAngle = firingAngle/2 - ((i - 1) * angleStep) - ((Mathf.Ceil(i / bulletsPerArc) - 1) * angleBetweenArcs);
            float rotationAngle = (-1 * firingAngle / 2 + ((i - 1) * angleStep) + ((Mathf.Ceil(i / bulletsPerArc) - 1) * angleBetweenArcs)) + transform.eulerAngles.y;
            GameObject projectile = Instantiate(bullet, spawnPt.transform.position, Quaternion.identity) as GameObject;
            projectile.transform.rotation = Quaternion.Euler(spawnPt.transform.rotation.x, rotationAngle, spawnPt.transform.rotation.z);
            projectile.gameObject.name = "SpreadShot";
            //Destroy(projectile.gameObject, bulletLife);
        }
        return null;
    }
}