// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3D/Actor/E3D-ActorPBR-Rs-Face"
{
	Properties
	{
		_AlbedoMap("AlbedoMap", 2D) = "white" {}
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		_NormalMap("NormalMap", 2D) = "bump" {}
		_SmoothnessMap("SmoothnessMap", 2D) = "white" {}
		_SmoothLeap("SmoothLeap", Range( 0 , 1)) = 0.7040191
		_SmoothFace("SmoothFace", Range( 0 , 1)) = 1
		_SmoothRemap("SmoothRemap", Range( 0 , 0.5)) = 0.12
		_MinCP("MinCP", Range( 0 , 0.2)) = 0.043128
		_MaxCP("MaxCP", Range( 0 , 0.2)) = 0.12
		_AOColor("AOColor", Color) = (1,0,0,1)
		_AO("AO", Range( 0 , 1)) = 0
		_NScaleVP("N-ScaleVP", Range( 0 , 1)) = 0
		_NScale2("N-Scale2", Range( 0 , 1)) = 1
		_Maskmap("Maskmap", 2D) = "white" {}
		_3S("3S", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
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

		uniform float _NScaleVP;
		uniform sampler2D _Maskmap;
		uniform float4 _Maskmap_ST;
		uniform float _NScale2;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _AlbedoMap;
		uniform float4 _AlbedoMap_ST;
		uniform float4 _AOColor;
		uniform float _AO;
		uniform float _MinCP;
		uniform sampler2D _SmoothnessMap;
		uniform float4 _SmoothnessMap_ST;
		uniform float _MaxCP;
		uniform float _SmoothLeap;
		uniform float _SmoothFace;
		uniform float _SmoothRemap;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform float _3S;

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
			float2 uv_Maskmap = i.uv_texcoord * _Maskmap_ST.xy + _Maskmap_ST.zw;
			float4 tex2DNode43 = tex2D( _Maskmap, uv_Maskmap );
			float lerpResult60 = lerp( ( _NScaleVP * tex2DNode43.r ) , 1.0 , _NScale2);
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), lerpResult60 );
			float2 uv_AlbedoMap = i.uv_texcoord * _AlbedoMap_ST.xy + _AlbedoMap_ST.zw;
			float4 temp_cast_0 = (1.0).xxxx;
			float4 temp_cast_1 = (1.0).xxxx;
			float4 lerpResult67 = lerp( _AOColor , temp_cast_1 , ( tex2DNode43.b + 0.0 ));
			float4 lerpResult49 = lerp( temp_cast_0 , lerpResult67 , _AO);
			o.Albedo = ( tex2D( _AlbedoMap, uv_AlbedoMap ) * lerpResult49 ).rgb;
			float2 uv_SmoothnessMap = i.uv_texcoord * _SmoothnessMap_ST.xy + _SmoothnessMap_ST.zw;
			float4 tex2DNode44 = tex2D( _SmoothnessMap, uv_SmoothnessMap );
			float clampResult83 = clamp( (0.0 + (( ( tex2DNode43.g + _MinCP ) * tex2DNode44.g ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0)) , 0.015 , _MaxCP );
			float3 temp_cast_3 = (clampResult83).xxx;
			o.Specular = temp_cast_3;
			o.Smoothness = (0.0 + (( ( tex2DNode43.g * _SmoothLeap ) + ( tex2DNode44.r * _SmoothFace ) ) - _SmoothRemap) * (2.0 - 0.0) / (1.0 - _SmoothRemap));
			o.Occlusion = lerpResult49.r;
			float3 temp_cast_5 = (( tex2DNode44.b * _3S )).xxx;
			o.Translucency = temp_cast_5;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
15;1013;1843;1044;3122.395;142.6225;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;91;-2035.532,423.9861;Float;False;Property;_MinCP;MinCP;13;0;Create;True;0;0;False;0;0.043128;0.077;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;43;-2335.58,-399.0611;Float;True;Property;_Maskmap;Maskmap;19;0;Create;True;0;0;False;0;None;06e7e169a2c41b24c9a3b01984601c5d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;95;-2338.757,-72.40211;Float;False;Property;_SmoothLeap;SmoothLeap;10;0;Create;True;0;0;False;0;0.7040191;0.205;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;44;-2492.891,128.4294;Float;True;Property;_SmoothnessMap;SmoothnessMap;9;0;Create;True;0;0;False;0;None;05a0222a11f71934dbe602321d8d27d2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;90;-1700.789,396.7209;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-2402.23,359.0819;Float;False;Property;_SmoothFace;SmoothFace;11;0;Create;True;0;0;False;0;1;0.275;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;66;-1123.581,-327.2862;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-1351.15,391.2885;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;50;-464.3336,365.9734;Float;False;Property;_AOColor;AOColor;15;0;Create;True;0;0;False;0;1,0,0,1;0.8161765,0.06390323,0.04801007,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;68;-249.273,526.6811;Float;False;Constant;_Float4;Float 4;20;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-1906.494,200.0553;Float;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;-1897.757,-77.4021;Float;True;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-1590.724,-812.5143;Float;False;Property;_NScaleVP;N-ScaleVP;17;0;Create;True;0;0;False;0;0;0.788;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-1212.582,153.5233;Float;False;Property;_SmoothRemap;SmoothRemap;12;0;Create;True;0;0;False;0;0.12;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-30.18735,617.8516;Float;False;Property;_AO;AO;16;0;Create;True;0;0;False;0;0;0.713;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;104.6383,268.483;Float;False;Constant;_F3;F3;20;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;79;-1055.145,392.6853;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1276.304,-620.14;Float;False;Property;_NScale2;N-Scale2;18;0;Create;True;0;0;False;0;1;0.065;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;67;-13.53869,356.9155;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1053.52,621.1893;Float;False;Property;_MaxCP;MaxCP;14;0;Create;True;0;0;False;0;0.12;0.097;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1183.993,-704.3934;Float;False;Constant;_F1;F1;19;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-1188.338,-808.6718;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;94;-1558.141,35.15736;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;60;-912.5892,-731.8249;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;83;-682.5095,337.8593;Float;False;3;0;FLOAT;0;False;1;FLOAT;0.015;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;49;424.3469,270.8842;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-301.6117,1198.249;Float;False;Property;_3S;3S;20;0;Create;True;0;0;False;0;1;0.85;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;92;-772.9958,-128.2849;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;97;-1898.392,1029.112;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;212.1778,-318.7017;Float;True;Property;_AlbedoMap;AlbedoMap;0;0;Create;True;0;0;False;0;None;356d2bce19d4107458955e77baa8448c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-616.705,-778.5974;Float;True;Property;_NormalMap;NormalMap;8;0;Create;True;0;0;False;0;None;6c85229cb3645ce40864d188684c4a28;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RelayNode;86;-381.2404,-124.6161;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;594.7025,-174.5963;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;189.5384,1099.18;Float;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;85;-435.8057,215.2119;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1158.099,-235.8159;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;E3D/Actor/E3D-ActorPBR-Rs-Face;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;90;0;43;2
WireConnection;90;1;91;0
WireConnection;66;0;43;3
WireConnection;81;0;90;0
WireConnection;81;1;44;2
WireConnection;2;0;44;1
WireConnection;2;1;3;0
WireConnection;96;0;43;2
WireConnection;96;1;95;0
WireConnection;79;0;81;0
WireConnection;67;0;50;0
WireConnection;67;1;68;0
WireConnection;67;2;66;0
WireConnection;59;0;54;0
WireConnection;59;1;43;1
WireConnection;94;0;96;0
WireConnection;94;1;2;0
WireConnection;60;0;59;0
WireConnection;60;1;61;0
WireConnection;60;2;62;0
WireConnection;83;0;79;0
WireConnection;83;2;84;0
WireConnection;49;0;63;0
WireConnection;49;1;67;0
WireConnection;49;2;48;0
WireConnection;92;0;94;0
WireConnection;92;1;93;0
WireConnection;97;0;44;3
WireConnection;8;5;60;0
WireConnection;86;0;92;0
WireConnection;76;0;7;0
WireConnection;76;1;49;0
WireConnection;55;0;97;0
WireConnection;55;1;56;0
WireConnection;85;0;83;0
WireConnection;0;0;76;0
WireConnection;0;1;8;0
WireConnection;0;3;85;0
WireConnection;0;4;86;0
WireConnection;0;5;49;0
WireConnection;0;7;55;0
ASEEND*/
//CHKSM=6FE09EDD229539BCA00D5253872C436E260A2A45