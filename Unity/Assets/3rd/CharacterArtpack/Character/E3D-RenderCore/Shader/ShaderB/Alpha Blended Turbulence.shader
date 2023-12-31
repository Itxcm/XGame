﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "BH-effect/Alpha Blended Turbulence"
{
	Properties
	{
		_MainTex("Main_Texture", 2D) = "white" {}
		_Color01("Color", Color) = (1,1,1,1)
		_Blend_Texture("Blend_Texture_01", 2D) = "white" {}
		_Color02("Color", Color) = (1,1,1,1)
		_Blend_Texture01("Blend_Texture_02", 2D) = "black" {}
		_Color03("Color", Color) = (1,1,1,1)
		_Speed01("Blend_Texture_01_Speed", Float) = 1
		_Speed02("Blend_Texture_02_Speed", Float) = 1
		_LightenMain("Brightness_Main", Float) = 1
		_Lighten("Brightness_Blend", Float) = 1
	}

		SubShader
	{
		Tags
	{
		"Queue" = "Transparent"
		"IgnoreProjector" = "True"
		"RenderType" = "Transparent"
	}

		Cull Off
		ZWrite Off // Edit by hdh
		ZTest LEqual
		Fog{
		Mode Off
	}

		Pass{
		Name "FORWARD"
		Tags{ "LightMode" = "ForwardBase" }
		Blend SrcAlpha OneMinusSrcAlpha

		CGPROGRAM
#include "UnityCG.cginc"

#pragma only_renderers gles gles3 metal d3d9
#pragma vertex vert
#pragma fragment frag

		sampler2D _MainTex;
	half4 _Color01;
	sampler2D _Blend_Texture;
	half4 _Color02;
	sampler2D _Blend_Texture01;
	half4 _Color03;

	float4 _MainTex_ST;
	float4 _Blend_Texture_ST;
	float4 _Blend_Texture01_ST;

	// pack it TODO
	half _Speed01;
	half _Speed02;
	half _LightenMain;
	half _Lighten;

	struct vert_data {
		float4 vertex : POSITION;
		half4 vertexColor: COLOR;
		float2 uv : TEXCOORD0;
	};

	struct frag_data {
		float4 pos: SV_POSITION;
		half4 color: COLOR;
		float4 uv0: TEXCOORD0;
		float2 uv1: TEXCOORD1;
	};

	frag_data vert(vert_data IN) {
		frag_data o = (frag_data)0;
		o.uv0.xy = TRANSFORM_TEX(IN.uv, _MainTex);
		o.uv0.zw = TRANSFORM_TEX(IN.uv, _Blend_Texture);
		o.uv1.xy = TRANSFORM_TEX(IN.uv, _Blend_Texture01);

		o.color = IN.vertexColor;
		o.pos = UnityObjectToClipPos(IN.vertex);

		return o;
	}

	half4 frag(frag_data IN) : SV_TARGET
	{
		half4 mainColor = tex2D(_MainTex, IN.uv0.xy) * _Color01;

		IN.uv0.w += _Time.x*_Speed01;
		half4 blendColor = tex2D(_Blend_Texture, IN.uv0.zw) * _Color02;

		IN.uv1.xy += _Time.x*_Speed02.xx;
		half4 blendColor1 = tex2D(_Blend_Texture01, IN.uv1.xy) * _Color03;

		half4 add1 = blendColor + blendColor1;
		half4 multi0 = blendColor * blendColor1;
		half4 multi10 = add1 * multi0;

		half4 multi7 = mainColor * multi10;
		half4 multi9 = multi7 * _Lighten.xxxx;

		half4 add0 = mainColor + multi9;
		half4 multi11 = _LightenMain.xxxx * add0;

		half4 multi2 = multi11 * IN.color;

		half4 c = multi2*2;
		c.w = multi11.x *IN.color.w;

		return c;
	}

		ENDCG
	}
	}
}