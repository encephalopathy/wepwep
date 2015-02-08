using UnityEngine;
using System.Collections;

public class Boss1_1Logic : EnemyLogic {

    private int phase;
    private int subPhase;
    private bool changingPhase = false;
    [SerializeField] private GameObject boss;
    [SerializeField] private GameObject LeftTurret;
    [SerializeField] private GameObject RightTurret;
    [SerializeField] private GameObject LeftBooster;
    [SerializeField] private GameObject RightBooster;
    [SerializeField] private GameObject player;
    [SerializeField] private float initialSubPhaseDuration = 5;
    private float subPhaseDuration;
    [SerializeField] private float phase1HPCondition = 0.6f;
    [SerializeField] private float phase2HPCondition = 0.3f;

	// Use this for initialization
	void Start ()
    {
        //CurrentHealth = 1000;
        phase = 1;
        subPhase = 1;
        subPhaseDuration = initialSubPhaseDuration;
	}
	
	// Update is called once per frame
	void Update () {
        subPhaseDuration -= Time.deltaTime;

        if (player.GetComponent<BombWeapon>().bombActivated == true)
        {
            //Debug.Log("boss1_1logic, bombActivated is true inside update");
            bombStun();
        }
        else if (player.GetComponent<BombWeapon>().bombActivated == false)
        {
            if (phase == 1)
            {
                if (subPhase == 1)
                {
                    subPhase1Attacks();
                }
                else if (subPhase == 2)
                {
                    subPhase2Attacks();
                }
            }
            else if (phase == 2)
            {
                if (subPhase == 3)
                {
                    subPhase3Attacks();
                }
                else if (subPhase == 4)
                {
                    subPhase4Attacks();
                }
            }
        }

        if (phase == 1)
        {
            if (RightBooster == null && LeftBooster == null)
            {
                phaseChange1And2To3And4();
            }
            else if ((boss.GetComponent<EnemyLogic>().CurrentHealth > (boss.GetComponent<EnemyLogic>().MaxHealth * phase1HPCondition)))
            //else if ((CurrentHealth > (MaxHealth * phase1HPCondition)))
            {
                if (subPhaseDuration <= 0)
                {
                    if (subPhase == 1)
                    {
                        subPhase = 2;
                        if (player.GetComponent<BombWeapon>().bombActivated == false)
                        {
                            subPhase2Attacks();
                        }
                    }
                    else if (subPhase == 2)
                    {
                        subPhase = 1;
                        if (player.GetComponent<BombWeapon>().bombActivated == false)
                        {
                            subPhase1Attacks();
                        }
                    }
                    subPhaseDuration = initialSubPhaseDuration;
                }
            }
            else
            {
                phaseChange1And2To3And4();
            }
        }
        else if (phase == 2)
        {
            if (changingPhase)
            {
                // code for switching splines
                // enable the next set of weapons as well
                if (subPhaseDuration <= 0)
                {
                    changingPhase = false;
                    subPhaseDuration = initialSubPhaseDuration;
                }
            }
            else if (subPhaseDuration <= 0)
            {
                if (subPhase == 3)
                {
                    subPhase = 4;
                    if (player.GetComponent<BombWeapon>().bombActivated == false)
                    {
                        subPhase4Attacks();
                    }
                }
                else if (subPhase == 4)
                {
                    subPhase = 3;
                    if (player.GetComponent<BombWeapon>().bombActivated == false)
                    {
                        subPhase3Attacks();
                    }
                }
                subPhaseDuration = initialSubPhaseDuration;
            }
        }
        

	}

    void phaseChange1And2To3And4()
    {
        phase = 2;
        subPhase = 3;
        //subPhase3Attacks();
        RightTurret.GetComponent<SingleShot>().enabled = false;
        LeftTurret.GetComponent<SingleShot>().enabled = false;
        RightTurret.GetComponent<DoubleShot>().enabled = false;
        LeftTurret.GetComponent<DoubleShot>().enabled = false;
        changingPhase = true;
    }

    void subPhase1Attacks()
    {
        RightTurret.GetComponent<SingleShot>().enabled = true;
        LeftTurret.GetComponent<SingleShot>().enabled = true;
        RightTurret.GetComponent<DoubleShot>().enabled = false;
        LeftTurret.GetComponent<DoubleShot>().enabled = false;
    }

    void subPhase2Attacks()
    {
        RightTurret.GetComponent<SingleShot>().enabled = false;
        LeftTurret.GetComponent<SingleShot>().enabled = false;
        RightTurret.GetComponent<DoubleShot>().enabled = true;
        LeftTurret.GetComponent<DoubleShot>().enabled = true;
    }

    void subPhase3Attacks()
    {
        RightTurret.GetComponent<SpreadShot>().enabled = false;
        LeftTurret.GetComponent<SpreadShot>().enabled = false;
        RightTurret.GetComponent<CircleShot>().enabled = true;
        LeftTurret.GetComponent<CircleShot>().enabled = true;
    }

    void subPhase4Attacks()
    {
        RightTurret.GetComponent<SpreadShot>().enabled = true;
        LeftTurret.GetComponent<SpreadShot>().enabled = true;
        RightTurret.GetComponent<CircleShot>().enabled = false;
        LeftTurret.GetComponent<CircleShot>().enabled = false;
    }

    void bombStun()
    {
        //Debug.Log("boss1_1logic, boss stunned");
        RightTurret.GetComponent<SpreadShot>().enabled = false;
        LeftTurret.GetComponent<SpreadShot>().enabled = false;
        RightTurret.GetComponent<CircleShot>().enabled = false;
        LeftTurret.GetComponent<CircleShot>().enabled = false;
        RightTurret.GetComponent<SingleShot>().enabled = false;
        LeftTurret.GetComponent<SingleShot>().enabled = false;
        RightTurret.GetComponent<DoubleShot>().enabled = false;
        LeftTurret.GetComponent<DoubleShot>().enabled = false;
    }
}