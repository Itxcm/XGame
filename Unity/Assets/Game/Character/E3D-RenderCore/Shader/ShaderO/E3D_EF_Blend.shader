// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OM/Effect/OM-New-Blend"
{
	Properties
	{
		_BaseMap("BaseMap", 2D) = "white" {}
		[HDR]_BaseColor("BaseColor", Color) = (1,1,1,1)
		_BaseMaskMap("BaseMaskMap", 2D) = "white" {}
		_Glow("Glow", Range( 0 , 2)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow nolightmap  nodynlightmap nodirlightmap noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _BaseMap;
		uniform float4 _BaseMap_ST;
		uniform float4 _BaseColor;
		uniform sampler2D _BaseMaskMap;
		uniform float4 _BaseMaskMap_ST;
		uniform float _Glow;

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_BaseMap = i.uv_texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw;
			float4 tex2DNode1 = tex2D( _BaseMap, uv_BaseMap );
			o.Emission = ( tex2DNode1 * _BaseColor * i.vertexColor ).rgb;
			float2 uv_BaseMaskMap = i.uv_texcoord * _BaseMaskMap_ST.xy + _BaseMaskMap_ST.zw;
			o.Alpha = ( tex2D( _BaseMaskMap, uv_BaseMaskMap ).r * _BaseColor.a * i.vertexColor.a * tex2DNode1.a * _Glow );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15201
1969;96;1906;1004;1633.11;435.7661;1.306036;True;True
Node;AmplifyShaderEditor.SamplerNode;1;-1213.666,-382.1788;Float;True;Property;_BaseMap;BaseMap;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-1216.766,-198.8485;Float;True;Property;_BaseMaskMap;BaseMaskMap;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;3;-1195.155,147.7353;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2;-1192.339,-18.12692;Float;False;Property;_BaseColor;BaseColor;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-997.0687,294.3081;Float;False;Property;_Glow;Glow;3;0;Create;True;0;0;False;0;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-732.381,88.11995;Float;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-730.5629,-77.34168;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OM/Effect/OM-New-Blend;False;False;False;False;False;False;True;True;True;False;False;True;False;False;True;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;0;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;8;1
WireConnection;5;1;2;4
WireConnection;5;2;3;4
WireConnection;5;3;1;4
WireConnection;5;4;9;0
WireConnection;4;0;1;0
WireConnection;4;1;2;0
WireConnection;4;2;3;0
WireConnection;0;2;4;0
WireConnection;0;9;5;0
ASEEND*/
//CHKSM=A46D1E7770E469BB2EDFE8BEDC7DFCA64C1F4A69