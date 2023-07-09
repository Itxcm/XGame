// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "X7/WP-Glow"
{
	Properties
	{
		_BaseMap("Base-Map", 2D) = "white" {}
		_BaseColor("BaseColor", Color) = (1,1,1,0)
		_NormalMap("Normal-Map", 2D) = "white" {}
		_SmoothingMap("Smoothing-Map", 2D) = "white" {}
		_NoiseMap("Noise-Map", 2D) = "white" {}
		[HDR]_GlowColor("Glow-Color", Color) = (1,0.4843813,0.08823532,0)
		_EdgeHard("Edge-Hard", Range( -2 , 1.5)) = 0.2058824
		_Diss("Diss", Range( -2 , 1.5)) = -0.1882352
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _BaseMap;
		uniform float4 _BaseMap_ST;
		uniform float4 _BaseColor;
		uniform float4 _GlowColor;
		uniform sampler2D _NoiseMap;
		uniform float4 _NoiseMap_ST;
		uniform float _Diss;
		uniform float _EdgeHard;
		uniform sampler2D _SmoothingMap;
		uniform float4 _SmoothingMap_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = tex2D( _NormalMap, uv_NormalMap ).rgb;
			float2 uv_BaseMap = i.uv_texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw;
			float4 tex2DNode1 = tex2D( _BaseMap, uv_BaseMap );
			o.Albedo = ( tex2DNode1 * _BaseColor ).rgb;
			float2 uv_NoiseMap = i.uv_texcoord * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
			float4 tex2DNode4 = tex2D( _NoiseMap, uv_NoiseMap );
			float4 temp_cast_2 = (1.4).xxxx;
			float4 temp_cast_3 = (_Diss).xxxx;
			float4 temp_output_8_0 = (temp_cast_3 + (tex2DNode4 - float4( 0,0,0,0 )) * (float4( 1,1,1,0 ) - temp_cast_3) / (temp_cast_2 - float4( 0,0,0,0 )));
			float4 temp_cast_4 = (1.4).xxxx;
			float4 temp_cast_5 = (_Diss).xxxx;
			float4 clampResult10 = clamp( temp_output_8_0 , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 temp_cast_6 = (_EdgeHard).xxxx;
			float4 temp_cast_7 = (0.2882353).xxxx;
			float4 temp_output_19_0 = (float4( 0,0,0,0 ) + (clampResult10 - temp_cast_6) * (float4( 1,1,1,0 ) - float4( 0,0,0,0 )) / (temp_cast_7 - temp_cast_6));
			float4 temp_cast_8 = (1.4).xxxx;
			float4 temp_cast_9 = (( _Diss + 0.0 )).xxxx;
			float4 clampResult15 = clamp( (temp_cast_9 + (tex2DNode4 - float4( 0,0,0,0 )) * (float4( 1,1,1,0 ) - temp_cast_9) / (temp_cast_8 - float4( 0,0,0,0 ))) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 temp_cast_10 = (_EdgeHard).xxxx;
			float4 temp_cast_11 = (0.2882353).xxxx;
			float4 lerpResult22 = lerp( temp_output_19_0 , ( clampResult10 + clampResult15 ) , temp_output_19_0.r);
			float4 clampResult24 = clamp( lerpResult22 , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 clampResult26 = clamp( ( temp_output_8_0 + clampResult24 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			o.Emission = ( _GlowColor * 1.5 * clampResult26 * tex2DNode1.a ).rgb;
			float2 uv_SmoothingMap = i.uv_texcoord * _SmoothingMap_ST.xy + _SmoothingMap_ST.zw;
			o.Smoothness = tex2D( _SmoothingMap, uv_SmoothingMap ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15201
-1715;536;1202;664;3640.855;790.6696;4.947225;True;True
Node;AmplifyShaderEditor.RangedFloatNode;9;-2777.775,1364.201;Float;False;Property;_Diss;Diss;7;0;Create;True;0;0;False;0;-0.1882352;0.46;-2;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2780.177,1561.356;Float;False;Constant;_EdgeSub;Edge-Sub;7;0;Create;True;0;0;False;0;0;0;-8;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2749.27,1176.56;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;1.4;0;-2;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-2743.968,942.7433;Float;True;Property;_NoiseMap;Noise-Map;4;0;Create;True;0;0;False;0;None;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-2413.357,1475.667;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;8;-2215.812,1035.065;Float;True;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;14;-2231.335,1369.632;Float;True;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;10;-1808.006,1037.62;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1509.814,1247.487;Float;False;Property;_EdgeHard;Edge-Hard;6;0;Create;True;0;0;False;0;0.2058824;0.72;-2;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1493.087,1321.781;Float;False;Constant;_Float3;Float 3;5;0;Create;True;0;0;False;0;0.2882353;0;-2;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;15;-1801.849,1404.137;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;19;-1131.402,1267.051;Float;True;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-1343.82,1458.099;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;22;-786.6799,1338.661;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;24;-526.1888,1332.896;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-224.8819,1179.248;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;5;-734.3202,547.5363;Float;False;Property;_GlowColor;Glow-Color;5;1;[HDR];Create;True;0;0;False;0;1,0.4843813,0.08823532,0;1,0.3517241,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-703.8201,-377.4152;Float;True;Property;_BaseMap;Base-Map;0;0;Create;True;0;0;False;0;None;234fdbf4d84044b46a7778cde95dbf6e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;28;-697.5848,-143.4641;Float;False;Property;_BaseColor;BaseColor;1;0;Create;True;0;0;False;0;1,1,1,0;0.2573529,0.2573529,0.2573529,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-810.5313,772.403;Float;False;Constant;_GlowInstensity;Glow-Instensity;6;0;Create;True;0;0;False;0;1.5;0;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;26;-17.03278,844.2531;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-713.8201,297.5848;Float;True;Property;_SmoothingMap;Smoothing-Map;3;0;Create;True;0;0;False;0;None;67d0936cef50fd449972878bd7a20a68;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;345.4612,460.3609;Float;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-714.8201,99.5848;Float;True;Property;_NormalMap;Normal-Map;2;0;Create;True;0;0;False;0;None;2e9501602b6833e448a3c9fb0bbf2d36;True;0;True;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-232.5022,-217.0199;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;841.4461,-10.53953;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;X7/WP-Glow;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;0;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;9;0
WireConnection;12;1;13;0
WireConnection;8;0;4;0
WireConnection;8;2;11;0
WireConnection;8;3;9;0
WireConnection;14;0;4;0
WireConnection;14;2;11;0
WireConnection;14;3;12;0
WireConnection;10;0;8;0
WireConnection;15;0;14;0
WireConnection;19;0;10;0
WireConnection;19;1;20;0
WireConnection;19;2;21;0
WireConnection;18;0;10;0
WireConnection;18;1;15;0
WireConnection;22;0;19;0
WireConnection;22;1;18;0
WireConnection;22;2;19;0
WireConnection;24;0;22;0
WireConnection;25;0;8;0
WireConnection;25;1;24;0
WireConnection;26;0;25;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;6;2;26;0
WireConnection;6;3;1;4
WireConnection;27;0;1;0
WireConnection;27;1;28;0
WireConnection;0;0;27;0
WireConnection;0;1;2;0
WireConnection;0;2;6;0
WireConnection;0;4;3;0
ASEEND*/
//CHKSM=53E91999A7F02A3E905725910D9FE28D3BB7FBD6