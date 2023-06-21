// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3DEffect/C1/Fresnel"
{
	Properties
	{
		_BaseMap("BaseMap", 2D) = "white" {}
		[HDR]_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Power("Power", Range( 0 , 1)) = 1
		[HDR]_FresnelColor("FresnelColor", Color) = (1,1,1,1)
		_Glow("Glow", Range( 0 , 2)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow nolightmap  nodynlightmap nodirlightmap nofog noforwardadd 
		struct Input
		{
			half2 uv_texcoord;
			float4 vertexColor : COLOR;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _BaseMap;
		uniform float4 _BaseMap_ST;
		uniform half4 _BaseColor;
		uniform half4 _FresnelColor;
		uniform half _Power;
		uniform half _Glow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_BaseMap = i.uv_texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw;
			half4 tex2DNode61 = tex2D( _BaseMap, uv_BaseMap );
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			half3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV110 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode110 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV110, exp( (2.0 + (_Power - 1.0) * (50.0 - 2.0) / (10.0 - 1.0)) ) ) );
			o.Emission = ( ( ( tex2DNode61 * _BaseColor * i.vertexColor ) + ( _FresnelColor * fresnelNode110 * _FresnelColor.a ) ) * _Glow ).rgb;
			o.Alpha = ( _BaseColor.a * i.vertexColor.a * tex2DNode61.a );
		}

		ENDCG
	}
}
/*ASEBEGIN
Version=16400
2064;128;1552;1004;1299.611;226.0845;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;77;-919.2999,506.8064;Float;False;Property;_Power;Power;2;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;76;-629.3522,512.2625;Float;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;10;False;3;FLOAT;2;False;4;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.ExpOpNode;89;-437.0229,516.4092;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;-726.7686,-197.304;Float;True;Property;_BaseMap;BaseMap;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;85;-687.8392,152.5468;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;107;-259.7299,263.0547;Float;False;Property;_FresnelColor;FresnelColor;3;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;84;-687.6387,-12.07886;Float;False;Property;_BaseColor;BaseColor;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;110;-295.2469,442.6682;Float;True;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;82.16531,109.5336;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;71.57044,238.9676;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;86;219.4559,314.3828;Float;False;Property;_Glow;Glow;4;0;Create;True;0;0;False;0;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;93;302.1277,204.2625;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;551.6769,220.0482;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;69.59459,372.9392;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;967.8286,248.1824;Half;False;True;2;Half;;0;0;Unlit;E3DEffect/C1/Fresnel;False;False;False;False;False;False;True;True;True;True;False;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;76;0;77;0
WireConnection;89;0;76;0
WireConnection;110;3;89;0
WireConnection;83;0;61;0
WireConnection;83;1;84;0
WireConnection;83;2;85;0
WireConnection;92;0;107;0
WireConnection;92;1;110;0
WireConnection;92;2;107;4
WireConnection;93;0;83;0
WireConnection;93;1;92;0
WireConnection;62;0;93;0
WireConnection;62;1;86;0
WireConnection;87;0;84;4
WireConnection;87;1;85;4
WireConnection;87;2;61;4
WireConnection;0;2;62;0
WireConnection;0;9;87;0
ASEEND*/
//CHKSM=B08007B56C84533A43DDDA15FC8C48C0CF0E2E39