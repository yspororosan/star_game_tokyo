using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class tera_controller : MonoBehaviour
{
    float gravityConst_max = 10.0f;    // 定数(=GMm)のパラメータ

    GameObject Enemy;

    List<GameObject> enemy_list;

    // Start is called before the first frame update
    void Start()
    {
        enemy_list = GameObject.Find("Object_Manager").GetComponent<Enemy_manager>().enemy_list;
    }

    // Update is called once per frame
    void Update()
    {
        Attraction();
    }

    void Attraction() // 引力の関数
    {
        foreach (GameObject enemy_copy in enemy_list)
        {
            //float attraction_distance = Vector3.Distance(transform.position, enemy_copy.transform.position);

            Vector3 distance = transform.position - enemy_copy.transform.position;                   // 2物体間の距離(座標)
            Vector3 forceObject = gravityConst_max * distance / Mathf.Pow(distance.magnitude, 3);    // 移動する物体にかかる力
            enemy_copy.GetComponent<Rigidbody>().AddForce(forceObject, ForceMode.Force);             // 物体にかける力
            
        }
    }
}
