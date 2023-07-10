using SkillBridge.Message;
using System;
using UnityEngine;

[CreateAssetMenu(fileName = "Character", menuName = "CharacterData/CharacterInfo")]
public class CharacterAsset : ScriptableObject
{
    public CharacterInfo[] CharacterInfos;
}

/// <summary>
/// ������ɫ��Ϣ��Դ
/// </summary>
[Serializable]
public class CharacterInfo
{
    [Label("ְҵ������")] public string Name;
    [Label("ְҵӢ����")] public CharacterClass Class;
    [Label("ְҵͼ��")] public Sprite Imgae;
}


