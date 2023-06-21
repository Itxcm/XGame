// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3DEffect/C3/Mask-UV"
{
	Properties
	{
		_MaskMap("MaskMap", 2D) = "white" {}
		_NoiseMap("NoiseMap", 2D) = "white" {}
		_MaskSpeed("MaskSpeed", Vector) = (0,0,0,0)
		_NoiseSpeed("NoiseSpeed", Vector) = (0,0,0,0)
		_BaseMap("BaseMap", 2D) = "white" {}
		_Power("Power", Range( 0.1 , 10)) = 0.1
		[HDR]_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Glow("Glow", Range( 0 , 2)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow nolightmap  nodynlightmap nodirlightmap noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _BaseColor;
		uniform sampler2D _BaseMap;
		uniform float4 _BaseMap_ST;
		uniform sampler2D _MaskMap;
		uniform float2 _MaskSpeed;
		uniform float4 _MaskMap_ST;
		uniform sampler2D _NoiseMap;
		uniform float2 _NoiseSpeed;
		uniform float4 _NoiseMap_ST;
		uniform float _Power;
		uniform float _Glow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_BaseMap = i.uv_texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw;
			float4 tex2DNode54 = tex2D( _BaseMap, uv_BaseMap );
			o.Emission = ( ( _BaseColor * i.vertexColor ) * tex2DNode54 * i.vertexColor ).rgb;
			float2 uv0_MaskMap = i.uv_texcoord * _MaskMap_ST.xy + _MaskMap_ST.zw;
			float2 panner49 = ( _Time.y * _MaskSpeed + uv0_MaskMap);
			float4 tex2DNode50 = tex2D( _MaskMap, panner49 );
			float2 uv0_NoiseMap = i.uv_texcoord * _NoiseMap_ST.xy + _NoiseMap_ST.zw;
			float2 panner31 = ( _Time.y * _NoiseSpeed + uv0_NoiseMap);
			float4 tex2DNode1 = tex2D( _NoiseMap, panner31 );
			float blendOpSrc75 = ( tex2DNode1.r * tex2DNode1.a );
			float blendOpDest75 = ( tex2DNode54.r * tex2DNode54.a );
			o.Alpha = ( ( ( tex2DNode50.r * tex2DNode50.a ) * pow( ( saturate( ( blendOpDest75 / blendOpSrc75 ) )) , _Power ) * ( _BaseColor.a * i.vertexColor.a * _BaseColor.r ) ) * _Glow );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
2148;162;1532;834;2882.561;2285.637;2.825804;True;False
Node;AmplifyShaderEditor.Vector2Node;32;-2314.371,-1663.796;Float;False;Property;_NoiseSpeed;NoiseSpeed;3;0;Create;True;0;0;False;0;0,0;-0.7,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;38;-2312.774,-1546.27;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-2315.33,-1779.853;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;31;-1976.389,-1684.765;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-2151.625,-1181.001;Float;False;0;50;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;46;-2099.566,-1032.959;Float;False;Property;_MaskSpeed;MaskSpeed;2;0;Create;True;0;0;False;0;0,0;-0.7,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;48;-2110.362,-884.8597;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1789.977,-1714.353;Float;True;Property;_NoiseMap;NoiseMap;1;0;Create;True;0;0;False;0;None;4d4bbbde818324e448b2555154bfcf17;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-1533.399,-907.556;Float;True;Property;_BaseMap;BaseMap;4;0;Create;True;0;0;False;0;None;5c7ab866321a9944080f4ef597ebf585;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;49;-1780.942,-1077.812;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;-1196.578,-854.689;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-1284.83,-1792.3;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;83;-1551.525,-1312.383;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;76;-969.483,-1543.922;Float;False;Property;_Power;Power;5;0;Create;True;0;0;False;0;0.1;3.3;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;81;-1576.468,-1478.667;Float;False;Property;_BaseColor;BaseColor;6;1;[HDR];Create;True;0;0;False;0;1,1,1,1;2.093309,2.905,2.837826,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;75;-960.0117,-1775.48;Float;True;Divide;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;-1542.995,-1116.785;Float;True;Property;_MaskMap;MaskMap;0;0;Create;True;0;0;False;0;None;6e7b36231fbada54f952b5aad92a4047;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-825.606,-1140.458;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-826.0233,-1251.31;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;94;-671.4628,-1679.357;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-479.818,-1175.187;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-831.3149,-1343.963;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-541.821,-965.4131;Float;False;Property;_Glow;Glow;7;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;-250.821,-1033.413;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-473.9224,-1401.493;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-80.06059,-1386.238;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;E3DEffect/C3/Mask-UV;False;False;False;False;False;False;True;True;True;False;False;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;14;0
WireConnection;31;2;32;0
WireConnection;31;1;38;0
WireConnection;1;1;31;0
WireConnection;49;0;47;0
WireConnection;49;2;46;0
WireConnection;49;1;48;0
WireConnection;93;0;54;1
WireConnection;93;1;54;4
WireConnection;69;0;1;1
WireConnection;69;1;1;4
WireConnection;75;0;69;0
WireConnection;75;1;93;0
WireConnection;50;1;49;0
WireConnection;87;0;50;1
WireConnection;87;1;50;4
WireConnection;84;0;81;4
WireConnection;84;1;83;4
WireConnection;84;2;81;1
WireConnection;94;0;75;0
WireConnection;94;1;76;0
WireConnection;67;0;87;0
WireConnection;67;1;94;0
WireConnection;67;2;84;0
WireConnection;82;0;81;0
WireConnection;82;1;83;0
WireConnection;97;0;67;0
WireConnection;97;1;96;0
WireConnection;85;0;82;0
WireConnection;85;1;54;0
WireConnection;85;2;83;0
WireConnection;0;2;85;0
WireConnection;0;9;97;0
ASEEND*/
//CHKSM=DCE91F97688DB4E7443DEF3DECB7E55AF8690F6A