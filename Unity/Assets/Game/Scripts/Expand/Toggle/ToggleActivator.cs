using System.Collections;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Toggle))] // ȷ��Toggle����Ѹ��ӵ��ö�����
public sealed class ToggleActivator : MonoBehaviour // ToggleActivator��
{
    [SerializeField] private GameObject[] actives; // ���õ���Ϸ��������
    [SerializeField] private GameObject[] deactives; // ͣ�õ���Ϸ��������
    [SerializeField] private GameObject[] activesOnly; // ����Toggle���ڴ�״̬ʱ���õ���Ϸ��������
    [SerializeField] private GameObject[] deactivesOnly; // ����Toggle���ڹر�״̬ʱͣ�õ���Ϸ��������
    [SerializeField] private TransitionModeEnum transitionMode; // ����ģʽ
    [SerializeField] private float transitionTime = 0.1f; // ����ʱ��
    private Toggle toggle; // Toggle���������

    /// <summary>
    /// �ڶ���ʵ����ʱ����
    /// </summary>
    private void Awake()
    {
        toggle = GetComponent<Toggle>(); // ��ȡToggle���
        Debug.Assert(toggle != null); // ȷ��Toggle����Ѹ��ӵ��ö�����
    }

    /// <summary>
    /// �ڶ�������ʱ����
    /// </summary>
    private void Start()
    {
        ToggleValueChanged(toggle.isOn); // ��ʼ��״̬
        toggle.onValueChanged.AddListener(ToggleValueChanged); // ����Toggle״̬�ı��¼�
    }

    /// <summary>
    /// �����øýű�ʱ����״̬
    /// </summary>
    private void OnEnable() => ToggleValueChanged(toggle.isOn);

    /// <summary>
    /// Toggle״̬�ı�ʱ����
    /// </summary>
    /// <param name="isOn">Toggle״̬</param>
    private void ToggleValueChanged(bool isOn)
    {
        foreach (GameObject go in actives) // �������е�������Ϸ����
            SetGameObjectActive(go, isOn);
        foreach (GameObject go in deactives) // ͣ�����е�ͣ����Ϸ����
            SetGameObjectActive(go, !isOn);
        if (isOn)
        {
            foreach (GameObject go in activesOnly) // �������еĽ��ڴ�״̬�����õ���Ϸ����
                SetGameObjectActive(go, true);
        }
        else
        {
            foreach (GameObject go in deactivesOnly) // �������еĽ��ڹر�״̬��ͣ�õ���Ϸ����
                SetGameObjectActive(go, false);
        }
    }

    /// <summary>
    /// ������Ϸ���������/ͣ��״̬
    /// </summary>
    /// <param name="go">��Ϸ����</param>
    /// <param name="active">����/ͣ��״̬</param>
    private void SetGameObjectActive(GameObject go, bool active)
    {
        if (transitionMode == TransitionModeEnum.Instant) // �������ģʽΪInstant�����������û�ر���Ϸ����
        {
            go.SetActive(active);
        }
        else // �������ģʽΪFade����ʹ�ý���Ч�����û�ر���Ϸ����
        {
            CanvasGroup canvasGroup = go.GetComponent<CanvasGroup>(); // ��ȡCanvasGroup���
            if (canvasGroup != null) // �����Ϸ�������CanvasGroup���
            {
                go.SetActive(true); // ������Ϸ����
                if (go.activeInHierarchy) // �����Ϸ����ǰ���ڼ���״̬
                {
                    if (active)
                        StartCoroutine(Fade(canvasGroup, 1f, true)); // ������Ϸ����Ľ���Ч��
                    else
                        StartCoroutine(Fade(canvasGroup, 0f, false)); // ͣ����Ϸ����Ľ���Ч��
                }
                else
                    go.SetActive(active); // ����ֱ�����û�ͣ����Ϸ����
            }
            else // �����Ϸ���󲻾���CanvasGroup���
                go.SetActive(active); // ֱ�����û�ͣ����Ϸ����
        }
    }

    /// <summary>
    /// ���û�ͣ����Ϸ����Ľ���Ч��
    /// </summary>
    /// <param name="canvasGroup">CanvasGroup���</param>
    /// <param name="targetAlpha">Ŀ��͸����</param>
    /// <param name="targetState">Ŀ��״̬</param>
    /// <returns>IEnumerator����</returns>
    private IEnumerator Fade(CanvasGroup canvasGroup, float targetAlpha, bool targetState)
    {
        float startAlpha = canvasGroup.alpha; // ��¼��ʼ����ʱ��͸����
        float t = 0f; // ��ʼ����ʱ��
        while (t < transitionTime) // �ڹ���ʱ���ڣ�ÿһ֡����͸����
        {
            t += Time.deltaTime; // ���¼�ʱ��
            canvasGroup.alpha = Mathf.Lerp(startAlpha, targetAlpha, t / transitionTime); // ���㵱ǰ����ֵ
            yield return null; // �ȴ�һ֡
        }
        canvasGroup.alpha = targetAlpha; // �������ս���ֵ
        canvasGroup.gameObject.SetActive(targetState); // ������Ϸ���������/ͣ��״̬
    }

    /// <summary>
    /// ����ģʽö��
    /// </summary>
    public enum TransitionModeEnum
    {
        Instant, // ��������
        Fade, // �������
    }
}