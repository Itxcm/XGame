using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ButtonExpand : Button
{
    private bool isScaling = false; // 标记是否正在进行缩放动画

    public override void OnPointerUp(PointerEventData eventData)
    {
        base.OnPointerUp(eventData);
        if (!isScaling) // 如果没有进行缩放动画
            StartCoroutine(ScaleAnimation(1f, 0.05f)); // 开始缩放动画
    }

    public override void OnPointerDown(PointerEventData eventData)
    {
        base.OnPointerDown(eventData);
        if (!isScaling) // 如果没有进行缩放动画
            StartCoroutine(ScaleAnimation(0.9f, 0.05f)); // 开始缩放动画
    }

    private IEnumerator ScaleAnimation(float targetScale, float duration)
    {
        isScaling = true; // 标记正在进行缩放动画
        float startScale = transform.localScale.x; // 记录开始的缩放比例
        float t = 0f; // 初始化计时器
        while (t < duration) // 在duration秒的时间内，每一帧更新缩放比例
        {
            t += Time.deltaTime; // 更新计时器
            float scale = Mathf.Lerp(startScale, targetScale, t / duration); // 计算当前缩放比例
            transform.localScale = new Vector3(scale, scale, scale); // 更新缩放比例
            yield return null; // 等待一帧
        }
        transform.localScale = new Vector3(targetScale, targetScale, targetScale); // 设置最终的缩放比例
        isScaling = false; // 标记缩放动画结束
    }
}