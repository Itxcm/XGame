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
        // 初始化日志
        FileInfo fi = new FileInfo("log4net.config");
        log4net.Config.XmlConfigurator.ConfigureAndWatch(fi);
        Log.Init("GameServer");
        Log.Info("Game Server Init");

        NetService.Instance.Init();
        UserService.Instance.Init();

        StartCoroutine(RegSelectRoleCall());
    }
    // 注册选择角色事件回调
    private IEnumerator RegSelectRoleCall()
    {
        yield return new WaitUntil(() => CreateRole.Instance != null);
        CreateRole.Instance.SelectRoleCall = SelectRoleCall;
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
            GameObject go = Instantiate(AssetManager.Instance.CharacterView, this.transform);
            curTrans = go.transform;
            SetCurRolo(0);
        }));
    }

    #region 角色选取

    private GameObject curActiveGo; // 当前激活角色
    private Transform curTrans; // 父级位置
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

    #endregion 角色选取
}