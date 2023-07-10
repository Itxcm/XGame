using SkillBridge.Message;
using System;
using UnityEngine;

[CreateAssetMenu(fileName = "Character", menuName = "CharacterData/CharacterInfo")]
public class CharacterAsset : ScriptableObject
{
    public CharacterInfo[] CharacterInfos;
}

/// <summary>
/// 基本角色信息资源
/// </summary>
[Serializable]
public class CharacterInfo
{
    [Label("职业中文名")] public string Name;
    [Label("职业英文名")] public CharacterClass Class;
    [Label("职业图像")] public Sprite Imgae;
}


