// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3D/Actor/E3D-ActorPBR-Rs-Hair"
{
	Properties
	{
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		_AlbedoMap("AlbedoMap", 2D) = "white" {}
		_NormalMap("NormalMap", 2D) = "bump" {}
		_Smooth("Smooth", Range( 0 , 3)) = 1
		_Specular("Specular", Range( 0 , 2)) = 1
		_AO("AO", Range( 0 , 1)) = 0
		_AOmap("AOmap", 2D) = "white" {}
		_SmoothnessMap("SmoothnessMap", 2D) = "white" {}
		_SpecularMap("SpecularMap", 2D) = "white" {}
		_3SMap("3SMap", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma surface surf StandardSpecularCustom keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		struct SurfaceOutputStandardSpecularCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half3 Specular;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Translucency;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _AlbedoMap;
		uniform float4 _AlbedoMap_ST;
		uniform sampler2D _SpecularMap;
		uniform float4 _SpecularMap_ST;
		uniform float _Specular;
		uniform sampler2D _SmoothnessMap;
		uniform float4 _SmoothnessMap_ST;
		uniform float _Smooth;
		uniform sampler2D _AOmap;
		uniform float4 _AOmap_ST;
		uniform float _AO;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform sampler2D _3SMap;
		uniform float4 _3SMap_ST;

		inline half4 LightingStandardSpecularCustom(SurfaceOutputStandardSpecularCustom s, half3 viewDir, UnityGI gi )
		{
			#if !DIRECTIONAL
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			SurfaceOutputStandardSpecular r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Specular = s.Specular;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandardSpecular (r, viewDir, gi) + c;
		}

		inline void LightingStandardSpecularCustom_GI(SurfaceOutputStandardSpecularCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardSpecularCustom o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float2 uv_AlbedoMap = i.uv_texcoord * _AlbedoMap_ST.xy + _AlbedoMap_ST.zw;
			o.Albedo = tex2D( _AlbedoMap, uv_AlbedoMap ).rgb;
			float2 uv_SpecularMap = i.uv_texcoord * _SpecularMap_ST.xy + _SpecularMap_ST.zw;
			o.Specular = ( tex2D( _SpecularMap, uv_SpecularMap ) * _Specular ).rgb;
			float2 uv_SmoothnessMap = i.uv_texcoord * _SmoothnessMap_ST.xy + _SmoothnessMap_ST.zw;
			float4 clampResult53 = clamp( ( tex2D( _SmoothnessMap, uv_SmoothnessMap ) * _Smooth ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			o.Smoothness = clampResult53.r;
			float4 color50 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 uv_AOmap = i.uv_texcoord * _AOmap_ST.xy + _AOmap_ST.zw;
			float4 lerpResult49 = lerp( color50 , tex2D( _AOmap, uv_AOmap ) , _AO);
			o.Occlusion = lerpResult49.r;
			float2 uv_3SMap = i.uv_texcoord * _3SMap_ST.xy + _3SMap_ST.zw;
			o.Translucency = tex2D( _3SMap, uv_3SMap ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
774;1023;1552;926;892.7975;235.0382;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;3;-661.777,280.2581;Float;False;Property;_Smooth;Smooth;11;0;Create;True;0;0;False;0;1;2.09;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;44;-667.2518,95.9902;Float;True;Property;_SmoothnessMap;SmoothnessMap;19;0;Create;True;0;0;False;0;None;05a0222a11f71934dbe602321d8d27d2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;48;-244.54,461.0276;Float;False;Property;_AO;AO;15;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;43;-135.957,108.2289;Float;True;Property;_AOmap;AOmap;18;0;Create;True;0;0;False;0;None;06e7e169a2c41b24c9a3b01984601c5d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;50;-199.54,278.0276;Float;False;Constant;_Color0;Color 0;14;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;45;-695.2692,-335.9889;Float;True;Property;_SpecularMap;SpecularMap;20;0;Create;True;0;0;False;0;None;633928b9dd7de9b4ea44756fd47ecede;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-268.9632,-3.60638;Float;False;2;2;0;COLOR;1,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-666.615,-92.87341;Float;False;Property;_Specular;Specular;12;0;Create;True;0;0;False;0;1;0.28;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;46;166.9905,405.4573;Float;True;Property;_3SMap;3SMap;21;0;Create;True;0;0;False;0;None;673a7ebbafc0ef94c9a61cd2370bb955;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;34;1246.007,-857.1836;Float;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;731.9868,-63.64409;Float;False;Property;_MaxColor;MaxColor;9;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;9;886.2413,-227.0094;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;39;1682.276,-626.1047;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;1482.531,-710.7136;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;11;751.5134,-644.8432;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;42;883.1348,182.0751;Float;False;Property;_GlowColor;GlowColor;10;1;[HDR];Create;True;0;0;False;0;2.713,0.7297035,0,1;2.713,0.7297035,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;40;1079.027,-505.5921;Float;False;Property;_SideLightColor;SideLightColor;13;0;Create;True;0;0;False;0;0.8439122,0.9225554,0.9485294,1;0.8439122,0.9225554,0.9485294,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;543.6038,-753.1249;Float;False;Constant;_Fre;Fre;7;0;Create;True;0;0;False;0;1.3;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;349.6407,-570.4535;Float;False;Property;_SideLightScale;SideLightScale;17;0;Create;True;0;0;False;0;0.6;0.079;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-309.441,-218.0393;Float;False;2;2;0;COLOR;1,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;49;227.46,101.0276;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;35;853.1445,-928.1962;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;0.4;0.4;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;2103.583,-413.2621;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;7;-140.9125,-671.489;Float;True;Property;_AlbedoMap;AlbedoMap;7;0;Create;True;0;0;False;0;None;356d2bce19d4107458955e77baa8448c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;51;559.1895,-86.01423;Float;False;Property;_Float0;Float 0;14;0;Create;True;0;0;False;0;0;0.15;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;971.5421,-792.033;Float;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;337.9521,-340.9387;Float;False;Property;_Color1;Color 1;16;0;Create;True;0;0;False;0;1,0.9396552,0.875,0;0.4926471,0.3803525,0.3803525,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-135.2614,-445.4454;Float;True;Property;_NormalMap;NormalMap;8;0;Create;True;0;0;False;0;None;994e75f0a5bc0bc42b71e2c3d12dbb5f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;53;-13.79749,293.9618;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;1287.306,91.72905;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;507.7335,-126.2869;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;E3D/Actor/E3D-ActorPBR-Rs-Hair;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;0;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;44;0
WireConnection;2;1;3;0
WireConnection;34;0;32;0
WireConnection;34;1;35;0
WireConnection;9;2;10;0
WireConnection;39;0;36;0
WireConnection;36;0;34;0
WireConnection;36;1;11;0
WireConnection;36;2;40;0
WireConnection;11;2;37;0
WireConnection;4;0;45;0
WireConnection;4;1;5;0
WireConnection;49;0;50;0
WireConnection;49;1;43;0
WireConnection;49;2;48;0
WireConnection;12;0;39;0
WireConnection;12;1;41;0
WireConnection;12;2;9;0
WireConnection;32;1;33;0
WireConnection;53;0;2;0
WireConnection;41;1;42;0
WireConnection;0;0;7;0
WireConnection;0;1;8;0
WireConnection;0;3;4;0
WireConnection;0;4;53;0
WireConnection;0;5;49;0
WireConnection;0;7;46;0
ASEEND*/
//CHKSM=9B4A696DE174A9B56AC2046B270B669168B8858B