using System;
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using XShare;

public class MySceneManager : Singleton<MySceneManager>
{
    /// <summary>
    ///  异步加载场景
    /// </summary>
    /// <param name="idx"></param>
    /// <param name="preCall"></param>
    /// <param name="backCall"></param>
    /// <returns></returns>
    public IEnumerator LoadSceneAsync(int idx, Action preCall, Action backCall)
    {
        AsyncOperation asyncOp = SceneManager.LoadSceneAsync(idx);

        preCall?.Invoke();
        Text processText = TipsConfig.Instance.ShowLoadingTips();

        while (!asyncOp.isDone)
        {
            float progress = Mathf.Clamp01(asyncOp.progress / 0.9f);
            processText.text = (progress * 100f).ToString("F0") + "%";

            yield return null;
        }
        TipsConfig.Instance.HideLoadingTips();
        backCall.Invoke();
    }
}