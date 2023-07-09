using UnityEngine;
using UnityEngine.UI;

public class Default_login : MonoBehaviour
{

    public Button rerurnBtn;
    public Button gongGaoBtn;
    public Button enterBtn;
    public Button selectServerBtn;
    public Button selectDefaultBtn;

    private void Awake() => BtnListen();
    private void BtnListen()
    {
        rerurnBtn.onClick.AddListener(() => TipsConfig.Instance.ShowSystemTips("暂未完善退出登录，请强退重新进入！"));
        gongGaoBtn.onClick.AddListener(() => TipsConfig.Instance.ShowSystemTips("公告系统开发中！"));
        enterBtn.onClick.AddListener(() => GameRoot.Instance.GameEnter());
        selectServerBtn.onClick.AddListener(() => LoginView.Instance.SetRootActive(true, "SelectServer"));
        selectDefaultBtn.onClick.AddListener(() => LoginView.Instance.SetRootActive(true, "SelectServer"));
    }
}