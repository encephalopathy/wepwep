using UnityEngine;
using System.Collections;

public class ShakeCamera : MonoBehaviour
{
    public bool Shaking;
    public GameObject redScreen;
	public float shakeDecay = 0.02f; 
    public float shakeIntensity = 0.3f;

	private float ShakeDecay; 
	private float ShakeIntensity;

    private Vector3 OriginalPos;
    private Quaternion OriginalRot;

    void Start()
    {
        Shaking = false;
    }


    // Update is called once per frame
    void Update()
    {
        if (ShakeIntensity > 0)
        {
            transform.position = OriginalPos + Random.insideUnitSphere * ShakeIntensity;
            transform.rotation = new Quaternion(OriginalRot.x + Random.Range(-ShakeIntensity, ShakeIntensity) * .2f,
                                      OriginalRot.y + Random.Range(-ShakeIntensity, ShakeIntensity) * .2f,
                                      OriginalRot.z + Random.Range(-ShakeIntensity, ShakeIntensity) * .2f,
                                      OriginalRot.w + Random.Range(-ShakeIntensity, ShakeIntensity) * .2f);

            ShakeIntensity -= ShakeDecay;
        }
        else if (Shaking)
        {
            Shaking = false;
			transform.position = new Vector3(this.transform.parent.position.x, this.transform.parent.position.y + 28.75318f, this.transform.parent.position.z);
            transform.rotation = new Quaternion(0, 0, 0, 0);
			transform.Rotate(90,0,0);
            redScreen.renderer.enabled = false;
        }

    }

    public void DoShake()
    {
        OriginalPos = transform.position;
        OriginalRot = transform.rotation;

        ShakeIntensity = shakeIntensity;
        ShakeDecay = shakeDecay;
        Shaking = true;
        redScreen.renderer.enabled = true;
    }
}