using SkillBridge.Message;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using XClient;
using XClient.MVC;
using XShare.Data;

/// <summary>
///  ��ɫ�л���ʾ��Դ
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
    public Action<int> SelectRoleCall; // ��ɫ�л��ص�
    public Action<int> CreateCall; // �����ص�

    [Header("��ɫ�л���Դ�б�")]
    public List<RoleActiveResoucre> activeList;

    [Header("�����б�")]
    public List<Toggle> toggles;

    [Header("��Ҫ��ֵ����Դ")]
    public Image _ImgIcon;
    public Image _ImgDesc;
    public Text _TextDes1;
    public Text _TextDes2;
    public Image _AbliteImage;

    public Button CreateBtn; // ������ť
    public Text CreateName; // ��������

    private CharacterDefine _characterInfo; // ��ɫ��Ϣ

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
    }  // ��ǰѡ������

    private void Awake()
    {
        ListenToggle();
        ListenAddfirm();
    }
    private void Start() => CurrentIndx = 0;
    private void OnEnable() => UserService.Instance.CreateCharacterCall += CreateCharacterCall;
    private void OnDisable() => UserService.Instance.CreateCharacterCall -= CreateCharacterCall;

    /// <summary>
    /// ��������б���
    /// </summary>
    private void ListenToggle()
    {
        for (int i = 0; i < toggles.Count; i++)
        {
            int temp = i;
            toggles[i].onValueChanged.AddListener((bool IsOn) => CurrentIndx = temp);
        }
    }

    /// <summary>
    /// ����ȷ����ť
    /// </summary>
    private void ListenAddfirm()
    {
        CreateBtn.onClick.AddListener(() =>
        {
            if (string.IsNullOrEmpty(CreateName.text))
            {
                TipsConfig.Instance.ShowSystemTips("���Ʋ���Ϊ��");
                return;
            }
            UserService.Instance.CreateCharacter(CreateName.text, _characterInfo.Class);
        });
    }

    /// <summary>
    /// �����ı� �л��Ҳ���Դ
    /// </summary>
    /// <param name="i"></param>
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

    /// <summary>
    /// ������ѡ���ɫ�ص�
    /// </summary>
    /// <param name="res"></param>
    /// <param name="msg"></param>
    private void CreateCharacterCall(Result res, string msg)
    {
        TipsConfig.Instance.ShowSystemTips(msg);

        if (res == Result.Success)
        {
            gameObject.SetActive(false);
            LoginView.Instance.SetRootActive(true, "SelectRole");
        }
    }
}