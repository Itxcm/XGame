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
        // ��ʼ����־
        FileInfo fi = new FileInfo("log4net.config");
        log4net.Config.XmlConfigurator.ConfigureAndWatch(fi);
        Log.Init("GameServer");
        Log.Info("Game Server Init");

        // ��ʼ�����ñ��Լ���ط���
        DataManager.Instance.Load();
        NetService.Instance.Init();
        UserService.Instance.Init();

        // ��ʼ����Դ
        InitAsset();
    }

    /// <summary>
    /// ��ʼ����Դ
    /// </summary>
    private void InitAsset()
    {
        Instantiate(_loginView, transform);
        Instantiate(_tipsView, transform);
    }

    /// <summary>
    /// ������Ϸ ������ɫOrѡȡ��ɫ
    /// </summary>
    public void GameEnter()
    {
        // ���س���
        StartCoroutine(MySceneManager.Instance.LoadSceneAsync(1, null, () =>
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
            // ��ɫ��ͼ����
            Instantiate(_characterView, transform);
        }));
    }
}