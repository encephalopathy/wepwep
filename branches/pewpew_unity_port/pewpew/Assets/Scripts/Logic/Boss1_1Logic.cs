using UnityEngine;
using System.Collections;
using UnityEditor;

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
    //[SerializeField] private float phase2HPCondition = 0.3f;
    private bool hasRotated = false;

	// Use this for initialization
	void Start ()
    {
        //CurrentHealth = 1000;
        phase = 1;
        subPhase = 1;
        subPhaseDuration = initialSubPhaseDuration;
        boss.transform.Rotate(new Vector3(0f, 0f, 180f));
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
                startPhaseChange();
            }
            else if ((boss.GetComponent<BossLogic>().CurrentHealth > (boss.GetComponent<BossLogic>().MaxHealth * phase1HPCondition)))
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
                startPhaseChange();
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
                    //boss.transform.eulerAngles = new Vector3(0f, 180f, 0f);
                    if (!hasRotated)
                    {
                        boss.transform.Rotate(new Vector3(0f, 0f, 180f));
                        hasRotated = true;
                    }
                }
                /*if (subPhaseDuration <= -10)
                {
                    changingPhase = false;
                    subPhaseDuration = initialSubPhaseDuration;
                    endPhaseChange();
                }*/
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

    void startPhaseChange()
    {
        Debug.Log("Boss 1-1, changing phases");
        phase = 2;
        subPhase = 3;
        //subPhase3Attacks();
        RightTurret.GetComponent<SingleShot>().enabled = false;
        LeftTurret.GetComponent<SingleShot>().enabled = false;
        RightTurret.GetComponent<DoubleShot>().enabled = false;
        LeftTurret.GetComponent<DoubleShot>().enabled = false;
        RightTurret.GetComponent<SpreadShot>().enabled = false;
        LeftTurret.GetComponent<SpreadShot>().enabled = false;
        RightTurret.GetComponent<CircleShot>().enabled = false;
        LeftTurret.GetComponent<CircleShot>().enabled = false;
        changingPhase = true;
        boss.GetComponentInParent<EnemySplineController>().SplineToExecute = 1;
        Debug.Log("Boss 1-1 Logic, splineToExecute is " + boss.GetComponentInParent<EnemySplineController>().SplineToExecute + " before SetDirty");
        boss.GetComponentInParent<EnemySplineController>().WrapMode = eWrapMode.ONCE;
    }

    void endPhaseChange()
    {
        Debug.Log("Boss 1-1, ending phase change");
        boss.GetComponentInParent<EnemySplineController>().SplineToExecute = 0;
        boss.GetComponentInParent<EnemySplineController>().WrapMode = eWrapMode.LOOP;
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