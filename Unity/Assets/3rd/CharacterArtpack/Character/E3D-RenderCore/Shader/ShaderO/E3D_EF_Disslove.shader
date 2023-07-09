// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OM-Low/Effect/Disslove"
{
	Properties
	{
		_BaseMap("BaseMap", 2D) = "white" {}
		_BaseColor("BaseColor", Color) = (1,1,1,0)
		_Instensity("Instensity", Range( 0 , 5)) = 2
		_DissloveMap("DissloveMap", 2D) = "white" {}
		_Progress("Progress", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma target 2.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			half2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _BaseMap;
		uniform float4 _BaseMap_ST;
		uniform half4 _BaseColor;
		uniform half _Instensity;
		uniform sampler2D _DissloveMap;
		uniform float4 _DissloveMap_ST;
		uniform half _Progress;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_BaseMap = i.uv_texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw;
			half4 tex2DNode2 = tex2D( _BaseMap, uv_BaseMap );
			o.Emission = ( tex2DNode2 * _BaseColor * i.vertexColor * _Instensity ).rgb;
			float2 uv_DissloveMap = i.uv_texcoord * _DissloveMap_ST.xy + _DissloveMap_ST.zw;
			half4 tex2DNode6 = tex2D( _DissloveMap, uv_DissloveMap );
			half4 temp_cast_1 = (( 1.0 - ( i.vertexColor.a * _Progress ) )).xxxx;
			o.Alpha = saturate( ( tex2DNode2.a * (float4( 0.06617647,0.06617647,0.06617647,0 ) + (( tex2DNode6 * tex2DNode6.a ) - temp_cast_1) * (float4( 1,1,1,0 ) - float4( 0.06617647,0.06617647,0.06617647,0 )) / (float4( 1,1,1,0 ) - temp_cast_1)) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
300;176;1112;805;2223.1;743.0719;1.984342;True;False
Node;AmplifyShaderEditor.RangedFloatNode;11;-1122.1,370.0005;Float;False;Property;_Progress;Progress;5;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;15;-1042.443,156.6209;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-514.6996,79.80011;Float;True;Property;_DissloveMap;DissloveMap;4;0;Create;True;0;0;False;0;2dc632fd51bd9424cae5c872c6344bbb;1780456a98945de4a962f595f1e364af;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-769.7073,309.5769;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-86.20767,139.9769;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;19;-515.807,310.5769;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-836.0001,-408.65;Float;True;Property;_BaseMap;BaseMap;1;0;Create;True;0;0;False;0;f1ac2e4afbfd4634e9b88ae1ecfe82cd;9063c600ead4ae6408e907f9dcc8e7f1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;10;188.5307,172.7778;Float;True;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;3;COLOR;0.06617647,0.06617647,0.06617647,0;False;4;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;534.0688,138.2192;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-828.6,-28.04995;Float;False;Property;_Instensity;Instensity;3;0;Create;True;0;0;False;0;2;2;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-756.6002,-203.55;Float;False;Property;_BaseColor;BaseColor;2;0;Create;True;0;0;False;0;1,1,1,0;0.7058823,0.7058823,0.7058823,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;13;771.0714,145.8941;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-320.1999,-117.35;Float;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1025.511,-55.89998;Half;False;True;0;Half;ASEMaterialInspector;0;0;Unlit;OM-Low/Effect/Disslove;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;15;4
WireConnection;20;1;11;0
WireConnection;18;0;6;0
WireConnection;18;1;6;4
WireConnection;19;0;20;0
WireConnection;10;0;18;0
WireConnection;10;1;19;0
WireConnection;22;0;2;4
WireConnection;22;1;10;0
WireConnection;13;0;22;0
WireConnection;5;0;2;0
WireConnection;5;1;4;0
WireConnection;5;2;15;0
WireConnection;5;3;3;0
WireConnection;0;2;5;0
WireConnection;0;9;13;0
ASEEND*/
//CHKSM=0872D23B6E125A06CCA59FC480F31E6AD0838C91