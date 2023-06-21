using UnityEngine;

[ExecuteInEditMode]
public class GlobalShaderProperty : MonoBehaviour {

	public Texture2D ToonRamp;
	public Texture2D MatCap;
	[Range(0, 1f)]
	public float CharLightSaturationScale = 0.5f;
	[Range(0, 8f)]
	public float CharLightStandardBrightness = 0.75f;
	[Range(0, 8f)]
	public float CharLightMinBrightness = 0.5f;
	[Range(0, 8f)]
	public float CharLightMaxBrightness = 1.5f;
	[Range(0, 1f)]
	public float CharAmbientSaturationScale = 0.5f;
	[Range(0, 8f)]
	public float CharAmbientBrightness = 0.75f;

	private Light _light = null;
	private Color _oldLightColor;
	private float _oldLightIntensity;
	private Color _oldAmbient;

	private void OnEnable() {
		getLight();
		updateTexture();
		updateLight();
		updateAmbient();
	}

	private void OnValidate() {
		updateTexture();
		updateLight();
		updateAmbient();
	}

	private void Update() {
		if (_light != null) {
			if (_light.color != _oldLightColor || _light.intensity != _oldLightIntensity) {
				updateLight();
			}
		}

		if (RenderSettings.ambientLight != _oldAmbient) {
			updateAmbient();
		}
	}

	void getLight() {
		var lights = GameObject.FindObjectsOfType<Light>();
		for (int i = 0; i < lights.Length; i++) {
			if (lights[i].type != LightType.Directional) continue;
			if (lights[i].renderMode == LightRenderMode.ForceVertex) continue;
			_light = lights[i];
			break;
		}
	}

	void updateLight() {
		if (_light == null) return;

		var color = _light.color * _light.intensity;
		float h, s, v;
		Color.RGBToHSV(color, out h, out s, out v);
		float fa = (CharLightMaxBrightness - CharLightStandardBrightness) / 7f;
		float fb = CharLightStandardBrightness - fa;
		color = Color.HSVToRGB(h, s * CharLightSaturationScale, Mathf.Max(v * fa + fb, CharLightMinBrightness));
		Shader.SetGlobalColor("_BHCharLight", color);

		_oldLightColor = _light.color;
		_oldLightIntensity = _light.intensity;
	}

	void updateAmbient() {
		var ambient = RenderSettings.ambientLight;
		float h, s, v;
		Color.RGBToHSV(ambient, out h, out s, out v);
		ambient = Color.HSVToRGB(h, s * CharAmbientSaturationScale, CharAmbientBrightness);
		Shader.SetGlobalColor("_BHCharAmbient", ambient);

		_oldAmbient = RenderSettings.ambientLight;
	}

	void updateTexture() {
		Shader.SetGlobalTexture("_BHToonRamp", ToonRamp);
		Shader.SetGlobalTexture("_BHMatCap", MatCap);
	}

}