using SkillBridge.Message;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XClient.MVC;

public class SelectRole : MonoBehaviour
{
    public GameObject RoloItem;
    public GameObject RoloItemnCreate;
    public Transform Root;

    private void Start() => CreateItem();

    /// <summary>
    /// ����Item��
    /// </summary>
    private void CreateItem()
    {
        ClearItem();
        for (int i = 0; i < User.Instance.CharacterListInfo.Count; i++)
            CreateRoloItem(User.Instance.CharacterListInfo[i]);
        if (Root.childCount < 4)
            CreateRoloCreate();
    }

    /// <summary>
    /// ���Item
    /// </summary>
    private void ClearItem()
    {
        for (int i = 0; i < Root.childCount; i++)
            Destroy(Root.GetChild(i).gameObject);
    }

    /// <summary>
    ///  ������ɫ��ϢItem
    /// </summary>
    /// <param name="info"></param>
    private void CreateRoloItem(NCharacterInfo info)
    {
        GameObject go = Instantiate(RoloItem, Root);
        go.GetComponent<RoleItem>().SetInfo(info);
    }

    /// <summary>
    /// ������ɫ����Item
    /// </summary>
    private void CreateRoloCreate() => Instantiate(RoloItemnCreate, Root);
}
