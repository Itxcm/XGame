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

    private void Awake() => BtnListen();

    private void Start()
    {
        SetInputActive(true);
        UserService.Instance.LoginCall = LoginCall;
        UserService.Instance.RegisterCall = RegisterCall;
    }

    /// <summary>
    /// ��ť����
    /// </summary>
    private void BtnListen()
    {
        switchGo.GetComponent<Button>().onClick.AddListener(() => SetInputActive(!log.activeSelf));
        reg.GetComponent<Button>().onClick.AddListener(() =>
        {
            if (!CheckAccount()) return;
            UserService.Instance.Register(userName.text, password.text);
        });
        log.GetComponent<Button>().onClick.AddListener(() =>
        {
            if (!CheckAccount()) return;
            UserService.Instance.Login(userName.text, password.text);
        });
    }

    /// <summary>
    /// �˺�Ч��
    /// </summary>
    /// <returns></returns>
    private bool CheckAccount()
    {
        if (string.IsNullOrEmpty(userName.text))
        {
            TipsConfig.Instance.ShowSystemTips("�˺Ų���Ϊ��!");
            return false;
        }

        if (string.IsNullOrEmpty(password.text))
        {
            TipsConfig.Instance.ShowSystemTips("���벻��Ϊ��!");
            return false;
        }

        return true;
    }

    /// <summary>
    /// ���õ�¼ע������
    /// </summary>
    /// <param name="loginActive"></param>
    private void SetInputActive(bool loginActive)
    {
        log.SetActive(loginActive);
        reg.SetActive(!loginActive);
    }

    /// <summary>
    /// ��¼�ص�
    /// </summary>
    /// <param name="res"></param>
    /// <param name="msg"></param>
    private void LoginCall(Result res, string msg)
    {
        if (res == Result.Success)
        {
            gameObject.SetActive(false);
            LoginView.Instance.SetRootActive(true, "Default_login");
        }
        TipsConfig.Instance.ShowSystemTips(msg);
    }

    /// <summary>
    /// ע��ص�
    /// </summary>
    /// <param name="res"></param>
    /// <param name="msg"></param>
    private void RegisterCall(Result res, string msg)
    {
        if (res == Result.Success) SetInputActive(true);
        TipsConfig.Instance.ShowSystemTips(msg);
    }
}