using XClient;
using UnityEngine;

public class LoginView : MonoSingleton<LoginView>
{
    public GameObject[] _rootGameobject;
    private void Start() => SetRootActive(true, "BgCG", "LogAndReg", "LoginRoot");

    // ���ø���Ϸ���󼤻�״̬
    public void SetRootActive(bool isActive, params string[] name)
    {
        for (int i = 0; i < _rootGameobject.Length; i++)
        {
            for (int j = 0; j < name.Length; j++)
            {
                GameObject target = _rootGameobject[i].gameObject;
                if (target.name == name[j])
                {
                    target.SetActive(isActive);
                }
            }
        }
    }
}