// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OM-Low/Effect/Blender-Mask"
{
	Properties
	{
		_BaseMap("BaseMap", 2D) = "white" {}
		_BaseColor("BaseColor", Color) = (1,1,1,0)
		_Instensity("Instensity", Range( 0 , 5)) = 1
		_MaskMap("MaskMap", 2D) = "white" {}
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
		uniform sampler2D _MaskMap;
		uniform float4 _MaskMap_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_BaseMap = i.uv_texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw;
			half4 tex2DNode2 = tex2D( _BaseMap, uv_BaseMap );
			o.Emission = ( tex2DNode2 * _BaseColor * _Instensity * i.vertexColor ).rgb;
			float2 uv_MaskMap = i.uv_texcoord * _MaskMap_ST.xy + _MaskMap_ST.zw;
			half4 tex2DNode9 = tex2D( _MaskMap, uv_MaskMap );
			o.Alpha = ( tex2DNode2.a * i.vertexColor.a * tex2DNode9 * tex2DNode9.a * _BaseColor.a ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16302
8;91;1904;922;1179.864;476.0974;1.3;True;True
Node;AmplifyShaderEditor.VertexColorNode;6;-484,124;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-596.2776,308.4808;Float;True;Property;_MaskMap;MaskMap;4;0;Create;True;0;0;False;0;None;6a9f8cb89f6f3dc408b1097092f17c9d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-584.5,34.75;Float;False;Property;_Instensity;Instensity;3;0;Create;True;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-510.5,-129.25;Float;False;Property;_BaseColor;BaseColor;2;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-596.5,-324.25;Float;True;Property;_BaseMap;BaseMap;1;0;Create;True;0;0;False;0;f1ac2e4afbfd4634e9b88ae1ecfe82cd;0000000000000000f000000000000000;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;12,57;Float;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;12.5,-83.25;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;234,-129;Half;False;True;0;Half;ASEMaterialInspector;0;0;Unlit;OM-Low/Effect/Blender-Mask;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;2;4
WireConnection;7;1;6;4
WireConnection;7;2;9;0
WireConnection;7;3;9;4
WireConnection;7;4;4;4
WireConnection;5;0;2;0
WireConnection;5;1;4;0
WireConnection;5;2;3;0
WireConnection;5;3;6;0
WireConnection;0;2;5;0
WireConnection;0;9;7;0
ASEEND*/
//CHKSM=0B478B875081AAA73FBBAEFD498FF33225FB82B2