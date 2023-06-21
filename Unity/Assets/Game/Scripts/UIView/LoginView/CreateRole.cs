using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using XClient;

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

    public Action<int> SelectRoleCall;

    private void Start()
    {
        for (int i = 0; i < toggles.Count; i++)
        {
            int temp = i;
            toggles[i].onValueChanged.AddListener((bool IsOn) => SetRightRes(temp));
        }
    }

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