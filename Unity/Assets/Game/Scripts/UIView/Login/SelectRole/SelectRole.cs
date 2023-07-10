using SkillBridge.Message;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using XClient.MVC;

public class SelectRole : MonoBehaviour
{
    public GameObject RoloItem;
    public GameObject RoloItemnCreate;

    public Button ReturnBtn;
    public Button ComfirmBtn;
    public Transform Root;
    public ToggleGroup ToogleGroup;

    private NCharacterInfo _curentCharacterInfo;

    private void Awake()
    {
        ReturnBtn.onClick.AddListener(() =>
        {
            gameObject.SetActive(false);
            LoginView.Instance.SetRootActive(true, "CreateRole");
        });
        ComfirmBtn.onClick.AddListener(() =>
        {
            gameObject.SetActive(false);
            LoginView.Instance.SetRootActive(true, "CreateRole");
        });
    }

    private void OnEnable() => CreateItem();
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
        SetFirsetItem();
    }

    /// <summary>
    /// 默认第一个
    /// </summary>
    private void SetFirsetItem()
    {
        _curentCharacterInfo = User.Instance.CharacterListInfo[0];

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
        go.GetComponent<ToggleExpand>().group = ToogleGroup;
        go.GetComponent<RoleItem>().SetInfo(info);
    }

    /// <summary>
    /// 创建角色创建Item
    /// </summary>
    private void CreateRoloCreate() => Instantiate(RoloItemnCreate, Root);
}
