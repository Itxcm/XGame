using System;
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using XClient;

namespace ITXCM.Manager
{
    public class LSceneManager : MonoSingleton<LSceneManager>
    {
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
}