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
        // ��ʼ����־
        FileInfo fi = new FileInfo("log4net.config");
        log4net.Config.XmlConfigurator.ConfigureAndWatch(fi);
        Log.Init("GameServer");
        Log.Info("Game Server Init");

        NetService.Instance.Init();
        UserService.Instance.Init();
    }

    // ������Ϸ ������ɫOrѡȡ��ɫ
    public void GameEnter()
    {
        // ���س���
        StartCoroutine(LSceneManager.Instance.LoadSceneAsync(1, null, () =>
        {
            // �л�UI
            LoginView.Instance.SetRootActive(false, "BgCG", "Default_login", "LoginRoot");

            // ����Ƿ��н�ɫ
            if (User.Instance.UserInfo.Player.Characters.Count == 0)
            {
                // ����ҳ��
                LoginView.Instance.SetRootActive(true, "CreateRole");
            }
            else
            {
                // ѡ��ҳ��
                LoginView.Instance.SetRootActive(true, "SelectRole");
            }
        }));
    }
}