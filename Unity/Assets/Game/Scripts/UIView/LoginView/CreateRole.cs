using SkillBridge.Message;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using XClient;
using XClient.MVC;
using XShare.Data;

/// <summary>
///  角色切换显示资源
/// </summary>
[System.Serializable]
public class RoleActiveResoucre
{
    public Sprite ImgIcon;
    public string TextDes1;
    public string TextDes2;
    public Sprite ImgDesc;
    public Sprite AbliteImage;
}

public class CreateRole : MonoSingleton<CreateRole>
{
    [Header("角色切换资源列表")]
    public List<RoleActiveResoucre> activeList;

    [Header("开关列表")]
    public List<Toggle> toggles;

    [Header("需要赋值的资源")]
    public Image _ImgIcon;
    public Image _ImgDesc;
    public Text _TextDes1;
    public Text _TextDes2;
    public Image _AbliteImage;

    public Button CreateBtn; // 创建按钮
    public Text CreateName; // 创建名称

    public Action<int> SelectRoleCall; // 角色切换回调
    public Action<int> CreateCall; // 创建回调

    private CharacterDefine _characterInfo; // 角色信息

    private int _curentIndex;
    public int CurrentIndx
    {

        get => _curentIndex;
        set
        {
            _curentIndex = value;

            _characterInfo = DataManager.Instance.Characters[CurrentIndx];
            SetRightRes(value);
        }
    }  // 当前选择索引

    private void Start()
    {
        ListenToggle();
        ListenAddfirm();
        UserService.Instance.CreateCharacterCall += CreateCharacterCall;
        CurrentIndx = 0;
    }

    // 选择角色回调
    private void CreateCharacterCall(Result res, string msg)
    {
        if (res == Result.Success)
        {
            TipsConfig.Instance.ShowSystemTips(msg);
        }
        else
        {
            TipsConfig.Instance.ShowSystemTips(msg);
        }
    }

    // 监听左侧列表开关
    private void ListenToggle()
    {
        for (int i = 0; i < toggles.Count; i++)
        {
            int temp = i;
            toggles[i].onValueChanged.AddListener((bool IsOn) => CurrentIndx = temp);
        }
    }

    // 监听确定按钮
    private void ListenAddfirm()
    {
        CreateBtn.onClick.AddListener(() =>
        {
            if (string.IsNullOrEmpty(CreateName.text))
            {
                TipsConfig.Instance.ShowSystemTips("名称不能为空");
                return;
            }
            UserService.Instance.CreateCharacter(CreateName.text, _characterInfo.Class);
        });
    }

    //  索引改变 切换右侧资源
    private void SetRightRes(int i)
    {
        RoleActiveResoucre target = activeList[i];

        SelectRoleCall?.Invoke(i);

        _ImgIcon.overrideSprite = target.ImgIcon;
        _AbliteImage.overrideSprite = target.AbliteImage;
        _ImgDesc.overrideSprite = target.ImgDesc;
        _TextDes1.text = target.TextDes1;
        _TextDes2.text = target.TextDes2;

        _ImgIcon.SetNativeSize();
        _AbliteImage.SetNativeSize();
        _ImgDesc.SetNativeSize();
    }


}