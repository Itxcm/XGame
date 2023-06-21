// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3DEffect/C3/Blast-3T-3C"
{
	Properties
	{
		_SmokeColor("SmokeColor", Color) = (0.3183391,0.3949051,0.6764706,0)
		[HDR]_AbroadColor("AbroadColor", Color) = (2,0.6916838,0.1029413,1)
		[HDR]_WithinColor("WithinColor", Color) = (1.5,1.060289,0.6507353,1)
		_FireMap("FireMap", 2D) = "white" {}
		_UVFlowSpeed("UVFlowSpeed", Vector) = (0,-0.3,0,0)
		_UVTiling("UV-Tiling", Range( 0 , 4)) = 0
		_SmokeTexture("SmokeTexture", 2D) = "white" {}
		_DissloveMap("DissloveMap", 2D) = "white" {}
		_FireEdge("FireEdge", Range( 1 , 1.5)) = 0.468391
		_FireOffsetInstensity("Fire-Offset-Instensity", Range( 0 , 3)) = 0.468391
		[Toggle]_FireOffset("Fire-Offset", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
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
		#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			half4 uv_tex4coord;
			half2 uv_texcoord;
		};

		uniform half _FireOffsetInstensity;
		uniform half _FireOffset;
		uniform sampler2D _SmokeTexture;
		uniform half _UVTiling;
		uniform half2 _UVFlowSpeed;
		uniform sampler2D _FireMap;
		uniform half4 _WithinColor;
		uniform half4 _AbroadColor;
		uniform half _FireEdge;
		uniform half4 _SmokeColor;
		uniform sampler2D _DissloveMap;
		uniform float4 _DissloveMap_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			half2 temp_cast_1 = (_UVTiling).xx;
			float mulTime28 = _Time.y * 0.4;
			float2 panner27 = ( mulTime28 * ( _UVFlowSpeed * 3.0 ) + float2( 0,0 ));
			float2 uv_TexCoord25 = v.texcoord.xy * temp_cast_1 + panner27;
			half4 tex2DNode8 = tex2Dlod( _SmokeTexture, half4( uv_TexCoord25, 0, 0.0) );
			half4 temp_cast_2 = (v.texcoord.z).xxxx;
			half4 tex2DNode44 = tex2Dlod( _FireMap, half4( uv_TexCoord25, 0, 0.0) );
			float4 temp_output_52_0 = step( temp_cast_2 , tex2DNode44 );
			v.vertex.xyz += ( half4( ase_vertexNormal , 0.0 ) * _FireOffsetInstensity * lerp(( tex2DNode8 * 1.0 ),temp_output_52_0,_FireOffset) * v.texcoord1.x ).rgb;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			half4 temp_cast_0 = (i.uv_tex4coord.z).xxxx;
			half2 temp_cast_1 = (_UVTiling).xx;
			float mulTime28 = _Time.y * 0.4;
			float2 panner27 = ( mulTime28 * ( _UVFlowSpeed * 3.0 ) + float2( 0,0 ));
			float2 uv_TexCoord25 = i.uv_texcoord * temp_cast_1 + panner27;
			half4 tex2DNode44 = tex2D( _FireMap, uv_TexCoord25 );
			float4 lerpResult49 = lerp( _WithinColor , _AbroadColor , step( temp_cast_0 , ( tex2DNode44 * _FireEdge ) ));
			half4 tex2DNode8 = tex2D( _SmokeTexture, uv_TexCoord25 );
			half4 temp_cast_2 = (i.uv_tex4coord.z).xxxx;
			float4 temp_output_52_0 = step( temp_cast_2 , tex2DNode44 );
			float4 lerpResult48 = lerp( lerpResult49 , ( tex2DNode8 * _SmokeColor ) , temp_output_52_0);
			o.Emission = lerpResult48.rgb;
			float2 uv_DissloveMap = i.uv_texcoord * _DissloveMap_ST.xy + _DissloveMap_ST.zw;
			half4 temp_cast_4 = (i.uv_tex4coord.w).xxxx;
			o.Alpha = step( tex2D( _DissloveMap, uv_DissloveMap ) , temp_cast_4 ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
459;488;1552;1004;3054.533;-928.2885;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;40;-2903.727,792.3706;Float;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;1;-2918.345,614.2433;Float;False;Property;_UVFlowSpeed;UVFlowSpeed;4;0;Create;True;0;0;False;0;0,-0.3;-0.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;28;-2508.144,952.553;Float;False;1;0;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-2657.727,706.3706;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2373.397,729.5186;Float;False;Property;_UVTiling;UV-Tiling;5;0;Create;True;0;0;False;0;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;27;-2280.379,832.2592;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-2048.54,758.6947;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;44;-1701.74,1228.145;Float;True;Property;_FireMap;FireMap;3;0;Create;True;0;0;False;0;None;e5e4f8d6f0dfeca45a8fcc8174dfa252;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-1509.279,773.3278;Float;False;Property;_FireEdge;FireEdge;8;0;Create;True;0;0;False;0;0.468391;1.1;1;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-611.7031,2169.919;Float;False;Constant;_FireOffsetInstensity2;Fire-Offset-Instensity2;13;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-1606.438,137.6774;Float;True;Property;_SmokeTexture;SmokeTexture;6;0;Create;True;0;0;False;0;None;e5e4f8d6f0dfeca45a8fcc8174dfa252;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-942.1599,746.4808;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;-1358.111,1491.636;Float;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-148.8972,2143.39;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;10;-639.3372,724.0616;Float;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;50;-684.5942,240.6183;Float;False;Property;_WithinColor;WithinColor;2;1;[HDR];Create;True;0;0;False;0;1.5,1.060289,0.6507353,1;1.5,1.060289,0.6507353,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;47;-679.1132,55.16392;Float;False;Property;_SmokeColor;SmokeColor;0;0;Create;True;0;0;False;0;0.3183391,0.3949051,0.6764706,0;0.2647059,0.2311478,0.2160467,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;52;-594.5342,1038.277;Float;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;51;-681.1942,421.127;Float;False;Property;_AbroadColor;AbroadColor;1;1;[HDR];Create;True;0;0;False;0;2,0.6916838,0.1029413,1;2,0.6916838,0.1029413,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-341.4988,71.61521;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;54;757.3148,1691.105;Float;False;Property;_FireOffsetInstensity;Fire-Offset-Instensity;9;0;Create;True;0;0;False;0;0.468391;0.5;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;59;329.4744,1976.929;Float;False;Property;_FireOffset;Fire-Offset;10;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;56;829.1478,1534.666;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;198.2454,934.8857;Float;True;Property;_DissloveMap;DissloveMap;7;0;Create;True;0;0;False;0;723d609500fd514409fabd10ed79ed0e;e5e4f8d6f0dfeca45a8fcc8174dfa252;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;49;-211.4665,350.0295;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;90;-1354.967,1812.505;Float;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;48;263.8259,358.7079;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;14;970.1347,1025.66;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;1161.72,1675.055;Float;True;4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;26;-2510.379,828.2592;Float;False;Constant;_Vector1;Vector 1;0;0;Create;True;0;0;False;0;0,-0.9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1922.739,877.3234;Half;False;True;2;Half;ASEMaterialInspector;0;0;Unlit;E3DEffect/C3/Blast-3T-3C;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;False;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;1;0
WireConnection;38;1;40;0
WireConnection;27;2;38;0
WireConnection;27;1;28;0
WireConnection;25;0;34;0
WireConnection;25;1;27;0
WireConnection;44;1;25;0
WireConnection;8;1;25;0
WireConnection;53;0;44;0
WireConnection;53;1;23;0
WireConnection;91;0;8;0
WireConnection;91;1;60;0
WireConnection;10;0;42;3
WireConnection;10;1;53;0
WireConnection;52;0;42;3
WireConnection;52;1;44;0
WireConnection;7;0;8;0
WireConnection;7;1;47;0
WireConnection;59;0;91;0
WireConnection;59;1;52;0
WireConnection;49;0;50;0
WireConnection;49;1;51;0
WireConnection;49;2;10;0
WireConnection;48;0;49;0
WireConnection;48;1;7;0
WireConnection;48;2;52;0
WireConnection;14;0;9;0
WireConnection;14;1;42;4
WireConnection;32;0;56;0
WireConnection;32;1;54;0
WireConnection;32;2;59;0
WireConnection;32;3;90;1
WireConnection;0;2;48;0
WireConnection;0;9;14;0
WireConnection;0;11;32;0
ASEEND*/
//CHKSM=D3DCBB81356717796A76744AF069D46AD4CEF4DE