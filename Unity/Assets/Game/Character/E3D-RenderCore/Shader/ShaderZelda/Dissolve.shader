// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3DEffect/C1/ZeldaFire"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTex("MainTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			half2 uv_texcoord;
		};

		uniform sampler2D _MainTex;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color27 = IsGammaSpace() ? half4(1,0.3931034,0,1) : half4(1,0.1280861,0,1);
			float4 color28 = IsGammaSpace() ? half4(1,0.5172414,0,1) : half4(1,0.230348,0,1);
			float mulTime61 = _Time.y * 2.0;
			float2 panner58 = ( mulTime61 * float2( 0,0 ) + i.uv_texcoord);
			half4 tex2DNode49 = tex2D( _MainTex, frac( panner58 ) );
			float2 panner59 = ( mulTime61 * float2( 0,0 ) + i.uv_texcoord);
			half4 tex2DNode50 = tex2D( _MainTex, frac( panner59 ) );
			float clampResult51 = clamp( ( i.uv_texcoord.y * 0.0 ) , 0.0 , 1.0 );
			float4 appendResult37 = (half4(0.0 , ( ( tex2DNode49.b * tex2DNode50.a ) * clampResult51 * 0.5 ) , 0.0 , 0.0));
			half4 tex2DNode31 = tex2D( _MainTex, ( half4( i.uv_texcoord, 0.0 , 0.0 ) + appendResult37 ).xy );
			float4 lerpResult22 = lerp( color27 , color28 , tex2DNode31);
			o.Emission = ( lerpResult22 * 1.666 ).rgb;
			o.Alpha = 1;
			float4 appendResult38 = (half4(0.0 , ( ( ( tex2DNode49.b + tex2DNode50.a ) * 0.5 ) - ( 0.5 * 2.0 ) ) , 0.0 , 0.0));
			float clampResult20 = clamp( ( tex2DNode31.r + tex2D( _MainTex, ( half4( i.uv_texcoord, 0.0 , 0.0 ) + appendResult38 ).xy ).g + ( tex2DNode31.g / 0.0 ) ) , 0.0 , 1.0 );
			clip( clampResult20 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
260;78;1066;955;4025.584;1963.859;4.307875;True;False
Node;AmplifyShaderEditor.RangedFloatNode;62;-3041.298,281.7041;Float;False;Constant;_Speed;Speed;6;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;60;-2860.8,27.50397;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;61;-2826.997,285.3042;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;59;-2477.297,275.8039;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;58;-2471.413,37.30946;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;56;-2175.148,281.8271;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;77;-2233.782,-149.1064;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;None;e4b20b0ebbfc90a4d817648793b9da8a;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FractNode;54;-2194.418,54.14145;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-2380.548,514.3608;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-2055.454,486.4942;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;49;-1937.421,28.92683;Float;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;50;-1937.831,226.1893;Float;True;Property;_TextureSample3;Texture Sample 3;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;-1563.403,417.4344;Float;False;Constant;_NoistStrength;NoistStrength;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1558.403,524.4344;Float;False;Constant;_Float3;Float 3;3;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-1550.403,88.43445;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;51;-1816.831,476.1893;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-1527.403,262.4344;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1279.4,247.7423;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1083.131,151.2696;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1283.487,79.93301;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1271.4,373.7423;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;-963.816,-237.8207;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;37;-875.9163,-39.52054;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;41;-1073.131,275.2696;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-647.916,-50.92056;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-831.2161,190.8801;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;31;-408.43,-126.464;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;39;-634.9168,166.1797;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;28;-334.3544,-334.8061;Float;False;Constant;_Color;Color;1;0;Create;True;0;0;False;0;1,0.5172414,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;33;-92.95715,270.3353;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;-311.5233,-510.3643;Float;False;Constant;_ColorOutside;ColorOutside;1;0;Create;True;0;0;False;0;1,0.3931034,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;32;-433.235,199.0306;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;21;77.27665,185.3354;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;22;-5.92334,-250.2646;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;30;28.28128,-8.151636;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;1.666;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;20;264.9315,148.0326;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;266.0767,-90.26459;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;18;649.178,-162.4189;Half;False;True;2;Half;ASEMaterialInspector;0;0;Unlit;E3DEffect/C1/ZeldaFire;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;61;0;62;0
WireConnection;59;0;60;0
WireConnection;59;1;61;0
WireConnection;58;0;60;0
WireConnection;58;1;61;0
WireConnection;56;0;59;0
WireConnection;54;0;58;0
WireConnection;52;0;57;2
WireConnection;49;0;77;0
WireConnection;49;1;54;0
WireConnection;50;0;77;0
WireConnection;50;1;56;0
WireConnection;48;0;49;3
WireConnection;48;1;50;4
WireConnection;51;0;52;0
WireConnection;45;0;49;3
WireConnection;45;1;50;4
WireConnection;44;0;45;0
WireConnection;44;1;46;0
WireConnection;42;0;48;0
WireConnection;42;1;51;0
WireConnection;42;2;46;0
WireConnection;43;0;46;0
WireConnection;43;1;47;0
WireConnection;37;0;40;0
WireConnection;37;1;42;0
WireConnection;41;0;44;0
WireConnection;41;1;43;0
WireConnection;34;0;35;0
WireConnection;34;1;37;0
WireConnection;38;0;40;0
WireConnection;38;1;41;0
WireConnection;31;0;77;0
WireConnection;31;1;34;0
WireConnection;39;0;35;0
WireConnection;39;1;38;0
WireConnection;33;0;31;2
WireConnection;32;0;77;0
WireConnection;32;1;39;0
WireConnection;21;0;31;1
WireConnection;21;1;32;2
WireConnection;21;2;33;0
WireConnection;22;0;27;0
WireConnection;22;1;28;0
WireConnection;22;2;31;0
WireConnection;20;0;21;0
WireConnection;19;0;22;0
WireConnection;19;1;30;0
WireConnection;18;2;19;0
WireConnection;18;10;20;0
ASEEND*/
//CHKSM=5E9E8589798F97A0DDC3C3D83B880564200BE365