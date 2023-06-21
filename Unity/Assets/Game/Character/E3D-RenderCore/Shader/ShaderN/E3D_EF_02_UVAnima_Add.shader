// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//
//
Shader "Moba_EF/02_UVAnim_Add" {

	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
		_SpeedX ("Speed X", float) = 1
		_SpeedY ("Speed Y", float) = 1
	}

	SubShader {
		Tags { "Queue"="Transparent +1" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha One
		Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }

		Pass {
		CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
	
			#include "UnityCG.cginc"
		
			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _SpeedX;
			float _SpeedY;
			float4 _Color;
	
			struct appdata_t {
				float4 vertex : POSITION;
				fixed2 uv : TEXCOORD0;
				fixed4 color: COLOR;
			};
	
			struct v2f {
				float4 vertex : POSITION;
				fixed2 uv: TEXCOORD0;
				fixed4 color: COLOR;
			};
			
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				float2 uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv.x = uv.x + frac(_Time * _SpeedX);
				o.uv.y = uv.y + frac(_Time * _SpeedY);
				o.color = v.color;
				return o;
			}
	
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 c = tex2D( _MainTex, i.uv ) * i.color * _Color;
				return c;
			}

		ENDCG 
		}
	}

	Fallback "Mobile/Particles/Additive"
}

