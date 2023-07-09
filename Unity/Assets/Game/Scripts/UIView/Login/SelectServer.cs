using UnityEngine;
using UnityEngine.UI;

public class SelectServer : MonoBehaviour
{
    public Button closeBtn;
    public Button enterBtn;

    private void Awake() => BtnListen();

    private void BtnListen()
    {
        closeBtn.onClick.AddListener(() => gameObject.SetActive(false));
        enterBtn.onClick.AddListener(() =>
        {
            gameObject.SetActive(false);
            GameRoot.Instance.GameEnter();
        });
    }
}