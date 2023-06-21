using DG.Tweening;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ScaleButton : Button
{
    public override void OnPointerUp(PointerEventData eventData)
    {
        base.OnPointerUp(eventData);
        transform.DOScale(1f, 0.05f);
    }

    public override void OnPointerDown(PointerEventData eventData)
    {
        base.OnPointerDown(eventData);
        transform.DOScale(0.9f, 0.05f);
    }
}