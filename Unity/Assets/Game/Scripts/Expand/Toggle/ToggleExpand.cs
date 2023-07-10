using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ToggleExpand : Toggle
{
    private bool isScaling = false; // ����Ƿ����ڽ������Ŷ���

    public override void OnPointerUp(PointerEventData eventData)
    {
        base.OnPointerUp(eventData);
        if (!isScaling) // ���û�н������Ŷ���
            StartCoroutine(ScaleAnimation(1f, 0.05f)); // ��ʼ���Ŷ���
    }

    public override void OnPointerDown(PointerEventData eventData)
    {
        base.OnPointerDown(eventData);
        if (!isScaling) // ���û�н������Ŷ���
            StartCoroutine(ScaleAnimation(0.9f, 0.05f)); // ��ʼ���Ŷ���
    }

    private IEnumerator ScaleAnimation(float targetScale, float duration)
    {
        isScaling = true; // ������ڽ������Ŷ���
        float startScale = transform.localScale.x; // ��¼��ʼ�����ű���
        float t = 0f; // ��ʼ����ʱ��
        while (t < duration) // ��duration���ʱ���ڣ�ÿһ֡�������ű���
        {
            t += Time.deltaTime; // ���¼�ʱ��
            float scale = Mathf.Lerp(startScale, targetScale, t / duration); // ���㵱ǰ���ű���
            transform.localScale = new Vector3(scale, scale, scale); // �������ű���
            yield return null; // �ȴ�һ֡
        }
        transform.localScale = new Vector3(targetScale, targetScale, targetScale); // �������յ����ű���
        isScaling = false; // ������Ŷ�������
    }
}