// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3D/Actor/ActorPBR-HairTest"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.2
		_AlbedoMap("AlbedoMap", 2D) = "white" {}
		_OpacityMap("OpacityMap", 2D) = "white" {}
		_Alpha("Alpha", Range( 0 , 2)) = 2
		_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Smooth("Smooth", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" }
		Cull Off
		ZWrite On
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
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

		uniform sampler2D _OpacityMap;
		uniform float4 _OpacityMap_ST;
		uniform float _Alpha;
		uniform float4 _BaseColor;
		uniform sampler2D _AlbedoMap;
		uniform float4 _AlbedoMap_ST;
		uniform float _Smooth;
		uniform float _Cutoff = 0.2;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_OpacityMap = i.uv_texcoord * _OpacityMap_ST.xy + _OpacityMap_ST.zw;
			float4 tex2DNode7 = tex2D( _OpacityMap, uv_OpacityMap );
			SurfaceOutputStandard s52 = (SurfaceOutputStandard ) 0;
			float2 uv_AlbedoMap = i.uv_texcoord * _AlbedoMap_ST.xy + _AlbedoMap_ST.zw;
			float4 tex2DNode51 = tex2D( _AlbedoMap, uv_AlbedoMap );
			s52.Albedo = ( _BaseColor * tex2DNode51 ).rgb;
			float3 ase_worldNormal = i.worldNormal;
			s52.Normal = ase_worldNormal;
			s52.Emission = float3( 0,0,0 );
			s52.Metallic = 0.0;
			s52.Smoothness = ( tex2DNode51.r * _Smooth * tex2DNode7 ).r;
			s52.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi52 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g52 = UnityGlossyEnvironmentSetup( s52.Smoothness, data.worldViewDir, s52.Normal, float3(0,0,0));
			gi52 = UnityGlobalIllumination( data, s52.Occlusion, s52.Normal, g52 );
			#endif

			float3 surfResult52 = LightingStandard ( s52, viewDir, gi52 ).rgb;
			surfResult52 += s52.Emission;

			#ifdef UNITY_PASS_FORWARDADD//52
			surfResult52 -= s52.Emission;
			#endif//52
			float3 clampResult56 = clamp( surfResult52 , float3( 0,0,0 ) , float3( 1,1,0 ) );
			c.rgb = clampResult56;
			c.a = 1;
			clip( saturate( ( tex2DNode7 * tex2DNode7.a * _Alpha ) ).r - _Cutoff );
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
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

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
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
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
215;771;1285;572;-1303.6;714.6411;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;53;1868.208,-467.3311;Float;False;Property;_Smooth;Smooth;5;0;Create;True;0;0;False;0;1;0.369323;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;1751.086,-187.9424;Float;True;Property;_OpacityMap;OpacityMap;2;0;Create;True;0;0;False;0;None;ac16464301d603d44bc87875f2297967;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;45;1815.012,-868.7491;Float;False;Property;_BaseColor;BaseColor;4;0;Create;True;0;0;False;0;1,1,1,1;0.6838235,0.5357542,0.3771084,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;51;1742.566,-695.4174;Float;True;Property;_AlbedoMap;AlbedoMap;1;0;Create;True;0;0;False;0;None;b343607d79a666042a9f7e5ebbc632cf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;48;1774.125,-317.9811;Float;False;Property;_Alpha;Alpha;3;0;Create;True;0;0;False;0;2;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;2596.081,-619.4598;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;2105.737,-762.8594;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;2280.341,-562.9424;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomStandardSurface;52;2759.559,-690.9484;Float;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;2335.417,-321.9943;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;56;3177.303,-647.6788;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;47;2793.358,-340.4282;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3517.89,-705.1707;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;E3D/Actor/ActorPBR-HairTest;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.2;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;50;0;45;0
WireConnection;50;1;51;0
WireConnection;57;0;51;1
WireConnection;57;1;53;0
WireConnection;57;2;7;0
WireConnection;52;0;50;0
WireConnection;52;3;54;0
WireConnection;52;4;57;0
WireConnection;46;0;7;0
WireConnection;46;1;7;4
WireConnection;46;2;48;0
WireConnection;56;0;52;0
WireConnection;47;0;46;0
WireConnection;0;10;47;0
WireConnection;0;13;56;0
ASEEND*/
//CHKSM=EED83705B4C48FC6E55234AFCBE07676C6E9DCD8