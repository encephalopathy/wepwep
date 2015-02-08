using UnityEngine;
using System.Collections;

public class ItemDropLogic : MonoBehaviour {

    [SerializeField] private GameObject itemType;

	public void SpawnItem ()
    {
        //Debug.Log("itemDropLogic, inside SpawnItem");
        Instantiate(itemType, this.gameObject.transform.position, Quaternion.identity);
    }
}