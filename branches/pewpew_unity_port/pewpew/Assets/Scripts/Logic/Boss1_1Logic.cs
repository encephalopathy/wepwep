using UnityEngine;
using System.Collections;

public class Boss1_1Logic : EnemyLogic {

    private int phase;
    private int subPhase;
    [SerializeField] private GameObject boss;
    [SerializeField] private GameObject LeftTurret;
    [SerializeField] private GameObject RightTurret;
    [SerializeField] private GameObject LeftBooster;
    [SerializeField] private GameObject RightBooster;
    [SerializeField] private float subPhaseDuration = 5;
    [SerializeField] private float phase1HPCondition = 0.6f;
    [SerializeField] private float phase2HPCondition = 0.3f;

	// Use this for initialization
	void Start ()
    {
        //CurrentHealth = 1000;
        phase = 1;
        subPhase = 1;
	}
	
	// Update is called once per frame
	void Update () {
        subPhaseDuration -= Time.deltaTime;
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
                        subPhase2Attacks();
                    }
                    else if (subPhase == 2)
                    {
                        subPhase = 1;
                        subPhase1Attacks();
                    }
                    subPhaseDuration = 5;
                }
            }
            else
            {
                phaseChange1And2To3And4();
            }
        }
        else if (phase == 2)
        {
            if (subPhaseDuration <= 0)
            {
                if (subPhase == 3)
                {
                    subPhase = 4;
                    subPhase4Attacks();
                }
                else if (subPhase == 4)
                {
                    subPhase = 3;
                    subPhase3Attacks();
                }
                subPhaseDuration = 5;
            }
        }
	}

    void phaseChange1And2To3And4()
    {
        phase = 2;
        subPhase = 3;
        subPhase3Attacks();
        RightTurret.GetComponent<SingleShot>().enabled = false;
        LeftTurret.GetComponent<SingleShot>().enabled = false;
        RightTurret.GetComponent<DoubleShot>().enabled = false;
        LeftTurret.GetComponent<DoubleShot>().enabled = false;
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
}