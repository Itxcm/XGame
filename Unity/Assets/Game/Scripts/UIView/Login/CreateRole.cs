using SkillBridge.Message;
using System;
using UnityEngine.UI;
using XClient;
using XClient.MVC;
using XShare.Data;

public class CreateRole : MonoSingleton<CreateRole>
{
    public Action<int> CreateCall; // 创建回调

    public Button CreateBtn; // 创建按钮
    public Text CreateName; // 创建名称

    private CharacterDefine _characterInfo; // 角色信息

    private int _curentIndex;

    public int CurrentIndx
    {
        get => _curentIndex;
        set
        {
            _curentIndex = value;

            _characterInfo = DataManager.Instance.Characters[CurrentIndx];
            CharacterView.Instance.SetRoloIndex(value);
        }
    }  // 当前选择索引

    private void Awake() => ListenAddfirm();

    private void Start() => CurrentIndx = 0;

    private void OnEnable() => UserService.Instance.CreateCharacterCall += CreateCharacterCall;

    private void OnDisable() => UserService.Instance.CreateCharacterCall -= CreateCharacterCall;

    /// <summary>
    /// 监听确定按钮
    /// </summary>
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

    /// <summary>
    /// 服务器选择角色回调
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