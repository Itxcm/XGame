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

    // ��ť����
    private void BtnListen()
    {
        switchGo.GetComponent<Button>().onClick.AddListener(() => SetInputActive(!log.activeSelf));
        reg.GetComponent<Button>().onClick.AddListener(() => UserService.Instance.Register(userName.text, password.text));
        log.GetComponent<Button>().onClick.AddListener(() => UserService.Instance.Login(userName.text, password.text));
    }

    // ���õ�¼ע������
    private void SetInputActive(bool loginActive)
    {
        log.SetActive(loginActive);
        reg.SetActive(!loginActive);
    }

    // ��¼�ص�
    private void LoginCall(Result res, string msg)
    {
        if (res == Result.Success)
        {
            gameObject.SetActive(false);
            LoginView.Instance.SetRootActive(true, "Default_login");
        }
        TipsConfig.Instance.ShowSystemTips(msg);
    }

    // ע��ص�
    private void RegisterCall(Result res, string msg)
    {
        if (res == Result.Success) SetInputActive(true);
        TipsConfig.Instance.ShowSystemTips(msg);
    }
}