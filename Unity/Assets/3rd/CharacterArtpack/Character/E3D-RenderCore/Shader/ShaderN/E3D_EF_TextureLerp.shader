// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.16 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.16;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,ufog:True,aust:False,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:3218,x:33713,y:32873,varname:node_3218,prsc:2|custl-6257-OUT,olwid-4308-OUT;n:type:ShaderForge.SFN_Tex2d,id:8565,x:32483,y:32825,ptovrint:False,ptlb:LightTex,ptin:_LightTex,varname:_LightTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:1590,x:32483,y:32613,ptovrint:False,ptlb:DarkTex,ptin:_DarkTex,varname:_DarkTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:5253,x:32483,y:33054,ptovrint:False,ptlb:RampTex,ptin:_RampTex,varname:_RampTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-2890-OUT;n:type:ShaderForge.SFN_Lerp,id:3871,x:32879,y:32918,varname:node_3871,prsc:2|A-1590-RGB,B-8565-RGB,T-5253-R;n:type:ShaderForge.SFN_NormalVector,id:7309,x:31557,y:32840,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:1955,x:31555,y:33001,varname:node_1955,prsc:2;n:type:ShaderForge.SFN_Dot,id:1375,x:31767,y:32897,varname:node_1375,prsc:2,dt:4|A-7309-OUT,B-1955-OUT;n:type:ShaderForge.SFN_Append,id:2890,x:32093,y:32941,varname:node_2890,prsc:2|A-1375-OUT,B-6282-OUT;n:type:ShaderForge.SFN_Vector1,id:6282,x:31767,y:33060,varname:node_6282,prsc:2,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:2520,x:32836,y:33241,ptovrint:False,ptlb:OutLineWidth,ptin:_OutLineWidth,varname:_OutLineWidth,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:4308,x:33107,y:33247,varname:node_4308,prsc:2|A-2520-OUT,B-1122-OUT;n:type:ShaderForge.SFN_Vector1,id:1122,x:32830,y:33414,varname:node_1122,prsc:2,v1:0.01;n:type:ShaderForge.SFN_VertexColor,id:3423,x:32437,y:33316,varname:node_3423,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6257,x:33081,y:33011,varname:node_6257,prsc:2|A-3871-OUT,B-1188-OUT;n:type:ShaderForge.SFN_Add,id:4391,x:32724,y:33099,varname:node_4391,prsc:2|A-3423-RGB,B-2951-RGB;n:type:ShaderForge.SFN_Clamp01,id:1188,x:32908,y:33088,varname:node_1188,prsc:2|IN-4391-OUT;n:type:ShaderForge.SFN_Color,id:2951,x:32437,y:33501,ptovrint:False,ptlb:GradientColor,ptin:_GradientColor,varname:_GradientColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:8565-1590-5253-2520-2951;pass:END;sub:END;*/

Shader "Moba_C/Basic_TextureLerp" {
    Properties {
        _LightTex ("LightTex", 2D) = "white" {}
        _DarkTex ("DarkTex", 2D) = "white" {}
        _RampTex ("RampTex", 2D) = "white" {}
        _OutLineWidth ("OutLineWidth", Float ) = 1
        _GradientColor ("GradientColor", Color) = (0.5,0.5,0.5,1)
        _StencilID ("Stencil ID", Float) = 240
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 200

		Stencil {
			Ref [_StencilID]
			Comp always
			Pass replace
			//ZFail decrWrap
		}
		
		
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float _OutLineWidth;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_FOG_COORDS(0)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos(float4(v.vertex.xyz + v.normal*(_OutLineWidth*0.01),1));
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
/////// Vectors:
                return fixed4(float3(0,0,0),0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _LightTex; uniform float4 _LightTex_ST;
            uniform sampler2D _DarkTex; uniform float4 _DarkTex_ST;
            uniform sampler2D _RampTex; uniform float4 _RampTex_ST;
            uniform float4 _GradientColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float4 _DarkTex_var = tex2D(_DarkTex,TRANSFORM_TEX(i.uv0, _DarkTex));
                float4 _LightTex_var = tex2D(_LightTex,TRANSFORM_TEX(i.uv0, _LightTex));
                float2 node_2890 = float2(0.5*dot(i.normalDir,lightDirection)+0.5,0.0);
                float4 _RampTex_var = tex2D(_RampTex,TRANSFORM_TEX(node_2890, _RampTex));
                float3 finalColor = (lerp(_DarkTex_var.rgb,_LightTex_var.rgb,_RampTex_var.r)*saturate((i.vertexColor.rgb+_GradientColor.rgb)));
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _LightTex; uniform float4 _LightTex_ST;
            uniform sampler2D _DarkTex; uniform float4 _DarkTex_ST;
            uniform sampler2D _RampTex; uniform float4 _RampTex_ST;
            uniform float4 _GradientColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float4 _DarkTex_var = tex2D(_DarkTex,TRANSFORM_TEX(i.uv0, _DarkTex));
                float4 _LightTex_var = tex2D(_LightTex,TRANSFORM_TEX(i.uv0, _LightTex));
                float2 node_2890 = float2(0.5*dot(i.normalDir,lightDirection)+0.5,0.0);
                float4 _RampTex_var = tex2D(_RampTex,TRANSFORM_TEX(node_2890, _RampTex));
                float3 finalColor = (lerp(_DarkTex_var.rgb,_LightTex_var.rgb,_RampTex_var.r)*saturate((i.vertexColor.rgb+_GradientColor.rgb)));
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
