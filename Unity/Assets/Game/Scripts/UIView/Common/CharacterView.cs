using System;
using System.Collections;
using UnityEngine;

public class CharacterView : MonoBehaviour
{
    private GameObject _curActive;

    private void Start() => SetRoloIndex(0);
    private void OnEnable() => RegRoleCall();
    private void OnDisable() => CancleRoleCall();
    private IEnumerator RegRoleCall()
    {
        yield return new WaitUntil(() => CreateRole.Instance != null);
        CreateRole.Instance.SelectRoleCall += SetRoloIndex;
    }
    private IEnumerator CancleRoleCall()
    {
        yield return new WaitUntil(() => CreateRole.Instance != null);
        CreateRole.Instance.SelectRoleCall -= SetRoloIndex;
    }
    /// <summary>
    ///  设置显示角色索引
    /// </summary>
    /// <param name="index"></param>
    public void SetRoloIndex(int index)
    {
        if (_curActive != null && _curActive.activeSelf)
        {
            _curActive.SetActive(false);
        }

        _curActive = transform.GetChild(index).gameObject;
        _curActive.SetActive(true);
    }
}