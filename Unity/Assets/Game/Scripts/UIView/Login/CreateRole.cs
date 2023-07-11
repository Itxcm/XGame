using SkillBridge.Message;
using System;
using UnityEngine;
using UnityEngine.UI;
using XClient;
using XClient.MVC;
using XShare.Data;

public class CreateRole : MonoSingleton<CreateRole>
{
    public Action<int> CreateCall; // �����ص�

    public Button ReturnBtn; // ���ذ�ť
    public Button CreateBtn; // ������ť
    public Text CreateName; // ��������
    public Transform ToggleRoot; // �����鸸��

    private CharacterDefine _characterInfo; // ��ɫ��Ϣ

    private int _curentIndex;

    public int CurrentIndx
    {
        get => _curentIndex;
        private set
        {
            _curentIndex = value;

            _characterInfo = DataManager.Instance.Characters[CurrentIndx];
            CharacterView.Instance.SetRoloIndex(value);
        }
    }  // ��ǰѡ������

    private void Awake()
    {
        ListenAddfirm();
        ListenToggle();
    }

    private void Start() => CurrentIndx = 0;

    private void OnEnable() => UserService.Instance.CreateCharacterCall += CreateCharacterCall;

    private void OnDisable() => UserService.Instance.CreateCharacterCall -= CreateCharacterCall;

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

        ReturnBtn.onClick.AddListener(() =>
        {
            gameObject.SetActive(false);
            LoginView.Instance.SetRootActive(true, "CreateRolo");
        });
    }

    /// <summary>
    /// ��������
    /// </summary>
    private void ListenToggle()
    {
        for (int i = 0; i < ToggleRoot.childCount; i++)
        {
            int temp = i;
            ToggleRoot.GetChild(i).GetComponent<Toggle>().onValueChanged.AddListener((isOn) => CurrentIndx = temp);
        }
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