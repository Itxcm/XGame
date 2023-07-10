using SkillBridge.Message;
using System;
using System.Collections;
using UnityEngine;
using XClient;

public class CharacterView : MonoSingleton<CharacterView>
{
    private GameObject _curActive;

    /// <summary>
    ///  ������ʾ��ɫ����
    /// </summary>
    /// <param name="index"></param>
    public void SetRoloIndex(int index)
    {
        if (_curActive != null && _curActive.activeSelf)
        {
            _curActive.SetActive(false);
        }

        _curActive = transform.GetChild(index).gameObject;
        _curActive.SetActive(true);
    }

}