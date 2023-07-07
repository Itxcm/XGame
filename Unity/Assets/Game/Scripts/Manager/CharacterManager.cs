using UnityEngine;
using XClient;

public class CharacterManager : MonoSingleton<CharacterManager>
{
    private GameObject curGo;
    private void Awake()
    {


        curGo = transform.GetChild(0).gameObject;
    }


}