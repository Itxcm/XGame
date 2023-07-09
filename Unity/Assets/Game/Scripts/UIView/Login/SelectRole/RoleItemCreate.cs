using UnityEngine;
using UnityEngine.EventSystems;

public class RoleItemCreate : MonoBehaviour, IPointerClickHandler
{
    public void OnPointerClick(PointerEventData eventData)
    {
        LoginView.Instance.SetRootActive(false, "SelectRole");
        LoginView.Instance.SetRootActive(true, "CreateRole");
    }
}