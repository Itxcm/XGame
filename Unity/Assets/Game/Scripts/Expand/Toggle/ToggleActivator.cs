using System.Collections;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Toggle))] // 确保Toggle组件已附加到该对象上
public sealed class ToggleActivator : MonoBehaviour // ToggleActivator类
{
    [SerializeField] private GameObject[] actives; // 启用的游戏对象数组
    [SerializeField] private GameObject[] deactives; // 停用的游戏对象数组
    [SerializeField] private GameObject[] activesOnly; // 仅在Toggle处于打开状态时启用的游戏对象数组
    [SerializeField] private GameObject[] deactivesOnly; // 仅在Toggle处于关闭状态时停用的游戏对象数组
    [SerializeField] private TransitionModeEnum transitionMode; // 过渡模式
    [SerializeField] private float transitionTime = 0.1f; // 过渡时间
    private Toggle toggle; // Toggle组件的引用

    /// <summary>
    /// 在对象被实例化时调用
    /// </summary>
    private void Awake()
    {
        toggle = GetComponent<Toggle>(); // 获取Toggle组件
        Debug.Assert(toggle != null); // 确保Toggle组件已附加到该对象上
    }

    /// <summary>
    /// 在对象被启用时调用
    /// </summary>
    private void Start()
    {
        ToggleValueChanged(toggle.isOn); // 初始化状态
        toggle.onValueChanged.AddListener(ToggleValueChanged); // 监听Toggle状态改变事件
    }

    /// <summary>
    /// 在启用该脚本时更新状态
    /// </summary>
    private void OnEnable() => ToggleValueChanged(toggle.isOn);

    /// <summary>
    /// Toggle状态改变时调用
    /// </summary>
    /// <param name="isOn">Toggle状态</param>
    private void ToggleValueChanged(bool isOn)
    {
        foreach (GameObject go in actives) // 启用所有的启用游戏对象
            SetGameObjectActive(go, isOn);
        foreach (GameObject go in deactives) // 停用所有的停用游戏对象
            SetGameObjectActive(go, !isOn);
        if (isOn)
        {
            foreach (GameObject go in activesOnly) // 启用所有的仅在打开状态下启用的游戏对象
                SetGameObjectActive(go, true);
        }
        else
        {
            foreach (GameObject go in deactivesOnly) // 启用所有的仅在关闭状态下停用的游戏对象
                SetGameObjectActive(go, false);
        }
    }

    /// <summary>
    /// 设置游戏对象的启用/停用状态
    /// </summary>
    /// <param name="go">游戏对象</param>
    /// <param name="active">启用/停用状态</param>
    private void SetGameObjectActive(GameObject go, bool active)
    {
        if (transitionMode == TransitionModeEnum.Instant) // 如果过渡模式为Instant，则立即启用或关闭游戏对象
        {
            go.SetActive(active);
        }
        else // 如果过渡模式为Fade，则使用渐变效果启用或关闭游戏对象
        {
            CanvasGroup canvasGroup = go.GetComponent<CanvasGroup>(); // 获取CanvasGroup组件
            if (canvasGroup != null) // 如果游戏对象具有CanvasGroup组件
            {
                go.SetActive(true); // 启用游戏对象
                if (go.activeInHierarchy) // 如果游戏对象当前处于激活状态
                {
                    if (active)
                        StartCoroutine(Fade(canvasGroup, 1f, true)); // 启用游戏对象的渐变效果
                    else
                        StartCoroutine(Fade(canvasGroup, 0f, false)); // 停用游戏对象的渐变效果
                }
                else
                    go.SetActive(active); // 否则直接启用或停用游戏对象
            }
            else // 如果游戏对象不具有CanvasGroup组件
                go.SetActive(active); // 直接启用或停用游戏对象
        }
    }

    /// <summary>
    /// 启用或停用游戏对象的渐变效果
    /// </summary>
    /// <param name="canvasGroup">CanvasGroup组件</param>
    /// <param name="targetAlpha">目标透明度</param>
    /// <param name="targetState">目标状态</param>
    /// <returns>IEnumerator对象</returns>
    private IEnumerator Fade(CanvasGroup canvasGroup, float targetAlpha, bool targetState)
    {
        float startAlpha = canvasGroup.alpha; // 记录开始渐变时的透明度
        float t = 0f; // 初始化计时器
        while (t < transitionTime) // 在过渡时间内，每一帧更新透明度
        {
            t += Time.deltaTime; // 更新计时器
            canvasGroup.alpha = Mathf.Lerp(startAlpha, targetAlpha, t / transitionTime); // 计算当前渐变值
            yield return null; // 等待一帧
        }
        canvasGroup.alpha = targetAlpha; // 设置最终渐变值
        canvasGroup.gameObject.SetActive(targetState); // 设置游戏对象的启用/停用状态
    }

    /// <summary>
    /// 过渡模式枚举
    /// </summary>
    public enum TransitionModeEnum
    {
        Instant, // 立即过渡
        Fade, // 渐变过渡
    }
}