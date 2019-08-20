using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Black_hole_missile_manager : MonoBehaviour
{
    GameObject black_hole_copy;

    GameObject missile;
    GameObject missile_copy;
    missile_controller script;
    Black_Hole_controller bh_script;

    [System.NonSerialized]
    public bool missile_switch;

    [System.NonSerialized]
    public bool explosion_switch;

    
    

    // Start is called before the first frame update
    void Start()
    {
        missile = (GameObject)Resources.Load("Missile");
        missile_switch = true;
        explosion_switch = false;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            missile_copy = Instantiate(missile, new Vector3(0.0f, -12.0f, 0.0f), Quaternion.identity);
            script = missile_copy.GetComponent<missile_controller>();
            // マウス位置座標を格納する
            script.position = Input.mousePosition;
        }
    }

    

   
}
