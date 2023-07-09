using XClient;
using UnityEngine;

public class LoginView : MonoSingleton<LoginView>
{
    private Transform _root;
    private void Awake() => _root = transform.Find("Root");
    private void Start() => SetRootActive(true, "BgCG", "LogAndReg", "LoginRoot");
    /// <summary>
    /// 设置根游戏对象激活状态
    /// </summary>
    /// <param name="isActive"></param>
    /// <param name="name"></param>
    public void SetRootActive(bool isActive, params string[] name)
    {
        for (int i = 0; i < _root.childCount; i++)
        {
            for (int j = 0; j < name.Length; j++)
            {
                GameObject target = _root.GetChild(i).gameObject;
                if (target.name == name[j])
                    target.SetActive(isActive);
            }
        }
    }
}