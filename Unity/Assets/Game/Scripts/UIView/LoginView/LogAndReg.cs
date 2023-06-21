using XClient.MVC;
using SkillBridge.Message;
using UnityEngine;
using UnityEngine.UI;

public class LogAndReg : MonoBehaviour
{

    public InputField userName;
    public InputField password;

    public GameObject log;
    public GameObject reg;
    public GameObject switchGo;

    private void Awake()
    {
        BtnListen();

        UserService.Instance.LoginCall = LoginCall;
        UserService.Instance.RegisterCall = RegisterCall;
    }

    private void Start()
    {
        SetInputActive(true);
    }

    // °´Å¥¼àÌý
    private void BtnListen()
    {
        switchGo.GetComponent<Button>().onClick.AddListener(() => SetInputActive(!log.activeSelf));
        reg.GetComponent<Button>().onClick.AddListener(() => UserService.Instance.Register(userName.text, password.text));
        log.GetComponent<Button>().onClick.AddListener(() => UserService.Instance.Login(userName.text, password.text));
    }

    // ÉèÖÃµÇÂ¼×¢²áÊäÈë
    private void SetInputActive(bool loginActive)
    {
        log.SetActive(loginActive);
        reg.SetActive(!loginActive);
    }

    // µÇÂ¼»Øµ÷
    private void LoginCall(Result res, string msg)
    {
        if (res == Result.Success)
        {
            gameObject.SetActive(false);
            LoginView.Instance.SetRootActive(true, "Default_login");
        }
        TipsConfig.Instance.ShowSystemTips(msg);
    }

    // ×¢²á»Øµ÷
    private void RegisterCall(Result res, string msg)
    {
        if (res == Result.Success) SetInputActive(true);
        TipsConfig.Instance.ShowSystemTips(msg);
    }
}