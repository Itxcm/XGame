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
    /// 创建Item项
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
    /// 清空Item
    /// </summary>
    private void ClearItem()
    {
        for (int i = 0; i < Root.childCount; i++)
            Destroy(Root.GetChild(i).gameObject);
    }

    /// <summary>
    ///  创建角色信息Item
    /// </summary>
    /// <param name="info"></param>
    private void CreateRoloItem(NCharacterInfo info)
    {
        GameObject go = Instantiate(RoloItem, Root);
        go.GetComponent<RoleItem>().SetInfo(info);
    }

    /// <summary>
    /// 创建角色创建Item
    /// </summary>
    private void CreateRoloCreate() => Instantiate(RoloItemnCreate, Root);
}
