// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3D/Actor/Hair/2U-Blender"
{
	Properties
	{
		_AlbedoMap("AlbedoMap", 2D) = "white" {}
		_OpacityMap("OpacityMap", 2D) = "white" {}
		_Alpha("Alpha", Range( 0 , 5)) = 2
		[HDR]_BaseColor("BaseColor", Color) = (1,1,1,1)
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
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
			float2 uv2_texcoord2;
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

		uniform float _Alpha;
		uniform sampler2D _OpacityMap;
		uniform float4 _OpacityMap_ST;
		uniform float4 _BaseColor;
		uniform sampler2D _AlbedoMap;
		uniform float4 _AlbedoMap_ST;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv2_OpacityMap = i.uv2_texcoord2 * _OpacityMap_ST.xy + _OpacityMap_ST.zw;
			float4 tex2DNode7 = tex2D( _OpacityMap, uv2_OpacityMap );
			float2 uv2_AlbedoMap = i.uv2_texcoord2 * _AlbedoMap_ST.xy + _AlbedoMap_ST.zw;
			float4 tex2DNode51 = tex2D( _AlbedoMap, uv2_AlbedoMap );
			float4 temp_output_50_0 = ( _BaseColor * tex2DNode51 * tex2DNode7.a );
			c.rgb = temp_output_50_0.rgb;
			c.a = saturate( ( _Alpha * tex2DNode7.a ) );
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
1126;99;480;690;-2127.057;1287.11;1.932461;False;False
Node;AmplifyShaderEditor.SamplerNode;7;1855.044,-187.9424;Float;True;Property;_OpacityMap;OpacityMap;2;0;Create;True;0;0;False;0;None;d41e18bd3f347d045a04de04e4762754;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;48;1930.724,-309.8622;Float;False;Property;_Alpha;Alpha;3;0;Create;True;0;0;False;0;2;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;1893.827,-845.6469;Float;False;Property;_BaseColor;BaseColor;4;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;2401.271,-249.4012;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;51;1842.196,-667.457;Float;True;Property;_AlbedoMap;AlbedoMap;0;0;Create;True;0;0;False;0;None;beee2f7c578a72c48aa1f92845e00349;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;47;3042.09,-431.7303;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;56;3063.616,-785.7592;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;59;2487.27,-862.4925;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomStandardSurface;52;2795.201,-714.7304;Float;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;2348.854,-768.1464;Float;True;3;3;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;53;1941.59,-442.8705;Float;False;Property;_Smooth;Smooth;5;0;Create;True;0;0;False;0;1;0.64;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;2525.546,-468.4439;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;2378.599,-528.5319;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3320.383,-776.1838;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;E3D/Actor/Hair/2U-Blender;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;1;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;46;0;48;0
WireConnection;46;1;7;4
WireConnection;47;0;46;0
WireConnection;56;0;52;0
WireConnection;52;0;50;0
WireConnection;52;4;57;0
WireConnection;50;0;45;0
WireConnection;50;1;51;0
WireConnection;50;2;7;4
WireConnection;57;0;51;1
WireConnection;57;1;53;0
WireConnection;57;2;7;0
WireConnection;0;9;47;0
WireConnection;0;13;50;0
ASEEND*/
//CHKSM=936CCA8BE52DEE259E1B2DF76D364233E7F52DD0