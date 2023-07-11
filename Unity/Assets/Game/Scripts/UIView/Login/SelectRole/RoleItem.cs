using SkillBridge.Message;
using UnityEngine;
using UnityEngine.UI;

public class RoleItem : MonoBehaviour
{
    public Text Name;
    public Text Level;

    public Image DeActiveImg;
    public Image ActiveImg;

    /// <summary>
    /// ������Ϣ
    /// </summary>
    /// <param name="info"></param>
    public void SetInfo(NCharacterInfo info)
    {
        Name.text = info.Name;
        Level.text = $"[0ת] {info.Level}��";
        SetImag(info.Class);
    }

    /// <summary>
    /// ����ͷ��
    /// </summary>
    /// <param name="cla"></param>
    private void SetImag(CharacterClass cla)
    {
        Sprite target = GameRoot.Instance.CharacterAsset.CharacterInfos[(int)cla - 1].Imgae;
        DeActiveImg.overrideSprite = target;
        ActiveImg.overrideSprite = target;

    }
}