// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HIE/PBR/HardSurface-2T-MGround"
{
	Properties
	{
		_AlbedoMap("AlbedoMap", 2D) = "white" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 1
		[HDR]_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Metallic("Metallic", Range( 0 , 1)) = 1
		_PBRMaskMap("PBRMaskMap", 2D) = "white" {}
		_Ref("_Ref", 2D) = "white" {}
		_RefMini("RefMini", Range( 0 , 1)) = 0
		_RefLight("RefLight", Range( 0 , 1)) = -0.1529412
		_MirrorSmoothPower("Mirror-Smooth-Power", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 2.0
		struct Input
		{
			float3 worldNormal;
			float2 uv_texcoord;
			float3 worldPos;
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

		uniform sampler2D _AlbedoMap;
		uniform float4 _AlbedoMap_ST;
		uniform float4 _BaseColor;
		uniform float _Metallic;
		uniform sampler2D _PBRMaskMap;
		uniform float4 _PBRMaskMap_ST;
		uniform float _Smoothness;
		uniform sampler2D _Ref;
		uniform float _RefMini;
		uniform float _RefLight;
		uniform float _MirrorSmoothPower;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			SurfaceOutputStandard s4 = (SurfaceOutputStandard ) 0;
			float2 uv_AlbedoMap = i.uv_texcoord * _AlbedoMap_ST.xy + _AlbedoMap_ST.zw;
			s4.Albedo = ( tex2D( _AlbedoMap, uv_AlbedoMap ) * _BaseColor ).rgb;
			float3 ase_worldNormal = i.worldNormal;
			s4.Normal = ase_worldNormal;
			s4.Emission = float3( 0,0,0 );
			float2 uv_PBRMaskMap = i.uv_texcoord * _PBRMaskMap_ST.xy + _PBRMaskMap_ST.zw;
			float4 tex2DNode13 = tex2D( _PBRMaskMap, uv_PBRMaskMap );
			s4.Metallic = ( _Metallic * tex2DNode13.b );
			float temp_output_8_0 = ( _Smoothness * tex2DNode13.r );
			s4.Smoothness = temp_output_8_0;
			s4.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi4 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g4 = UnityGlossyEnvironmentSetup( s4.Smoothness, data.worldViewDir, s4.Normal, float3(0,0,0));
			gi4 = UnityGlobalIllumination( data, s4.Occlusion, s4.Normal, g4 );
			#endif

			float3 surfResult4 = LightingStandard ( s4, viewDir, gi4 ).rgb;
			surfResult4 += s4.Emission;

			#ifdef UNITY_PASS_FORWARDADD//4
			surfResult4 -= s4.Emission;
			#endif//4
			float4 color6 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float3 clampResult38 = clamp( surfResult4 , float3( 0,0,0 ) , color6.rgb );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 unityObjectToClipPos15 = UnityObjectToClipPos( ase_vertex3Pos );
			float4 computeScreenPos16 = ComputeScreenPos( unityObjectToClipPos15 );
			float4 tex2DNode20 = tex2D( _Ref, (( computeScreenPos16 / (computeScreenPos16).w )).xy );
			float4 temp_cast_3 = (_RefMini).xxxx;
			float4 color23 = IsGammaSpace() ? float4(1.2,1.2,1.2,1) : float4(1.493478,1.493478,1.493478,1);
			float3 desaturateInitialColor41 = (float4( 0,0,0,0 ) + (tex2DNode20 - temp_cast_3) * (color23 - float4( 0,0,0,0 )) / (float4( 1,1,1,0 ) - temp_cast_3)).rgb;
			float desaturateDot41 = dot( desaturateInitialColor41, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar41 = lerp( desaturateInitialColor41, desaturateDot41.xxx, 1.0 );
			float lerpResult51 = lerp( 1.0 , temp_output_8_0 , _MirrorSmoothPower);
			float3 clampResult47 = clamp( ( desaturateVar41 * _RefLight * lerpResult51 ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float4 lerpResult40 = lerp( float4( clampResult38 , 0.0 ) , tex2DNode20 , float4( clampResult47 , 0.0 ));
			c.rgb = lerpResult40.rgb;
			c.a = 1;
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
		CGPROGRAM
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows nometa 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
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
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
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
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
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
Version=16400
37;55;1671;937;159.1376;-325.42;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;52;-1014.246,793.6635;Float;False;1310.843;433.6547;Fl-UV-Cal;6;16;14;15;19;18;17;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-929.7134,894.8528;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.UnityObjToClipPosHlpNode;15;-741.2139,894.4527;Float;False;1;0;FLOAT3;0,0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComputeScreenPosHlpNode;16;-549.6142,892.9529;Float;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;17;-336.0535,1005.478;Float;True;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;18;-54.33249,893.1231;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-129.3579,165.829;Float;False;Property;_Smoothness;Smoothness;1;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-451.9728,221.3426;Float;True;Property;_PBRMaskMap;PBRMaskMap;4;0;Create;True;0;0;False;0;None;b9f9a17ea2863c24b9bb6e6d8617bc07;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;19;98.88292,947.9839;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;53;328.3848,787.3752;Float;False;1640.318;732.6959;Ref-Power [https://www.element3ds.com/forum.php?mod=forumdisplay&fid=104];13;47;48;40;50;51;54;41;46;21;42;23;20;39;https://www.element3ds.com/forum.php?mod=forumdisplay&fid=104;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1;-165.2301,-210.4575;Float;True;Property;_AlbedoMap;AlbedoMap;0;0;Create;True;0;0;False;0;None;50e6c23e576d3a84c8fdbc0e4a4f6c31;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-216.7202,448.0965;Float;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;233.3175,163.719;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-65.2927,-13.14546;Float;False;Property;_BaseColor;BaseColor;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;39;387.7334,1174.239;Float;False;Property;_RefMini;RefMini;6;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;58;831.3873,650.0363;Float;False;179.9999;134;FinalSmooth;1;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;23;415.7225,1312.791;Float;False;Constant;_Color0;Color 0;7;1;[HDR];Create;True;0;0;False;0;1.2,1.2,1.2,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;435.905,914.2588;Float;True;Property;_Ref;_Ref;5;0;Create;True;0;0;False;0;None;;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;42;862.9156,1074.198;Float;False;Constant;_Sat1;Sat1;10;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;861.0894,868.7846;Float;False;Constant;_F1;F1;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;859.7842,981.6051;Float;False;Property;_MirrorSmoothPower;Mirror-Smooth-Power;8;0;Create;True;0;0;False;0;0;0.901;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;56;868.258,700.09;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;246.7071,-114.1455;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;231.0196,452.8959;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;21;823.0173,1159.462;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DesaturateOpNode;41;1206.246,1058.353;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomStandardSurface;4;641.9142,7.474583;Float;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;51;1249.94,865.394;Float;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;623.1898,265.272;Float;False;Constant;_HDRMax;HDRMax;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;1135.1,1170.057;Float;False;Property;_RefLight;RefLight;7;0;Create;True;0;0;False;0;-0.1529412;0.336;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;38;1204.448,157.0308;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;59;1391.779,635.372;Float;False;179.9999;134;FinalImage;1;57;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;1451.012,1030.983;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RelayNode;57;1423.522,687.3878;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;47;1591.769,1008.837;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;40;1775.907,864.2409;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;43;2088.676,802.6485;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2417.769,583.8801;Float;False;True;0;Float;ASEMaterialInspector;0;0;CustomLighting;HIE/PBR/HardSurface-2T-MGround;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;14;0
WireConnection;16;0;15;0
WireConnection;17;0;16;0
WireConnection;18;0;16;0
WireConnection;18;1;17;0
WireConnection;19;0;18;0
WireConnection;8;0;7;0
WireConnection;8;1;13;1
WireConnection;20;1;19;0
WireConnection;56;0;8;0
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;11;0;10;0
WireConnection;11;1;13;3
WireConnection;21;0;20;0
WireConnection;21;1;39;0
WireConnection;21;4;23;0
WireConnection;41;0;21;0
WireConnection;41;1;42;0
WireConnection;4;0;3;0
WireConnection;4;3;11;0
WireConnection;4;4;8;0
WireConnection;51;0;54;0
WireConnection;51;1;56;0
WireConnection;51;2;50;0
WireConnection;38;0;4;0
WireConnection;38;2;6;0
WireConnection;48;0;41;0
WireConnection;48;1;46;0
WireConnection;48;2;51;0
WireConnection;57;0;38;0
WireConnection;47;0;48;0
WireConnection;40;0;57;0
WireConnection;40;1;20;0
WireConnection;40;2;47;0
WireConnection;43;0;40;0
WireConnection;0;13;43;0
ASEEND*/
//CHKSM=1AA7C9A90A1DBD81B555C9C0D641EFFE6640F2CB