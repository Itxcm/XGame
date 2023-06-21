// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3D/Actor/ActorPBR-HairBlender"
{
	Properties
	{
		_AlbedoMap("AlbedoMap", 2D) = "white" {}
		_OpacityMap("OpacityMap", 2D) = "white" {}
		_Alpha("Alpha", Range( 0 , 5)) = 2
		_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Smooth("Smooth", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf StandardCustomLighting keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _OpacityMap;
		uniform float4 _OpacityMap_ST;
		uniform float _Alpha;
		uniform float4 _BaseColor;
		uniform sampler2D _AlbedoMap;
		uniform float4 _AlbedoMap_ST;
		uniform float _Smooth;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_OpacityMap = i.uv_texcoord * _OpacityMap_ST.xy + _OpacityMap_ST.zw;
			float4 tex2DNode7 = tex2D( _OpacityMap, uv_OpacityMap );
			SurfaceOutputStandard s52 = (SurfaceOutputStandard ) 0;
			float2 uv_AlbedoMap = i.uv_texcoord * _AlbedoMap_ST.xy + _AlbedoMap_ST.zw;
			float4 tex2DNode51 = tex2D( _AlbedoMap, uv_AlbedoMap );
			s52.Albedo = ( _BaseColor * tex2DNode51 ).rgb;
			float3 ase_worldNormal = i.worldNormal;
			s52.Normal = ase_worldNormal;
			s52.Emission = float3( 0,0,0 );
			s52.Metallic = 0.0;
			s52.Smoothness = ( tex2DNode51 * _Smooth * tex2DNode7 ).r;
			s52.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi52 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g52 = UnityGlossyEnvironmentSetup( s52.Smoothness, data.worldViewDir, s52.Normal, float3(0,0,0));
			gi52 = UnityGlobalIllumination( data, s52.Occlusion, s52.Normal, g52 );
			#endif

			float3 surfResult52 = LightingStandard ( s52, viewDir, gi52 ).rgb;
			surfResult52 += s52.Emission;

			#ifdef UNITY_PASS_FORWARDADD//52
			surfResult52 -= s52.Emission;
			#endif//52
			float3 clampResult55 = clamp( surfResult52 , float3( 0,0,0 ) , float3( 1,1,1 ) );
			c.rgb = clampResult55;
			c.a = saturate( ( tex2DNode7 * _Alpha ) ).r;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
79;295;1285;572;-1112.657;934.7603;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;53;1627.18,-451.0427;Float;False;Property;_Smooth;Smooth;5;0;Create;True;0;0;False;0;0;0.7;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;1769.735,-307.6817;Float;True;Property;_OpacityMap;OpacityMap;2;0;Create;True;0;0;False;0;None;ac16464301d603d44bc87875f2297967;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;51;1587.694,-698.04;Float;True;Property;_AlbedoMap;AlbedoMap;1;0;Create;True;0;0;False;0;None;b343607d79a666042a9f7e5ebbc632cf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;45;1815.012,-868.7491;Float;False;Property;_BaseColor;BaseColor;4;0;Create;True;0;0;False;0;1,1,1,1;0.6838235,0.5357542,0.3771085,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;2101.881,-780.2117;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;48;1802.87,-108.3011;Float;False;Property;_Alpha;Alpha;3;0;Create;True;0;0;False;0;2;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;2053.857,-559.0602;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;54;2229.694,-631.2361;Float;False;Constant;_Metallic;Metallic;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomStandardSurface;52;2408.988,-672.8293;Float;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;2198.677,-217.2056;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;55;2780.087,-464.2069;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;47;2403.143,-315.9526;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3003.57,-683.6296;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;E3D/Actor/ActorPBR-HairBlender;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;1.53;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;50;0;45;0
WireConnection;50;1;51;0
WireConnection;56;0;51;0
WireConnection;56;1;53;0
WireConnection;56;2;7;0
WireConnection;52;0;50;0
WireConnection;52;3;54;0
WireConnection;52;4;56;0
WireConnection;46;0;7;0
WireConnection;46;1;48;0
WireConnection;55;0;52;0
WireConnection;47;0;46;0
WireConnection;0;9;47;0
WireConnection;0;13;55;0
ASEEND*/
//CHKSM=2373632CB27819F0991C01772DEEE7FFA9E48EFA