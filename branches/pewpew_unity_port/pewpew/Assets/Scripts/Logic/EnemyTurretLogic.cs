using UnityEngine;
using System.Collections;

public class EnemyTurretLogic : MonoBehaviour
{

    [SerializeField] private Transform player;
    //private Vector3 lookAt = new Vector3(0f, 0f, 0f);
	
	// Update is called once per frame
	void Update () {
        if (player != null)
        {
            transform.LookAt(new Vector3(player.position.x, this.transform.position.y, player.position.z));
        }
	}
}
