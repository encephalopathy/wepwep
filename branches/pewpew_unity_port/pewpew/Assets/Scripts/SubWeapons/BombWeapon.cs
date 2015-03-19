using UnityEngine;
using System.Collections;

public class BombWeapon : MonoBehaviour {

    [SerializeField] private GameObject bomb;
    [SerializeField] private int ammo = 3;
    [SerializeField] private int bombDamage = 10;
    [SerializeField] private float bombLife = 2f;
    //[SerializeField] private float delayBetweenBombs = 0.5f;
    [SerializeField] private Vector3 spawnPoint = new Vector3(0, 2, 0);
    [SerializeField] private AudioSource SoundEffect;
    public bool bombActivated = false;

	// Use this for initialization
	void Start () {
	    
	}
	
	// Update is called once per frame
	void Update () {
        if (Input.GetButtonUp("Fire2"))
        {
            if (ammo != 0)
            {
                StartCoroutine("fireBomb");
                ammo--;
            }
        }
	}

    IEnumerator fireBomb()
    {
        StartCoroutine("wave");
        if (SoundEffect != null)
        {
            SoundEffect.Play(0);
        }
        else
        {
            Debug.Log("sound effects are null in BombWeapon");
        }
        bombActivated = true;
        yield return new WaitForSeconds(bombLife);
        //Debug.Log("bombWeapon: after yield, bombActivated is " + bombActivated);
        bombActivated = false;
        //Debug.Log("bombWeapon: after call, bombActivated is " + bombActivated);
    }

    IEnumerator wave()
    {
        GameObject projectile = Instantiate(bomb, spawnPoint, Quaternion.identity) as GameObject;
        projectile.gameObject.name = "Bomb";
        projectile.gameObject.GetComponent<PlayerBombHelper>().damage = bombDamage;
        Destroy(projectile.gameObject, bombLife);
        return null;
    }
}
