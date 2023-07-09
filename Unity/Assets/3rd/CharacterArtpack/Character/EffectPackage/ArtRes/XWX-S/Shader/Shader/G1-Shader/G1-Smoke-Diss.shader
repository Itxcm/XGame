// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "G1/Effect/G1-Smoke-Diss"
{
	Properties
	{
		_DissolveMap("DissolveMap", 2D) = "white" {}
		_LightDirect("LightDirect", Vector) = (2.24,1,0,0)
		[HDR]_LightColor("LightColor", Color) = (1,0.9274848,0.5220588,0)
		_DarkColor("DarkColor", Color) = (0.1323529,0.04865917,0.04865917,0)
		[Toggle]_DarkEnd("DarkEnd", Float) = 1
		_EdgeScale("Edge-Scale", Range( -1 , 1)) = -0.1370634
		_EdgeSoft("Edge-Soft", Range( 0 , 1)) = 0
		[Toggle]_UVSpeed("UV-Speed", Float) = 1
		_UVOffset("UV-Offset", Vector) = (0.1,0,0,0)
		_VTiling("V-Tiling", Range( 0 , 3)) = 2
		_UTiling("U-Tiling", Range( 0 , 3)) = 2
		_VertexOffset("VertexOffset", Range( 0 , 0.2)) = 0
		_Cutoff( "Mask Clip Value", Float ) = 0.2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldNormal;
			float3 viewDir;
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _DarkColor;
		uniform float4 _LightColor;
		uniform float _EdgeSoft;
		uniform float3 _LightDirect;
		uniform float _DarkEnd;
		uniform float _EdgeScale;
		uniform sampler2D _DissolveMap;
		uniform float _UVSpeed;
		uniform float _UTiling;
		uniform float _VTiling;
		uniform float2 _UVOffset;
		uniform float _VertexOffset;
		uniform float _Cutoff = 0.2;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 appendResult72 = (float2(_UTiling , _VTiling));
			float mulTime66 = _Time.y * 0.4;
			float2 panner59 = ( float2( 0,0 ) + mulTime66 * _UVOffset);
			float2 uv_TexCoord62 = v.texcoord.xy * appendResult72 + panner59;
			float temp_output_42_0 = ( v.color.a * 0.5 );
			v.vertex.xyz += ( float4( ase_vertexNormal , 0.0 ) * tex2Dlod( _DissolveMap, float4( uv_TexCoord62, 0, 0) ) * _VertexOffset * temp_output_42_0 ).rgb;
		}

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldNormal = i.worldNormal;
			float3 normalizeResult11 = normalize( ( i.viewDir + _LightDirect ) );
			float dotResult6 = dot( ase_worldNormal , normalizeResult11 );
			float temp_output_42_0 = ( i.vertexColor.a * 0.5 );
			float smoothstepResult12 = smoothstep( 0 , _EdgeSoft , ( dotResult6 + lerp(_EdgeScale,(-1.5 + (temp_output_42_0 - 0) * (1 - -1.5) / (1 - 0)),_DarkEnd) ));
			float4 lerpResult14 = lerp( _DarkColor , _LightColor , smoothstepResult12);
			o.Emission = lerpResult14.rgb;
			o.Alpha = 1;
			float2 appendResult72 = (float2(_UTiling , _VTiling));
			float mulTime66 = _Time.y * 0.4;
			float2 panner59 = ( float2( 0,0 ) + mulTime66 * _UVOffset);
			float2 uv_TexCoord62 = i.uv_texcoord * appendResult72 + panner59;
			float4 temp_cast_1 = (i.vertexColor.a).xxxx;
			clip( step( tex2D( _DissolveMap, lerp(float2( 0,0 ),uv_TexCoord62,_UVSpeed) ) , temp_cast_1 ).r - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal 
		#pragma surface surf Unlit keepalpha fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				fixed4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = worldViewDir;
				surfIN.worldNormal = IN.worldNormal;
				surfIN.vertexColor = IN.color;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15201
8;30;1904;1042;1717.563;-438.47;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;26;-2724.342,840.2227;Float;False;Constant;_Scale;Scale;7;0;Create;True;0;0;False;0;0.5;0.001;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;23;-2714.142,645.502;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;9;-2682.263,332.928;Float;False;Property;_LightDirect;LightDirect;1;0;Create;True;0;0;False;0;2.24,1,0;-17.07,65.98,-1.12;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;4;-2653.924,180.7262;Float;False;World;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-2400.582,254.4814;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-2303.789,770.2028;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-2619.746,1174.603;Float;False;Property;_UTiling;U-Tiling;10;0;Create;True;0;0;False;0;2;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-2621.966,1250.908;Float;False;Property;_VTiling;V-Tiling;9;0;Create;True;0;0;False;0;2;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;66;-2667.731,1598.232;Float;False;1;0;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;61;-2700.101,1447.778;Float;False;Property;_UVOffset;UV-Offset;8;0;Create;True;0;0;False;0;0.1,0;0.1,-0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldNormalVector;5;-2131.22,39.14645;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;11;-2124.976,252.4528;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;35;-2020.996,770.3228;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1.5;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;72;-2288.966,1194.908;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;59;-2250.448,1429.605;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1789.844,328.4578;Float;False;Property;_EdgeScale;Edge-Scale;5;0;Create;True;0;0;False;0;-0.1370634;-0.1307948;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;44;-1417.844,326.7504;Float;False;Property;_DarkEnd;DarkEnd;4;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;-1980.545,1201.365;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;6;-1899.629,49.0368;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;70;-1351.346,846.7946;Float;False;Property;_UVSpeed;UV-Speed;7;0;Create;True;0;0;False;0;1;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1339.951,490.543;Float;False;Property;_EdgeSoft;Edge-Soft;6;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1139.833,244.8658;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;58;-1035.685,1064.672;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;12;-886.5852,337.1157;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;24;-1030.428,690.7875;Float;True;Property;_DissolveMap;DissolveMap;0;0;Create;True;0;0;False;0;e5e4f8d6f0dfeca45a8fcc8174dfa252;e5e4f8d6f0dfeca45a8fcc8174dfa252;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;17;-864.2379,-74.31341;Float;False;Property;_LightColor;LightColor;2;1;[HDR];Create;True;0;0;False;0;1,0.9274848,0.5220588,0;1,0.9899592,0.9338235,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;63;-931.7249,908.9817;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;67;-1020.433,1275.994;Float;False;Property;_VertexOffset;VertexOffset;11;0;Create;True;0;0;False;0;0;0.0481;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;18;-890.2839,108.7097;Float;False;Property;_DarkColor;DarkColor;3;0;Create;True;0;0;False;0;0.1323529,0.04865917,0.04865917,0;0.6764706,0.6461461,0.5919117,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;28;-586.0822,566.1339;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;14;-410.2794,208.6186;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-570.1119,960.6886;Float;False;4;4;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;69;-1662.884,735.455;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-100.0574,157.8961;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;G1/Effect/G1-Smoke-Diss;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;0;False;0;Masked;0.2;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;False;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;12;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;57;0;4;0
WireConnection;57;1;9;0
WireConnection;42;0;23;4
WireConnection;42;1;26;0
WireConnection;11;0;57;0
WireConnection;35;0;42;0
WireConnection;72;0;65;0
WireConnection;72;1;73;0
WireConnection;59;2;61;0
WireConnection;59;1;66;0
WireConnection;44;0;20;0
WireConnection;44;1;35;0
WireConnection;62;0;72;0
WireConnection;62;1;59;0
WireConnection;6;0;5;0
WireConnection;6;1;11;0
WireConnection;70;1;62;0
WireConnection;19;0;6;0
WireConnection;19;1;44;0
WireConnection;58;1;62;0
WireConnection;12;0;19;0
WireConnection;12;2;13;0
WireConnection;24;1;70;0
WireConnection;28;0;24;0
WireConnection;28;1;23;4
WireConnection;14;0;18;0
WireConnection;14;1;17;0
WireConnection;14;2;12;0
WireConnection;64;0;63;0
WireConnection;64;1;58;0
WireConnection;64;2;67;0
WireConnection;64;3;42;0
WireConnection;0;2;14;0
WireConnection;0;10;28;0
WireConnection;0;11;64;0
ASEEND*/
//CHKSM=C6C3184C204D2F2F157E8A6F5CF69DB6F62C593B