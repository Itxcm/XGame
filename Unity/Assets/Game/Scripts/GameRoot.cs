using System.Collections;
using System.IO;
using UnityEngine;
using XClient;
using XClient.MVC;
using XShare;
using XShare.Data;

public class GameRoot : MonoSingleton<GameRoot>
{
    [SerializeField]
    private GameObject _characterView;
    [SerializeField]
    private GameObject _loginView;
    [SerializeField]
    private GameObject _tipsView;

    public CharacterAsset CharacterAsset;

    private void Awake()
    {
        // 初始化日志
        FileInfo fi = new FileInfo("log4net.config");
        log4net.Config.XmlConfigurator.ConfigureAndWatch(fi);
        Log.Init("GameServer");
        Log.Info("Game Server Init");

        // 初始化配置表以及相关服务
        DataManager.Instance.Load();
        NetService.Instance.Init();
        UserService.Instance.Init();

        // 初始化资源
        InitAsset();
    }

    /// <summary>
    /// 初始化资源
    /// </summary>
    private void InitAsset()
    {
        Instantiate(_loginView, transform);
        Instantiate(_tipsView, transform);
    }

    /// <summary>
    /// 进入游戏 创建角色Or选取角色
    /// </summary>
    public void GameEnter()
    {
        // 加载场景
        StartCoroutine(MySceneManager.Instance.LoadSceneAsync(1, null, () =>
        {
            // 切换UI
            LoginView.Instance.SetRootActive(false, "BgCG", "Default_login", "LoginRoot");

            // 检测是否有角色
            if (User.Instance.UserInfo.Player.Characters.Count == 0)
            {
                // 创角页面
                LoginView.Instance.SetRootActive(true, "CreateRole");
            }
            else
            {
                // 选角页面
                LoginView.Instance.SetRootActive(true, "SelectRole");
            }
            // 角色视图界面
            Instantiate(_characterView, transform);
        }));
    }
}