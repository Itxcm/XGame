using System;
using UnityEngine;
using UnityEditor;

internal class WeatherShaderGUI : ShaderGUI {

	public enum BlendMode {
		Opaque,
		Cutout,
		Fade,       // Old school alpha-blending mode, fresnel does not affect amount of transparency
		Transparent // Physically plausible transparency mode, implemented as alpha pre-multiply
	}

	private static class Styles {
		public static GUIContent albedoText = new GUIContent("Albedo", "Albedo (RGB) and Transparency (A)");
		public static GUIContent alphaCutoffText = new GUIContent("Alpha Cutoff", "Threshold for alpha cutoff");
		public static GUIContent normalMapText = new GUIContent("Normal Map", "Normal Map");

		public static string primaryMapsText = "Main Maps";
		public static string renderingMode = "Rendering Mode";
		public static readonly string[] blendNames = Enum.GetNames(typeof(BlendMode));
	}

	MaterialProperty blendMode = null;
	MaterialProperty albedoMap = null;
	MaterialProperty alphaCutoff = null;
	MaterialProperty bumpMap = null;

	MaterialEditor m_MaterialEditor;

	bool m_FirstTimeApply = true;

	public void FindProperties(MaterialProperty[] props) {
		albedoMap = FindProperty("_MainTex", props);
		bumpMap = FindProperty("_BumpMap", props);
		alphaCutoff = FindProperty("_Cutoff", props);
		blendMode = FindProperty("_Mode", props);
	}

	public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props) {
		FindProperties(props); // MaterialProperties can be animated so we do not cache them but fetch them every event to ensure animated values are updated correctly
		m_MaterialEditor = materialEditor;
		Material material = materialEditor.target as Material;

		ShaderPropertiesGUI(material);

		// Make sure that needed keywords are set up if we're switching some existing
		// material to a standard shader.
		if (m_FirstTimeApply) {
			SetMaterialKeywords(material);
			m_FirstTimeApply = false;
		}
	}

	public void ShaderPropertiesGUI(Material material) {
		// Use default labelWidth
		EditorGUIUtility.labelWidth = 0f;

		// Detect any changes to the material
		EditorGUI.BeginChangeCheck();
		{
			BlendModePopup();

			// Primary properties
			GUILayout.Label(Styles.primaryMapsText, EditorStyles.boldLabel);
			DoAlbedoArea(material);
			m_MaterialEditor.TexturePropertySingleLine(Styles.normalMapText, bumpMap);
			m_MaterialEditor.TextureScaleOffsetProperty(albedoMap);
			EditorGUILayout.Space();
		}
		if (EditorGUI.EndChangeCheck()) {
			foreach (var obj in blendMode.targets)
				MaterialChanged((Material)obj);
		}
	}

	public override void AssignNewShaderToMaterial(Material material, Shader oldShader, Shader newShader) {
		// _Emission property is lost after assigning Standard shader to the material
		// thus transfer it before assigning the new shader
		if (material.HasProperty("_Emission")) {
			material.SetColor("_EmissionColor", material.GetColor("_Emission"));
		}

		base.AssignNewShaderToMaterial(material, oldShader, newShader);

		if (oldShader == null || !oldShader.name.Contains("Legacy Shaders/"))
			return;

		BlendMode blendMode = BlendMode.Opaque;
		if (oldShader.name.Contains("/Transparent/Cutout/")) {
			blendMode = BlendMode.Cutout;
		} else if (oldShader.name.Contains("/Transparent/")) {
			// NOTE: legacy shaders did not provide physically based transparency
			// therefore Fade mode
			blendMode = BlendMode.Fade;
		}
		material.SetFloat("_Mode", (float)blendMode);

		MaterialChanged(material);
	}

	void BlendModePopup() {
		EditorGUI.showMixedValue = blendMode.hasMixedValue;
		var mode = (BlendMode)blendMode.floatValue;

		EditorGUI.BeginChangeCheck();
		mode = (BlendMode)EditorGUILayout.Popup(Styles.renderingMode, (int)mode, Styles.blendNames);
		if (EditorGUI.EndChangeCheck()) {
			m_MaterialEditor.RegisterPropertyChangeUndo("Rendering Mode");
			blendMode.floatValue = (float)mode;
		}

		EditorGUI.showMixedValue = false;
	}

	void DoAlbedoArea(Material material) {
		m_MaterialEditor.TexturePropertySingleLine(Styles.albedoText, albedoMap);
		if (((BlendMode)material.GetFloat("_Mode") == BlendMode.Cutout)) {
			m_MaterialEditor.ShaderProperty(alphaCutoff, Styles.alphaCutoffText.text, MaterialEditor.kMiniTextureFieldLabelIndentLevel + 1);
		}
	}

	public static void SetupMaterialWithBlendMode(Material material, BlendMode blendMode) {
		switch (blendMode) {
			case BlendMode.Opaque:
				material.SetOverrideTag("RenderType", "");
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
				material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
				material.SetInt("_ZWrite", 1);
				material.DisableKeyword("_ALPHATEST_ON");
				material.DisableKeyword("_ALPHABLEND_ON");
				material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
				material.renderQueue = -1;
				break;
			case BlendMode.Cutout:
				material.SetOverrideTag("RenderType", "TransparentCutout");
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
				material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
				material.SetInt("_ZWrite", 1);
				material.EnableKeyword("_ALPHATEST_ON");
				material.DisableKeyword("_ALPHABLEND_ON");
				material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
				material.renderQueue = 2450;
				break;
			case BlendMode.Fade:
				material.SetOverrideTag("RenderType", "Transparent");
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
				material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
				material.SetInt("_ZWrite", 0);
				material.DisableKeyword("_ALPHATEST_ON");
				material.EnableKeyword("_ALPHABLEND_ON");
				material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
				material.renderQueue = 3000;
				break;
			case BlendMode.Transparent:
				material.SetOverrideTag("RenderType", "Transparent");
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
				material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
				material.SetInt("_ZWrite", 0);
				material.DisableKeyword("_ALPHATEST_ON");
				material.DisableKeyword("_ALPHABLEND_ON");
				material.EnableKeyword("_ALPHAPREMULTIPLY_ON");
				material.renderQueue = 3000;
				break;
		}
	}

	static void SetMaterialKeywords(Material material) {
		// Note: keywords must be based on Material value not on MaterialProperty due to multi-edit & material animation
		// (MaterialProperty value might come from renderer material property block)
		SetKeyword(material, "_NORMALMAP", material.GetTexture("_BumpMap"));
	}

	static void MaterialChanged(Material material) {
		SetupMaterialWithBlendMode(material, (BlendMode)material.GetFloat("_Mode"));

		SetMaterialKeywords(material);
	}

	static void SetKeyword(Material m, string keyword, bool state) {
		if (state)
			m.EnableKeyword(keyword);
		else
			m.DisableKeyword(keyword);
	}
}