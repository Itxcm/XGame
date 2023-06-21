using UnityEngine;
using UnityEngine.UI;

public class SystemTips : MonoBehaviour
{
    private Animator at;

    private void Awake()
    {
        at = GetComponent<Animator>();
    }

    // 添加提示
    public void AddTip(string msg, int speed)
    {
        at.SetFloat("Speed", speed);
        SetTip(msg);
    }

    // 修改提示
    public void SetTip(string msg)
    {
        var text = GetComponentInChildren<Text>();
        if (text != null) text.text = msg;
    }

    // 修改速度
    public void SetSpeed(int speed) => at.SetFloat("Speed", speed);

    // 监听动画结束
    public void OnAnimatonDone()
    {
        gameObject.SetActive(false);
        TipsConfig.Instance.sysTipsQueue.Enqueue(gameObject);
    }
}