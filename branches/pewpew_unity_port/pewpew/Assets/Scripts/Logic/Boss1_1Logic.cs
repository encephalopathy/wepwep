using UnityEngine;
using System.Collections;

public class Boss1_1Logic : EnemyLogic {

    private int phase = 1;
    [SerializeField] private GameObject LeftTurret;
    [SerializeField] private GameObject RightTurret;
    [SerializeField] private float phaseDuration = 5;

	// Use this for initialization
	void Start ()
    {
        phase = 1;
	}
	
	// Update is called once per frame
	void Update () {
        phaseDuration -= Time.deltaTime;
        if (phaseDuration <= 0)
        {
            if (phase == 1)
            {
                phase = 2;
                phase2Attacks();
            }
            else if (phase == 2)
            {
                phase = 1;
                phase1Attacks();
            }
            phaseDuration = 5;
        }
	}

    void phase1Attacks()
    {
        RightTurret.GetComponent<SingleShot>().enabled = true;
        LeftTurret.GetComponent<SingleShot>().enabled = true;
        RightTurret.GetComponent<DoubleShot>().enabled = false;
        LeftTurret.GetComponent<DoubleShot>().enabled = false;
    }

    void phase2Attacks()
    {
        RightTurret.GetComponent<SingleShot>().enabled = false;
        LeftTurret.GetComponent<SingleShot>().enabled = false;
        RightTurret.GetComponent<DoubleShot>().enabled = true;
        LeftTurret.GetComponent<DoubleShot>().enabled = true;
    }

    void phase3Attacks()
    {

    }

    void phase4Attacks()
    {

    }
}

