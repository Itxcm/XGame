using XClient;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TipsConfig : MonoSingleton<TipsConfig>
{
    public Transform systemTipsPool;


    #region 系统提示

    public Queue<GameObject> sysTipsQueue = new Queue<GameObject>(); //系统消息队列
    private SystemTips preSysTips = null;

    [Header("系统提示消息")] public GameObject systemTipPrefab;

    public void ShowSystemTips(string msg, int speed = 1)
    {
        if (preSysTips != null) preSysTips.SetSpeed(4);

        GameObject go;
        SystemTips st;

        if (sysTipsQueue.Count == 0)
        {
            //  队列没有
            go = Instantiate(systemTipPrefab, systemTipsPool);
            st = go.GetComponent<SystemTips>();
            st.AddTip(msg, speed);
        }
        else
        {
            // 队列有
            go = sysTipsQueue.Dequeue();
            st = go.GetComponent<SystemTips>();
            st.SetTip(msg);
            st.SetSpeed(speed);
            go.SetActive(true);
        }

        preSysTips = st;
    }

    #endregion 系统提示

    [Header("加载提示消息")] public GameObject loadingPrefabs;
    private GameObject _activeTips;

    public Text ShowLoadingTips()
    {
        if (loadingPrefabs == null && _activeTips == null) return null;
        if (_activeTips != null)
        {
            _activeTips.SetActive(true);
        }
        else if (loadingPrefabs != null)
        {
            _activeTips = Instantiate(loadingPrefabs, systemTipsPool);
        }
        return _activeTips.transform.Find("Process").GetComponent<Text>();
    }
    public void HideLoadingTips()
    {
        if (_activeTips == null) return;
        _activeTips.SetActive(false);
    }
}