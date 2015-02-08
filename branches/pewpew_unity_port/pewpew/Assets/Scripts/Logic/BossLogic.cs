 using UnityEngine;
using System.Collections;

public class BossLogic : EnemyLogic
{
    [SerializeField] private GameObject player;

    public override void Die()
    {
        base.Die();
        player.GetComponent<PlayerLogic>().isPlayerInvincible = true;
        //Debug.Log("Boss, Die");
    }
}