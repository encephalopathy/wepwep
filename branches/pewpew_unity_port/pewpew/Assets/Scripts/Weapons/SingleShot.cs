using UnityEngine;
using System.Collections;

public class SingleShot : MonoBehaviour
{
    [Tooltip("Use the player/enemy bullet prefabs.")]
    [SerializeField] private GameObject bullet;
    [SerializeField] private string bulletName = "SingleShot";
    [Tooltip("Speed of the bullet.")]
    [SerializeField] private int bulletVelocity = 30;
    [Tooltip("Amount of time before the bullet is destroyed automatically.")]
    [SerializeField] private float bulletLife = 5f;
    [SerializeField] private int bulletDamage = 10;
    [Tooltip("Game object whose forward Z vector determines which direction the bullets travel.")]
    [SerializeField] private GameObject spawnPt;
    [Tooltip("Enemies should not have sound effects unless they are bosses and/or using special weapons.")]
    [SerializeField] private AudioSource SoundEffect;
    //[SerializeField] private float bulletLife = 3f;
    private Transform spawnBullet;
    [Tooltip("Used if you want the bullet to not shoot from exactly where the Spawn Point is.")]
    [SerializeField] private Vector3 bulletOffsetVector = new Vector3(0f, 0f, 0f);
    [Tooltip("The Player game object is only necessary if the player is using the weapon.")]
    [SerializeField] private GameObject player;
    [Tooltip("Only the player will utilize the energy cost.")]
    [SerializeField] private int energyCost = 15;
    [Tooltip("The amount of waves of bullets that will be shot when the weapon is fired once. ie: 3 waves will shoot the weapon 3 times for 1 mouseclick.")]
    [SerializeField] private int numberOfWaves = 3;
    [Tooltip("The length of the delay between each automatically fired wave of bullets. A higher number will result in a longer delay.")]
    [SerializeField] private float delayBetweenWaves = 0.2f; // higher number for a longer delay
    [Tooltip("The delay between each time an enemy fires the weapon. A higher number will result in a longer delay.")]
    [SerializeField] private float enemyFireRateDelay = 2;
    private float aEnemyFireRateDelay;
    [Tooltip("Toggles whether or not the weapon will shoot straight forward or rotate while shooting. Functionality needs testing.")]
    [SerializeField] private bool willRotate = false; // used for if the weapon will be used on a rotating turret on a boss or such
    [Tooltip("The starting angle of rotation when rotating and firing. Value will be subtracted from 0.")]
    [SerializeField] private float rotationStartingAngle = 45f; // starting angle
    [Tooltip("The amount of rotation between each shot.")]
    [SerializeField] private float rotationAngleStep = 5f; // amount of rotation between each shot
    [Tooltip("The total amount of automatically fired bullets per one weapon fire.")]
    [SerializeField] private int bulletsPerWave = 18;
    [Tooltip("The delay between each automatically fired bullet.")]
    [SerializeField] private float delayBetweenBullets = 0.5f;
    //[SerializeField] private bool SingleShotIsPlayerWeapon = true;
    /*private float rotationX = 0;
    private float rotationY = 0;
    private float rotationZ = 0;*/ 

    void start()
    {
        aEnemyFireRateDelay = enemyFireRateDelay;
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
            aEnemyFireRateDelay -= Time.deltaTime;
            if (aEnemyFireRateDelay <= 0)
            {
                StartCoroutine("fireSingle");
                aEnemyFireRateDelay = enemyFireRateDelay;
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
                Debug.Log("SingleShot, no spawnpoint for bullets");
                spawnPt = this.gameObject;
                //spawnPt = GameObject.Find("oneSpawn");
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
        /*if (projectile.transform.eulerAngles.x != 0f)
        {
            rotationX = projectile.transform.eulerAngles.x;
            Debug.Log("rotationX is " + rotationX);
        }
        if (projectile.transform.eulerAngles.y != 0f)
        {
            rotationY = projectile.transform.eulerAngles.y;
            Debug.Log("rotationY is " + rotationY);
        }
        if (projectile.transform.eulerAngles.z != 0f)
        {
            rotationZ = projectile.transform.eulerAngles.z;
            Debug.Log("rotationZ is " + rotationZ);
        }
        projectile.transform.eulerAngles =  new Vector3(spawnPt.transform.eulerAngles.x + rotationX, spawnPt.transform.eulerAngles.y + rotationY, spawnPt.transform.eulerAngles.z + rotationZ);
        //projectile.transform.forward.Set(projectile.transform.eulerAngles.x - rotationX, projectile.transform.eulerAngles.y - rotationY, projectile.transform.eulerAngles.z - rotationZ);
        projectile.transform.forward = new Vector3(0f, 0f, 1f);
        Debug.Log("projectile.transform.eulerAngles is " + projectile.transform.eulerAngles);
        Debug.Log("projectile.transform.forward is " + projectile.transform.forward);*/
        if (transform.parent.tag == "Player")
        {
            projectile.GetComponent<PlayerBulletHelper>().playerBulletDamage = bulletDamage;
            projectile.GetComponent<PlayerBulletHelper>().playerBulletLife = bulletLife;
            projectile.GetComponent<PlayerBulletHelper>().playerBulletVelocity = bulletVelocity;
        }
        else if (transform.parent.tag == "Enemy" || transform.parent.tag == "Boss" || transform.parent.tag == "BossPart")
        {
            projectile.GetComponent<BulletHelper>().enemyBulletDamage = bulletDamage;
            projectile.GetComponent<BulletHelper>().enemyBulletLife = bulletLife;
            projectile.GetComponent<BulletHelper>().enemyBulletVelocity = bulletVelocity;
        }
        projectile.transform.rotation = spawnPt.transform.rotation;
        projectile.gameObject.name = bulletName;
        //Destroy(projectile.gameObject, bulletLife);
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
                projectile.transform.rotation = Quaternion.Euler(0, (rotationAngleStep * i) - rotationStartingAngle, 0);
                projectile.gameObject.name = "SingleShot";
                yield return new WaitForSeconds(delayBetweenBullets);
                //Destroy(projectile.gameObject, bulletLife);
            }
            // right to left
            for (int i = bulletsPerWave; i > 0; i--)
            {
                GameObject projectile = Instantiate(bullet, spawnPt.transform.position + bulletOffsetVector, Quaternion.identity) as GameObject;
                projectile.transform.rotation = Quaternion.Euler(0, (rotationAngleStep * i) - rotationStartingAngle, 0);
                projectile.gameObject.name = "SingleShot";
                yield return new WaitForSeconds(delayBetweenBullets);
                //Destroy(projectile.gameObject, bulletLife);
            }
        }
        
    }
}