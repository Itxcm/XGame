// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OM-Dev/Effect/UV-Rotate-Slash"
{
	Properties
	{
		[HDR]_ColorA("Color A", Color) = (1.085735,1.355647,1.38,0)
		_ColorB("Color B", Color) = (0.1783088,0.381212,0.7132353,0)
		_BaseMap("BaseMap", 2D) = "white" {}
		_UOffset("U-Offset", Range( -2 , 2)) = 0
		_UTiling("U-Tiling", Range( 0 , 3)) = 1.752941
		_VOffset("V-Offset", Range( -2 , 2)) = 0
		_VTiling("V-Tiling", Range( 0 , 3)) = 0.6482049
		_FllowDelay("FllowDelay", Range( -1 , 1)) = 0
		_AlphaProgress("AlphaProgress", Range( 0 , 1)) = 0.07058825
		[Toggle]_FadeIn("FadeIn", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
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

		uniform sampler2D _BaseMap;
		uniform float _VTiling;
		uniform float _UTiling;
		uniform float _UOffset;
		uniform float _VOffset;
		uniform float _FadeIn;
		uniform float _FllowDelay;
		uniform float _AlphaProgress;
		uniform float4 _ColorB;
		uniform float4 _ColorA;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 temp_output_77_0 = ( float2( 1,1 ) * _VTiling );
			float2 temp_output_3_0 = (( temp_output_77_0 * -1.0 ) + (i.uv_texcoord - float2( 0,0 )) * (temp_output_77_0 - ( temp_output_77_0 * -1.0 )) / (float2( 1,1 ) - float2( 0,0 )));
			float2 break11 = temp_output_3_0;
			float temp_output_10_0 = atan2( break11.y , break11.x );
			float temp_output_17_0 = ( 1.0 - (0.0 + (temp_output_10_0 - ( ( _UTiling * UNITY_PI ) * -1.0 )) * (1.0 - 0.0) / (( _UTiling * UNITY_PI ) - ( ( _UTiling * UNITY_PI ) * -1.0 ))) );
			float temp_output_4_0 = length( temp_output_3_0 );
			float temp_output_21_0 = ( temp_output_4_0 - frac( _VOffset ) );
			float2 appendResult8 = (float2(( temp_output_17_0 - _UOffset ) , temp_output_21_0));
			float4 tex2DNode6 = tex2D( _BaseMap, appendResult8 );
			float2 appendResult59 = (float2(frac( ( temp_output_17_0 - ( _FllowDelay * _UOffset ) ) ) , temp_output_21_0));
			float4 tex2DNode56 = tex2D( _BaseMap, appendResult59 );
			float temp_output_51_0 = saturate( (0.0 + (( tex2DNode6.a * lerp(1.0,( (0.0 + (temp_output_10_0 - -3.0) * (2.0 - 0.0) / (3.0 - -3.0)) * (-1.0 + (temp_output_10_0 - 5.0) * (1.0 - -1.0) / (1.0 - 5.0)) ),_FadeIn) * tex2DNode56.g ) - _AlphaProgress) * (3.0 - 0.0) / (1.0 - _AlphaProgress)) );
			float4 lerpResult48 = lerp( _ColorB , _ColorA , ( tex2DNode6.r * tex2DNode56.g ));
			c.rgb = ( ( float4( 0,0,0,0 ) + ( lerpResult48 * ( tex2DNode56.g + _ColorB ) ) ) * temp_output_51_0 ).rgb;
			c.a = temp_output_51_0;
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
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred 

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
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
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
-95;245;1238;700;-2279.29;536.5928;1.544509;True;False
Node;AmplifyShaderEditor.Vector2Node;79;-2067.164,414.387;Float;False;Constant;_Vector0;Vector 0;10;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;78;-2065.911,549.7264;Float;False;Property;_VTiling;V-Tiling;7;0;Create;True;0;0;False;0;0.6482049;1.97;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-1728.196,396.7654;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-1704.498,555.9406;Float;False;Constant;_Float3;Float 3;10;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-1529.147,440.9765;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1660.311,133.6816;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-1100.27,-234.0538;Float;False;Property;_UTiling;U-Tiling;5;0;Create;True;0;0;False;0;1.752941;0.49;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;3;-1303.794,192.9981;Float;True;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;27;-790.8789,-227.9818;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;11;-877.3757,3.56831;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;29;-769.8789,-129.9818;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-505.4576,-199.8332;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;10;-604.4108,-19.68901;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-120.0313,-158.4046;Float;False;Property;_UOffset;U-Offset;4;0;Create;True;0;0;False;0;0;-0.04;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;-329.5185,-32.45841;Float;True;5;0;FLOAT;0;False;1;FLOAT;-3.14;False;2;FLOAT;3.14;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-112.178,-258.1199;Float;False;Property;_FllowDelay;FllowDelay;8;0;Create;True;0;0;False;0;0;0.38;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;237.522,-231.8197;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-331.5918,358.1781;Float;False;Property;_VOffset;V-Offset;6;0;Create;True;0;0;False;0;0;-0.11;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;-37.08785,-40.20114;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;22;-32.91686,362.9801;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;4;-858.7188,288.4883;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;63;440.3905,-289.0106;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;236.3349,-38.10893;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;69;676.8536,-287.7143;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;21;178.3088,290.238;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;45;-206.5935,-510.7093;Float;False;5;0;FLOAT;0;False;1;FLOAT;5;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;44;-206.676,-667.3843;Float;False;5;0;FLOAT;0;False;1;FLOAT;-3;False;2;FLOAT;3;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;586.0904,64.72394;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;59;789.8747,402.992;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;1048.705,-687.8963;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;1076.378,-475.0262;Float;False;Constant;_Float1;Float 1;12;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;56;1061.71,378.9826;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;184328a132507384895f8f289794228d;184328a132507384895f8f289794228d;True;0;False;white;Auto;False;Instance;6;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;1007.691,39.72776;Float;True;Property;_BaseMap;BaseMap;3;0;Create;True;0;0;False;0;184328a132507384895f8f289794228d;89baf543835d3fe4f811e9ce3cff0b89;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;49;1034.527,-345.9573;Float;False;Property;_ColorB;Color B;2;0;Create;True;0;0;False;0;0.1783088,0.381212,0.7132353,0;0.5808823,0.2957432,0.1110509,0.966;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;82;1362.551,-674.3575;Float;False;Property;_FadeIn;FadeIn;11;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;1403.445,51.96267;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;50;1034.368,-166.2953;Float;False;Property;_ColorA;Color A;1;1;[HDR];Create;True;0;0;False;0;1.085735,1.355647,1.38,0;2.251,1.418175,0.6620587,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;2097.747,298.7123;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;48;1750.189,-215.3401;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;75;2046.419,599.6102;Float;False;Property;_AlphaProgress;AlphaProgress;10;0;Create;True;0;0;False;0;0.07058825;0.46;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;67;1769.349,28.80656;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;74;2407.7,291.1199;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;2125.633,-78.17593;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;51;2746.074,294.3992;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;102;2550.454,648.603;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;73;1108.62,636.4026;Float;False;Property;_AlphaPower;AlphaPower;9;0;Create;True;0;0;False;0;0.3882353;1.861214;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;3226.791,65.21883;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;72;1439.099,519.4249;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;1784.255,493.5642;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;37;187.3634,528.9971;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;39;-116.0349,506.4574;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;5;-609.78,429.6212;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;107;3827.462,-130.4293;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;OM-Dev/Effect/UV-Rotate-Slash;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;77;0;79;0
WireConnection;77;1;78;0
WireConnection;80;0;77;0
WireConnection;80;1;81;0
WireConnection;3;0;1;0
WireConnection;3;3;80;0
WireConnection;3;4;77;0
WireConnection;27;0;30;0
WireConnection;11;0;3;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;10;0;11;1
WireConnection;10;1;11;0
WireConnection;13;0;10;0
WireConnection;13;1;28;0
WireConnection;13;2;27;0
WireConnection;60;0;62;0
WireConnection;60;1;19;0
WireConnection;17;0;13;0
WireConnection;22;0;20;0
WireConnection;4;0;3;0
WireConnection;63;0;17;0
WireConnection;63;1;60;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;69;0;63;0
WireConnection;21;0;4;0
WireConnection;21;1;22;0
WireConnection;45;0;10;0
WireConnection;44;0;10;0
WireConnection;8;0;18;0
WireConnection;8;1;21;0
WireConnection;59;0;69;0
WireConnection;59;1;21;0
WireConnection;47;0;44;0
WireConnection;47;1;45;0
WireConnection;56;1;59;0
WireConnection;6;1;8;0
WireConnection;82;0;83;0
WireConnection;82;1;47;0
WireConnection;65;0;6;1
WireConnection;65;1;56;2
WireConnection;41;0;6;4
WireConnection;41;1;82;0
WireConnection;41;2;56;2
WireConnection;48;0;49;0
WireConnection;48;1;50;0
WireConnection;48;2;65;0
WireConnection;67;0;56;2
WireConnection;67;1;49;0
WireConnection;74;0;41;0
WireConnection;74;1;75;0
WireConnection;55;0;48;0
WireConnection;55;1;67;0
WireConnection;51;0;74;0
WireConnection;102;1;55;0
WireConnection;108;0;102;0
WireConnection;108;1;51;0
WireConnection;72;0;56;2
WireConnection;72;1;73;0
WireConnection;76;0;72;0
WireConnection;76;1;6;3
WireConnection;37;0;39;0
WireConnection;39;0;5;0
WireConnection;5;0;4;0
WireConnection;107;9;51;0
WireConnection;107;13;108;0
ASEEND*/
//CHKSM=B4F52F6C9B13249A0CBBF946624E93A939012B74