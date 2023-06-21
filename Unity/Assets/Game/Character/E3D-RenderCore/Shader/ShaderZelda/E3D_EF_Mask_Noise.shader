// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "E3DEffect/Trail/Mask-Noise"
{
	Properties
	{
		_MaskMap("MaskMap", 2D) = "white" {}
		[HDR]_InnerColor("InnerColor", Color) = (1,0.7655172,0,0)
		[HDR]_MidColor("MidColor", Color) = (1,0.7655172,0,0)
		_OuterColor("OuterColor", Color) = (1,0.5172414,0,0)
		_NoiseDirectiong("NoiseDirectiong", Vector) = (1,1,0,0)
		_Remap("Remap", Range( 0 , 0.5)) = 0.4079998
		_TilingVNoise("TilingVNoise", Range( 0 , 12)) = 1
		_TilingUNoise("TilingUNoise", Range( 0 , 12)) = 1
		_NoiseSpeed("NoiseSpeed", Range( 0 , 5)) = 0.2588235
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Overlay+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend One One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _OuterColor;
		uniform float4 _MidColor;
		uniform sampler2D _MaskMap;
		uniform float4 _MaskMap_ST;
		uniform float _TilingUNoise;
		uniform float _TilingVNoise;
		uniform float2 _NoiseDirectiong;
		uniform float _NoiseSpeed;
		uniform float4 _InnerColor;
		uniform float _Remap;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_MaskMap = i.uv_texcoord * _MaskMap_ST.xy + _MaskMap_ST.zw;
			float4 tex2DNode1 = tex2D( _MaskMap, uv_MaskMap );
			float2 appendResult37 = (float2(_TilingUNoise , _TilingVNoise));
			float2 uv_TexCoord7 = i.uv_texcoord * appendResult37 + ( _Time.y * _NoiseDirectiong * _NoiseSpeed );
			float temp_output_4_0 = ( tex2DNode1.r * tex2D( _MaskMap, uv_TexCoord7 ).b * i.vertexColor.a );
			float4 lerpResult25 = lerp( _OuterColor , _MidColor , temp_output_4_0);
			o.Emission = ( ( lerpResult25 + ( _InnerColor * tex2DNode1.g ) ) * saturate( ( tex2DNode1.g + saturate( (0.0 + (temp_output_4_0 - _Remap) * (1.0 - 0.0) / (0.5 - _Remap)) ) ) ) * i.vertexColor ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
1927;29;1066;314;4072.688;1168.955;5.791162;True;False
Node;AmplifyShaderEditor.RangedFloatNode;38;-1731.839,250.7416;Float;False;Property;_TilingVNoise;TilingVNoise;7;0;Create;True;0;0;False;0;1;1;0;12;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1712.646,169.2293;Float;False;Property;_TilingUNoise;TilingUNoise;8;0;Create;True;0;0;False;0;1;2.54;0;12;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;9;-1637.298,442.2338;Float;False;Property;_NoiseDirectiong;NoiseDirectiong;5;0;Create;True;0;0;False;0;1,1;-1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;12;-1716.564,559.996;Float;False;Property;_NoiseSpeed;NoiseSpeed;9;0;Create;True;0;0;False;0;0.2588235;3.48;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;-1613.126,378.4859;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-1420.839,213.7416;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1413.298,406.2338;Float;False;3;3;0;FLOAT;0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1235.802,282.307;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-943.9954,-55.07463;Float;True;Property;_MaskMap;MaskMap;1;0;Create;True;0;0;False;0;872639b73b20a1845b92063e5983ef2d;872639b73b20a1845b92063e5983ef2d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;19;-920.405,636.7026;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-943.0431,296.3902;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;35;-392.9337,506.4469;Float;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;False;0;0.5;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-397.1798,404.6051;Float;False;Property;_Remap;Remap;6;0;Create;True;0;0;False;0;0.4079998;0.407;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-391.2528,147.089;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2;-44.89279,149;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;-546.6238,-207.5787;Float;False;Property;_MidColor;MidColor;3;1;[HDR];Create;True;0;0;False;0;1,0.7655172,0,0;2,0.9517238,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;26;-552.0777,-377.696;Float;False;Property;_OuterColor;OuterColor;4;0;Create;True;0;0;False;0;1,0.5172414,0,0;1,0.3103448,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;30;228.9151,99.66083;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;34;-546.3106,-605.8897;Float;False;Property;_InnerColor;InnerColor;2;1;[HDR];Create;True;0;0;False;0;1,0.7655172,0,0;2.238,1.964039,1.069632,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;25;-105.0807,-304.2838;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;409.5184,9.641614;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-48.38033,-541.6663;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;419.5448,-361.741;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;16;624.5712,-14.86844;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;911.5355,-178.3684;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;18;1241.633,-233.4753;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;E3DEffect/Trail/Mask-Noise;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Opaque;;Overlay;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;37;0;11;0
WireConnection;37;1;38;0
WireConnection;10;0;6;0
WireConnection;10;1;9;0
WireConnection;10;2;12;0
WireConnection;7;0;37;0
WireConnection;7;1;10;0
WireConnection;31;1;7;0
WireConnection;4;0;1;1
WireConnection;4;1;31;3
WireConnection;4;2;19;4
WireConnection;2;0;4;0
WireConnection;2;1;13;0
WireConnection;2;2;35;0
WireConnection;30;0;2;0
WireConnection;25;0;26;0
WireConnection;25;1;27;0
WireConnection;25;2;4;0
WireConnection;23;0;1;2
WireConnection;23;1;30;0
WireConnection;33;0;34;0
WireConnection;33;1;1;2
WireConnection;32;0;25;0
WireConnection;32;1;33;0
WireConnection;16;0;23;0
WireConnection;28;0;32;0
WireConnection;28;1;16;0
WireConnection;28;2;19;0
WireConnection;18;2;28;0
ASEEND*/
//CHKSM=5A74B92080ACC348FB512A54B87B9C5D5E9C65BA