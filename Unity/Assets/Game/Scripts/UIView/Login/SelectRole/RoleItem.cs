using SkillBridge.Message;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RoleItem : MonoBehaviour
{
    public Text Name;
    public Text Level;

    /// <summary>
    /// …Ë÷√–≈œ¢
    /// </summary>
    /// <param name="info"></param>
    public void SetInfo(NCharacterInfo info)
    {
        Name.text = info.Name;
        Level.text = info.Level.ToString();
    }
}
