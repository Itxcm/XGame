using ITXCM.Manager;
using System.Collections;
using System.IO;
using UnityEngine;
using UnityEngine.SceneManagement;
using XClient;
using XClient.MVC;
using XShare;

public class GameRoot : MonoSingleton<GameRoot>
{
    private void Awake()
    {
        // ��ʼ����־
        FileInfo fi = new FileInfo("log4net.config");
        log4net.Config.XmlConfigurator.ConfigureAndWatch(fi);
        Log.Init("GameServer");
        Log.Info("Game Server Init");

        NetService.Instance.Init();
        UserService.Instance.Init();

        StartCoroutine(RegSelectRoleCall());
    }
    // ע��ѡ���ɫ�¼��ص�
    private IEnumerator RegSelectRoleCall()
    {
        yield return new WaitUntil(() => CreateRole.Instance != null);
        CreateRole.Instance.SelectRoleCall = SelectRoleCall;
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
            GameObject go = Instantiate(AssetManager.Instance.CharacterView, this.transform);
            curTrans = go.transform;
            SetCurRolo(0);
        }));
    }

    #region ��ɫѡȡ

    private GameObject curActiveGo; // ��ǰ�����ɫ
    private Transform curTrans; // ����λ��
    private void SelectRoleCall(int idx)
    {
        curActiveGo.SetActive(false);
        SetCurRolo(idx);
    }
    private void SetCurRolo(int idx)
    {
        curActiveGo = curTrans.GetChild(idx).gameObject;
        curActiveGo.SetActive(true);
    }

    #endregion ��ɫѡȡ
}