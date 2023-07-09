using UnityEngine;
using System.Collections;
using UnityEditor;

[CustomEditor(typeof(AniMeshUV))]
public class AniMeshUVEditor : Editor 
{
	private AniMeshUV aniMeshUV;

	private string[] texLieBiaoString;
	private int texLieBiaoID = 0;

	private void ChuShiHua()
	{
		texLieBiaoID = 0;
		texLieBiaoString = null;
	}

	public override void OnInspectorGUI()
	{

		DrawDefaultInspector();

		aniMeshUV = target as AniMeshUV;

		if (texLieBiaoString != null) 
		{
			texLieBiaoID = EditorGUILayout.Popup("可修改贴图", texLieBiaoID, texLieBiaoString);
			aniMeshUV.TexName = texLieBiaoString[texLieBiaoID];
		}

		if (GUILayout.Button("查找材质有哪些贴图")) 
		{
			ChuShiHua();
			aniMeshUV.ChaZhaoShaderColor();
			LieBiaoShuaXin();
		}
	}

	private void LieBiaoShuaXin()
	{
		texLieBiaoString = new string[aniMeshUV.TexNameS.Count];
		for (int i = 0; i < aniMeshUV.TexNameS.Count; i++) 
		{
			texLieBiaoString[i] = aniMeshUV.TexNameS[i];
		}
	}
}