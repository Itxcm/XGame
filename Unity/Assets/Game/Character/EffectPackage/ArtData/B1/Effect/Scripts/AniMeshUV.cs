using UnityEngine;
using System.Collections;

#if UNITY_EDITOR
using UnityEditor;
using System.Collections.Generic;
#endif

public class AniMeshUV : MonoBehaviour 
{
	public int Xcut = 1;
	public int Ycut = 1;
	public float StartTime = 0f;
	public int AniSpeed = 1;
	public bool Loop = true;
	public bool SuiJi = false;

	#if UNITY_EDITOR
	[HideInInspector]
	public List<string> TexNameS = new List<string>();
	#endif

	public string TexName;

	protected Material m_Mat;
	protected float m_DangQianTime;
	private float TikingX = 1f;
	private float TikingY = 1f;
	private int numberCut;
	private int dangQianCut = 0;
	private float speed;
	private Vector2[] offsets;

	// Use this for initialization
	void Start () 
	{
		m_Mat = GetComponent<Renderer>().material;
		if (AniSpeed <= 0) 
		{
			AniSpeed = 1;
		}
		speed = AniSpeed / 60f;

		numberCut = Xcut * Ycut;

		MainTexTiLing();

		offsets = new Vector2[numberCut];
		for (int i = 0; i < offsets.Length; i++) 
		{
			float offsetX = (i) % (float)Xcut / (float)Xcut;
			int oy = ((i) % numberCut) / Xcut;
			float offsetY = (1.0f - TikingY) - (float)oy * TikingY;
			Vector2 offset = new Vector2(offsetX,offsetY);
			offsets[i] = offset;
		}
	}
	
	// Update is called once per frame
	void Update () 
	{
		MainTexOffset();
	}

	void MainTexTiLing()
	{
		if (Xcut <= 0) 
		{
			Xcut = 1;
		}
		if (Ycut <= 0) 
		{
			Ycut = 1;
		}
		TikingX = 1f / Xcut;
		TikingY = 1f / Ycut;
		Vector2 TiKing = new Vector2(TikingX,TikingY);
		m_Mat.SetTextureScale(TexName,TiKing);
		Vector2 Offset = new Vector2(0f,1f - TikingY);
		m_Mat.SetTextureOffset(TexName, Offset);
	}

	void MainTexOffset()
	{
		speed -= Time.deltaTime;

		m_DangQianTime += Time.deltaTime;

		if (m_DangQianTime >= StartTime) 
		{
			if (speed <= 0 && !SuiJi) 
			{
				if (Loop) 
				{
					dangQianCut += 1;
				}
				else
				{
					dangQianCut += 1;
					if (dangQianCut > numberCut) 
					{
						dangQianCut = numberCut;
					}
				}
				float offsetX = (dangQianCut - 1) % (float)Xcut / (float)Xcut;
				int oy = ((dangQianCut - 1) % numberCut) / Xcut;
				float offsetY = (1.0f - TikingY) - (float)oy * TikingY;
				Vector2 offset = new Vector2(offsetX, offsetY);
				m_Mat.SetTextureOffset(TexName, offset);	
				speed = AniSpeed / 60f;
			}
			if (speed <= 0 && SuiJi) 
			{
				var i = Random.Range(0, numberCut);
				m_Mat.SetTextureOffset(TexName, offsets[i]);
				speed = AniSpeed / 60f;
			}
		}

	}

	#if UNITY_EDITOR

	public void ChaZhaoShaderColor()
	{
		m_Mat = GetComponent<Renderer>().sharedMaterial;
		if (m_Mat!= null) 
		{
			int count = ShaderUtil.GetPropertyCount(m_Mat.shader);
			TexNameS.Clear();
			for (int i = 0; i < count; i++) 
			{
				var assetMatShaderType = ShaderUtil.GetPropertyType(m_Mat.shader, i);
				if (ShaderUtil.ShaderPropertyType.TexEnv == assetMatShaderType) 
				{
					var assetMatShaderProName = ShaderUtil.GetPropertyName(m_Mat.shader, i);
					TexNameS.Add(assetMatShaderProName);
				}
			}
		}
	}

	#endif
}
