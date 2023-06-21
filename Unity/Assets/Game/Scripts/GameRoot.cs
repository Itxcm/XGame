using ITXCM.Manager;
using System.IO;
using UnityEngine.SceneManagement;
using XClient;
using XClient.MVC;
using XShare;

public class GameRoot : MonoSingleton<GameRoot>
{
    private Scene[] roloScene = new Scene[5];
    private Scene activeScene;

    private void Awake()
    {
        // 初始化日志
        FileInfo fi = new FileInfo("log4net.config");
        log4net.Config.XmlConfigurator.ConfigureAndWatch(fi);
        Log.Init("GameServer");
        Log.Info("Game Server Init");

        NetService.Instance.Init();
        UserService.Instance.Init();
    }

    // 进入游戏 创建角色Or选取角色
    public void GameEnter()
    {
        // 加载场景
        StartCoroutine(LSceneManager.Instance.LoadSceneAsync(1, null, () =>
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
        }));
    }
}