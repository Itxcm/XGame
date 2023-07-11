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

    private NCharacterInfo _currentCharacterInfo;
    public NCharacterInfo CurrentCharacterInfo
    {
        get => _currentCharacterInfo;
        private set
        {
            _currentCharacterInfo = value;

            StartCoroutine(WaitChatviewSetRolo());
        }
    }

    private void Awake()
    {
        ReturnBtn.onClick.AddListener(() =>
        {
            /* gameObject.SetActive(false);
             LoginView.Instance.SetRootActive(true, "CreateRole");*/

            TipsConfig.Instance.ShowSystemTips("暂时无法退出登录,请强制退出!");
        });
        ComfirmBtn.onClick.AddListener(() =>
        {
            gameObject.SetActive(false);
            LoginView.Instance.SetRootActive(true, "CreateRole");
        });
    }

    private void OnEnable() => CreateItem();

    /// <summary>
    /// 等待角色视图初始化完毕设置角色视图
    /// </summary>
    /// <returns></returns>
    private IEnumerator WaitChatviewSetRolo()
    {
        yield return new WaitUntil(() => CharacterView.Instance != null);

        CharacterView.Instance.SetRoloIndex((int)_currentCharacterInfo.Class - 1);
    }

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
        go.GetComponent<ToggleExpand>().group = ToogleGroup;
        go.GetComponent<ToggleExpand>().onValueChanged.AddListener((isOn) => CurrentCharacterInfo = info);
        go.GetComponent<RoleItem>().SetInfo(info);
    }

    /// <summary>
    /// 创建角色创建Item
    /// </summary>
    private void CreateRoloCreate() => Instantiate(RoloItemnCreate, Root);
}
