using UnityEngine;

[ExecuteInEditMode]
public class WeatherProperty : MonoBehaviour {

	public Texture2D SnowBase;
	public Texture2D SnowTerrain0;
	public Texture2D SnowTerrain1;
	public Texture2D SnowTerrain2;
	public Texture2D SnowTerrain3;
	[Range(0, 1f)]
	public float SnowThreshold = 0.5f;
	[Range(0, 1f)]
	public float SnowRigidity = 0.75f;

	private void OnEnable() {
		updateKeywords();
		updateTexture();
		updateParams();
	}

	private void OnValidate() {
		updateKeywords();
		updateTexture();
		updateParams();
	}

	private void Update() {
		updateKeywords();
		updateTexture();
		updateParams();
	}

	void updateKeywords() {
		Shader.EnableKeyword("WEATHER_SNOW");
		Shader.DisableKeyword("WEATHER_RAIN");
	}

	void updateParams() {
		Vector4 snowParams = new Vector4(SnowRigidity * 20f, SnowRigidity * SnowThreshold * -20f);
		Shader.SetGlobalVector("_BHSnowParams", snowParams);
	}

	void updateTexture() {
		Shader.SetGlobalTexture("_BHSnow", SnowBase);
		Shader.SetGlobalTexture("_BHSnowTerrain0", SnowTerrain0);
		Shader.SetGlobalTexture("_BHSnowTerrain1", SnowTerrain1);
		Shader.SetGlobalTexture("_BHSnowTerrain2", SnowTerrain2);
		Shader.SetGlobalTexture("_BHSnowTerrain3", SnowTerrain3);
	}

}