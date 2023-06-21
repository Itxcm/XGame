using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(GlobalShaderProperty))]
public class GlobalShaderPropertyEditor : Editor {

	private SerializedObject _sobj;
	private SerializedProperty _toonramp;
	private SerializedProperty _matcap;
	private SerializedProperty _charLightS;
	private SerializedProperty _charLightB;
	private SerializedProperty _charLightMaxB;
	private SerializedProperty _charLightMinB;
	private SerializedProperty _charAmbientS;
	private SerializedProperty _charAmbientB;

	private void OnEnable() {
		_sobj = new SerializedObject(target);
		_toonramp = _sobj.FindProperty("ToonRamp");
		_matcap = _sobj.FindProperty("MatCap");
		_charLightS = _sobj.FindProperty("CharLightSaturationScale");
		_charLightB = _sobj.FindProperty("CharLightStandardBrightness");
		_charLightMaxB = _sobj.FindProperty("CharLightMaxBrightness");
		_charLightMinB = _sobj.FindProperty("CharLightMinBrightness");
		_charAmbientS = _sobj.FindProperty("CharAmbientSaturationScale");
		_charAmbientB = _sobj.FindProperty("CharAmbientBrightness");
	}

	public override void OnInspectorGUI() {
		_sobj.Update();
		EditorGUILayout.PropertyField(_toonramp, new GUIContent("ToonRamp贴图"));
		EditorGUILayout.PropertyField(_matcap, new GUIContent("MatCap贴图"));
		EditorGUILayout.HelpBox("如果不知道以下属性含义，不要修改", MessageType.Info);
		EditorGUILayout.PropertyField(_charLightS, new GUIContent("主光-饱和度系数", "主光饱和度为1.0时，角色shader中实际使用此饱和度"));
		EditorGUILayout.PropertyField(_charLightB, new GUIContent("主光-标准亮度", "主光亮度为1.0时，角色shader中实际使用此亮度"));
		EditorGUILayout.PropertyField(_charLightMaxB, new GUIContent("主光-最高亮度", "主光亮度为8.0时，角色shader中实际使用此亮度"));
		EditorGUILayout.PropertyField(_charLightMinB, new GUIContent("主光-最低亮度", "无论主光亮度如何变化，角色shader中使用的亮度不会低于此亮度"));
		EditorGUILayout.PropertyField(_charAmbientS, new GUIContent("环境光-饱和度系数", "环境光饱和度为1.0时，角色shader中实际使用此饱和度"));
		EditorGUILayout.PropertyField(_charAmbientB, new GUIContent("环境光-固定亮度", "无论环境光亮度如何变化，角色shader中实际使用此亮度"));
		_sobj.ApplyModifiedProperties();
	}

}