// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3D/Actor/TSHair/2U-AlphaBlender"
{
	Properties
	{
		[HDR]_AlbedoColor("AlbedoColor", Color) = (0.9779412,0.7868161,0.6831207,0.997)
		_R1SpecalurColor("R1-SpecalurColor", Color) = (0.9632353,0.9038391,0.8499135,0)
		[HDR]_R2SpecalurColor("R2-SpecalurColor", Color) = (0.9632353,0.9038391,0.8499135,0)
		_AnisotropyRang1("Anisotropy-Rang1", Range( 1 , 40)) = 391.6256
		_AnisotropyRang2("Anisotropy-Rang2", Range( 1 , 1000)) = 391.6256
		_MaskMap2U("MaskMap2U", 2D) = "white" {}
		_MaskMap("MaskMap", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_AniBias("Ani-Bias", Range( -1 , 1)) = -1
		_HLFrePower("HL-Fre-Power", Range( 0 , 5)) = 0
		_Alphainstensity("Alpha-instensity", Range( 0.5 , 3)) = 1
		[Toggle]_MaskBBreakAO("MaskB-Break-AO", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			half2 uv2_texcoord2;
			float3 worldNormal;
			INTERNAL_DATA
			half2 uv_texcoord;
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

		uniform sampler2D _MaskMap2U;
		uniform float4 _MaskMap2U_ST;
		uniform half _Alphainstensity;
		uniform half4 _AlbedoColor;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _MaskMap;
		uniform float4 _MaskMap_ST;
		uniform half _AniBias;
		uniform half _AnisotropyRang1;
		uniform half4 _R1SpecalurColor;
		uniform half _AnisotropyRang2;
		uniform half4 _R2SpecalurColor;
		uniform half _HLFrePower;
		uniform half _MaskBBreakAO;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv2_MaskMap2U = i.uv2_texcoord2 * _MaskMap2U_ST.xy + _MaskMap2U_ST.zw;
			half4 tex2DNode244 = tex2D( _MaskMap2U, uv2_MaskMap2U );
			float4 temp_output_231_0 = ( tex2DNode244.g * _AlbedoColor * tex2DNode244.a );
			half3 ase_worldBitangent = WorldNormalVector( i, half3( 0, 1, 0 ) );
			float2 uv2_Normal = i.uv2_texcoord2 * _Normal_ST.xy + _Normal_ST.zw;
			float2 uv_MaskMap = i.uv_texcoord * _MaskMap_ST.xy + _MaskMap_ST.zw;
			half4 tex2DNode65 = tex2D( _MaskMap, uv_MaskMap );
			float clampResult184 = clamp( ( tex2DNode65.r + ( ( tex2DNode65.g * _AniBias ) + -0.2 ) ) , -1.0 , 1.33 );
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult156 = dot( ( ase_worldBitangent + ( normalize( (WorldNormalVector( i , UnpackNormal( tex2D( _Normal, uv2_Normal ) ) )) ) * clampResult184 ) ) , ase_worldViewDir );
			float temp_output_186_0 = sqrt( sqrt( ( 1.0 - ( dotResult156 * dotResult156 ) ) ) );
			half4 tex2DNode176 = tex2D( _MaskMap, uv_MaskMap );
			half3 ase_worldNormal = WorldNormalVector( i, half3( 0, 0, 1 ) );
			float dotResult117 = dot( ase_worldViewDir , ase_worldNormal );
			float4 color241 = IsGammaSpace() ? half4(1.51,1.51,1.51,0) : half4(2.475992,2.475992,2.475992,0);
			float4 clampResult240 = clamp( ( ( ( pow( temp_output_186_0 , _AnisotropyRang1 ) * _R1SpecalurColor ) + ( pow( temp_output_186_0 , _AnisotropyRang2 ) * _R2SpecalurColor * tex2DNode176.r * tex2DNode244.r ) ) * float4( 1,1,1,0 ) * pow( dotResult117 , _HLFrePower ) * lerp(tex2DNode176.b,1.0,_MaskBBreakAO) * tex2DNode244.a ) , float4( 0,0,0,0 ) , color241 );
			c.rgb = ( temp_output_231_0 + clampResult240 ).rgb;
			c.a = saturate( ( tex2DNode244.a * _Alphainstensity ) );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
		}

		ENDCG
		CGPROGRAM
		#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal 
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred novertexlights nolightmap  nodynlightmap nodirlightmap  11

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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv2_texcoord2;
				o.customPack1.xy = v.texcoord1;
				o.customPack1.zw = customInputData.uv_texcoord;
				o.customPack1.zw = v.texcoord;
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
				surfIN.uv2_texcoord2 = IN.customPack1.xy;
				surfIN.uv_texcoord = IN.customPack1.zw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
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
984;99;622;690;-1766.151;523.9854;1;False;False
Node;AmplifyShaderEditor.CommentaryNode;142;-1889.079,-701.092;Float;False;1971.617;684.3436;E3D-Anisotropy;13;137;139;140;138;159;148;156;184;65;77;234;235;79;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;65;-2085.13,-459.0461;Float;True;Property;_MaskMap;MaskMap;6;0;Create;True;0;0;False;0;9622a43db7f9c504593742af0fc72d26;9622a43db7f9c504593742af0fc72d26;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;77;-2061.894,-241.1046;Float;False;Property;_AniBias;Ani-Bias;8;0;Create;True;0;0;False;0;-1;-0.07;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;235;-1758.662,-304.3558;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;234;-1594.845,-331.4373;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;248;-1537.456,-945.8666;Float;True;Property;_TextureSample3;Texture Sample 3;7;0;Create;True;0;0;False;0;None;ec8978c292b3a9141a4427a2a4a756b8;True;1;True;bump;Auto;True;Instance;136;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;79;-1463.481,-409.137;Float;True;2;2;0;FLOAT;0.8;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;184;-1214.307,-381.269;Float;True;3;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1.33;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;137;-1205.017,-522.2913;Float;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexBinormalNode;139;-982.3094,-638.5959;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;138;-983.2275,-434.4931;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;155;-1434.921,14.69958;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-715.5818,-517.1896;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;156;-601.1657,-306.182;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-364.5244,-304.5548;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;144;227.7748,-411.8547;Float;False;2409.551;950.5925;Anisotropy-HighLight-Cal;15;75;76;161;164;158;186;189;190;191;176;236;238;239;241;232;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;159;-130.8116,-305.4433;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SqrtOpNode;158;267.9865,-307.6455;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;699.8677,17.51024;Float;False;Property;_AnisotropyRang2;Anisotropy-Rang2;4;0;Create;True;0;0;False;0;391.6256;273;1;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;166;236.4074,579.2501;Float;False;862.25;402.7751;Fre-Highlighing;5;118;116;115;117;119;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;161;719.6005,-222.7276;Float;False;Property;_AnisotropyRang1;Anisotropy-Rang1;3;0;Create;True;0;0;False;0;391.6256;35.4;1;40;0;1;FLOAT;0
Node;AmplifyShaderEditor.SqrtOpNode;186;524.7532,-306.1878;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;190;1060.293,-103.8065;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;75;1353.28,-252.5769;Float;False;Property;_R1SpecalurColor;R1-SpecalurColor;1;0;Create;True;0;0;False;0;0.9632353,0.9038391,0.8499135,0;0.4044115,0.2782891,0.1813903,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;115;340.1286,639.7333;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;239;1080.866,320.9928;Float;False;Property;_R2SpecalurColor;R2-SpecalurColor;2;1;[HDR];Create;True;0;0;False;0;0.9632353,0.9038391,0.8499135,0;0.5808823,0.5025277,0.4313903,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;176;1021.64,127.3522;Float;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;False;0;None;113c1330a048d014fbffd1b74f2f595c;True;0;False;white;Auto;False;Instance;65;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;244;1330.366,-1538.139;Float;True;Property;_MaskMap2U;MaskMap2U;5;0;Create;True;0;0;False;0;None;d41e18bd3f347d045a04de04e4762754;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;116;320.1223,785.9283;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;164;1054.261,-321.0357;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;119;490.0538,898.2059;Float;False;Property;_HLFrePower;HL-Fre-Power;10;0;Create;True;0;0;False;0;0;1.39;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;238;1605.972,-240.5494;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;117;557.7106,671.5991;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;236;1603.707,-28.67909;Float;True;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;118;786.8584,663.8812;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;191;1953.631,-239.3501;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;133;913.2898,-1344.195;Float;False;2245.839;814.85;E3D-BasePBR-Cal;13;105;221;136;121;135;120;125;167;226;227;126;229;231;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ToggleSwitchNode;232;1374.03,-374.5755;Float;False;Property;_MaskBBreakAO;MaskB-Break-AO;15;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;2146.937,-222.6724;Float;True;5;5;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;241;2406.927,35.52417;Float;False;Constant;_MaxHDRColor;MaxHDRColor;15;1;[HDR];Create;True;0;0;False;0;1.51,1.51,1.51,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;221;1345.899,-1299.747;Float;False;Property;_AlbedoColor;AlbedoColor;0;1;[HDR];Create;True;0;0;False;0;0.9779412,0.7868161,0.6831207,0.997;0.2720585,0.198139,0.1580338,0.997;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;229;2865.724,-815.2699;Float;False;Property;_Alphainstensity;Alpha-instensity;14;0;Create;True;0;0;False;0;1;1.52;0.5;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;228;3246.648,-930.3792;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;224;-1439.255,166.5606;Float;False;1421.379;533.8529;E3D-LightCal;7;157;150;154;149;73;151;152;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;240;2738.706,-133.5197;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;231;1827.575,-1468.934;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;73;-1354.463,522.0854;Float;False;Property;_AniDir;Ani-Dir;9;0;Create;True;0;0;False;0;0,99,-8;-46.5,15.9,-61.1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;227;2130.008,-918.9792;Float;False;Constant;_Color0;Color 0;13;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;150;-1169.766,380.4034;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;167;1333.199,-839.7748;Float;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Instance;65;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;126;2198.844,-648.5256;Float;False;Property;_PBRInstensity;PBR-Instensity;11;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomStandardSurface;105;2215.75,-1326.035;Float;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;114;3131.914,-394.2193;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;226;2525.876,-1050.399;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;154;-352.9639,277.3739;Float;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;151;-1109.404,526.062;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;120;1415.269,-967.583;Float;False;Property;_Smoothness;Smoothness;12;0;Create;True;0;0;False;0;0.2;0.37;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;136;1151.498,-1062.606;Float;True;Property;_Normal;Normal;7;0;Create;True;0;0;False;0;None;ec8978c292b3a9141a4427a2a4a756b8;True;1;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;135;1344.665,-1108.808;Float;False;Constant;_Metallic;Metallic;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;1849.015,-1011.992;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;230;3468.403,-850.2515;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;125;2707.451,-751.6703;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;157;-601.7092,276.4364;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;152;-820.7051,338.8966;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;149;-798.0248,437.4952;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4196.495,-898.2123;Half;False;True;2;Half;ASEMaterialInspector;0;0;CustomLighting;E3D/Actor/TSHair/2U-AlphaBlender;False;False;False;False;False;True;True;True;True;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;1.5;True;True;0;True;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;False;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;13;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;1;11;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;235;0;65;2
WireConnection;235;1;77;0
WireConnection;234;0;235;0
WireConnection;79;0;65;1
WireConnection;79;1;234;0
WireConnection;184;0;79;0
WireConnection;137;0;248;0
WireConnection;138;0;137;0
WireConnection;138;1;184;0
WireConnection;140;0;139;0
WireConnection;140;1;138;0
WireConnection;156;0;140;0
WireConnection;156;1;155;0
WireConnection;148;0;156;0
WireConnection;148;1;156;0
WireConnection;159;0;148;0
WireConnection;158;0;159;0
WireConnection;186;0;158;0
WireConnection;190;0;186;0
WireConnection;190;1;189;0
WireConnection;164;0;186;0
WireConnection;164;1;161;0
WireConnection;238;0;164;0
WireConnection;238;1;75;0
WireConnection;117;0;115;0
WireConnection;117;1;116;0
WireConnection;236;0;190;0
WireConnection;236;1;239;0
WireConnection;236;2;176;1
WireConnection;236;3;244;1
WireConnection;118;0;117;0
WireConnection;118;1;119;0
WireConnection;191;0;238;0
WireConnection;191;1;236;0
WireConnection;232;0;176;3
WireConnection;76;0;191;0
WireConnection;76;2;118;0
WireConnection;76;3;232;0
WireConnection;76;4;244;4
WireConnection;228;0;244;4
WireConnection;228;1;229;0
WireConnection;240;0;76;0
WireConnection;240;2;241;0
WireConnection;231;0;244;2
WireConnection;231;1;221;0
WireConnection;231;2;244;4
WireConnection;105;0;231;0
WireConnection;105;1;136;0
WireConnection;105;3;135;0
WireConnection;105;4;121;0
WireConnection;105;5;244;3
WireConnection;114;0;231;0
WireConnection;114;1;240;0
WireConnection;226;2;227;0
WireConnection;154;0;157;0
WireConnection;151;0;73;0
WireConnection;121;0;244;1
WireConnection;121;1;120;0
WireConnection;230;0;228;0
WireConnection;125;2;126;0
WireConnection;157;0;155;0
WireConnection;157;1;152;0
WireConnection;152;0;150;0
WireConnection;149;0;150;0
WireConnection;149;1;151;0
WireConnection;0;9;230;0
WireConnection;0;13;114;0
ASEEND*/
//CHKSM=9170829A8557874113A80ACF3DE35EAF06D925F3