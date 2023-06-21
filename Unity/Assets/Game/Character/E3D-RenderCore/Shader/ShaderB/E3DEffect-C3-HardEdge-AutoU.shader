// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.10
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.10;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,nrsp:0,limd:0,spmd:1,grmd:0,uamb:False,mssp:True,bkdf:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:False,hqlp:True,tesm:0,blpr:0,bsrc:0,bdst:1,culm:2,dpts:2,wrdp:True,dith:0,ufog:False,aust:False,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.2306556,fgcg:0.1892301,fgcb:0.7352941,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:40,x:32027,y:32574,varname:node_40,prsc:2|emission-9223-OUT,clip-218-OUT;n:type:ShaderForge.SFN_Tex2d,id:217,x:30937,y:32214,ptovrint:False,ptlb:Base-RGBA,ptin:_BaseRGBA,varname:_BaseRGBA,prsc:2,tex:f97d4e069d1f6054b9d587777a66ede6,ntxv:0,isnm:False|UVIN-6551-UVOUT;n:type:ShaderForge.SFN_Multiply,id:218,x:31722,y:32791,varname:node_218,prsc:2|A-3366-OUT,B-6096-OUT,C-4009-A,D-5145-R;n:type:ShaderForge.SFN_Slider,id:6096,x:31216,y:32812,ptovrint:False,ptlb:EdgeClip,ptin:_EdgeClip,varname:_EdgeClip,prsc:2,min:0,cur:3.000968,max:10;n:type:ShaderForge.SFN_VertexColor,id:4009,x:31267,y:32961,varname:node_4009,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:5290,x:30934,y:32501,ptovrint:False,ptlb:Dark-RGBA,ptin:_DarkRGBA,varname:_DarkRGBA,prsc:2,tex:294b4c5e12899824d8b41ff9c04c0ce1,ntxv:0,isnm:False|UVIN-5576-UVOUT;n:type:ShaderForge.SFN_Panner,id:6551,x:30658,y:32204,varname:P2,prsc:1,spu:0.1,spv:0|DIST-3116-OUT;n:type:ShaderForge.SFN_Multiply,id:3366,x:31451,y:32656,varname:node_3366,prsc:2|A-217-A,B-5290-A;n:type:ShaderForge.SFN_Panner,id:5576,x:30656,y:32499,varname:P1,prsc:2,spu:0,spv:0.35|DIST-3116-OUT;n:type:ShaderForge.SFN_Slider,id:3242,x:30018,y:32514,ptovrint:True,ptlb:Auto-Speed,ptin:_AutoSpeed,varname:_AutoSpeed,prsc:2,min:-4,cur:0.3,max:4;n:type:ShaderForge.SFN_Time,id:4769,x:30166,y:32248,varname:node_4769,prsc:0;n:type:ShaderForge.SFN_Multiply,id:3116,x:30390,y:32339,varname:node_3116,prsc:2|A-4769-T,B-3242-OUT;n:type:ShaderForge.SFN_Color,id:6223,x:31020,y:31932,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,c1:0.9705882,c2:0.9705882,c3:0.9705882,c4:1;n:type:ShaderForge.SFN_Multiply,id:3312,x:31322,y:32318,varname:node_3312,prsc:2|A-217-RGB,B-5290-RGB,C-6223-RGB;n:type:ShaderForge.SFN_Tex2d,id:5145,x:31259,y:33144,ptovrint:False,ptlb:Shape-Alpha(R),ptin:_ShapeAlphaR,varname:_ShapeAlphaR,prsc:2,tex:8d55a1c4022e3eb4491c5c82754cc2da,ntxv:0,isnm:False|UVIN-9323-OUT;n:type:ShaderForge.SFN_Multiply,id:9223,x:31833,y:32358,varname:node_9223,prsc:2|A-3312-OUT,B-4900-OUT;n:type:ShaderForge.SFN_Slider,id:4900,x:31433,y:32451,ptovrint:False,ptlb:LightMul,ptin:_LightMul,varname:_Power_copy,prsc:2,min:0,cur:8,max:8;n:type:ShaderForge.SFN_SwitchProperty,id:9323,x:31033,y:33144,ptovrint:False,ptlb:Shape-2uv,ptin:_Shape2uv,varname:node_9323,prsc:2,on:True|A-1045-UVOUT,B-4617-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:1045,x:30795,y:33067,varname:node_1045,prsc:2,uv:0;n:type:ShaderForge.SFN_TexCoord,id:4617,x:30795,y:33223,varname:node_4617,prsc:2,uv:1;proporder:217-5290-5145-9323-6096-4900-3242-6223;pass:END;sub:END;*/

Shader "E3DEffect/C3/HardEdge-AutoU" {
    Properties {
        _BaseRGBA ("Base-RGBA", 2D) = "white" {}
        _DarkRGBA ("Dark-RGBA", 2D) = "white" {}
        _ShapeAlphaR ("Shape-Alpha(R)", 2D) = "white" {}
        [MaterialToggle] _Shape2uv ("Shape-2uv", Float ) = 0
        _EdgeClip ("EdgeClip", Range(0, 10)) = 3.000968
        _LightMul ("LightMul", Range(0, 8)) = 8
        _AutoSpeed ("Auto-Speed", Range(-4, 4)) = 0.3
        _Color ("Color", Color) = (0.9705882,0.9705882,0.9705882,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        LOD 200
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off


            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers glcore gles gles3 metal d3d9
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _BaseRGBA; uniform float4 _BaseRGBA_ST;
            uniform float _EdgeClip;
            uniform sampler2D _DarkRGBA; uniform float4 _DarkRGBA_ST;
            uniform float _AutoSpeed;
            uniform float4 _Color;
            uniform sampler2D _ShapeAlphaR; uniform float4 _ShapeAlphaR_ST;
            uniform float _LightMul;
            uniform fixed _Shape2uv;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
/////// Vectors:
                fixed4 node_4769 = _Time + _TimeEditor;
                float node_3116 = (node_4769.g*_AutoSpeed);
                half2 P2 = (i.uv0+node_3116*float2(0.1,0));
                float4 _BaseRGBA_var = tex2D(_BaseRGBA,TRANSFORM_TEX(P2, _BaseRGBA));
                float2 P1 = (i.uv0+node_3116*float2(0,0.35));
                float4 _DarkRGBA_var = tex2D(_DarkRGBA,TRANSFORM_TEX(P1, _DarkRGBA));
                float2 _Shape2uv_var = lerp( i.uv0, i.uv1, _Shape2uv );
                float4 _ShapeAlphaR_var = tex2D(_ShapeAlphaR,TRANSFORM_TEX(_Shape2uv_var, _ShapeAlphaR));
                clip(((_BaseRGBA_var.a*_DarkRGBA_var.a)*_EdgeClip*i.vertexColor.a*_ShapeAlphaR_var.r) - 0.5);
////// Lighting:
////// Emissive:
                float3 emissive = ((_BaseRGBA_var.rgb*_DarkRGBA_var.rgb*_Color.rgb)*_LightMul);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCollector"
            Tags {
                "LightMode"="ShadowCollector"
            }
            Cull Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCOLLECTOR
            #define SHADOW_COLLECTOR_PASS
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcollector
            #pragma only_renderers glcore gles gles3 metal d3d9
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _BaseRGBA; uniform float4 _BaseRGBA_ST;
            uniform float _EdgeClip;
            uniform sampler2D _DarkRGBA; uniform float4 _DarkRGBA_ST;
            uniform float _AutoSpeed;
            uniform sampler2D _ShapeAlphaR; uniform float4 _ShapeAlphaR_ST;
            uniform fixed _Shape2uv;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                V2F_SHADOW_COLLECTOR;
                float2 uv0 : TEXCOORD5;
                float2 uv1 : TEXCOORD6;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_SHADOW_COLLECTOR(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
/////// Vectors:
                fixed4 node_4769 = _Time + _TimeEditor;
                float node_3116 = (node_4769.g*_AutoSpeed);
                half2 P2 = (i.uv0+node_3116*float2(0.1,0));
                float4 _BaseRGBA_var = tex2D(_BaseRGBA,TRANSFORM_TEX(P2, _BaseRGBA));
                float2 P1 = (i.uv0+node_3116*float2(0,0.35));
                float4 _DarkRGBA_var = tex2D(_DarkRGBA,TRANSFORM_TEX(P1, _DarkRGBA));
                float2 _Shape2uv_var = lerp( i.uv0, i.uv1, _Shape2uv );
                float4 _ShapeAlphaR_var = tex2D(_ShapeAlphaR,TRANSFORM_TEX(_Shape2uv_var, _ShapeAlphaR));
                clip(((_BaseRGBA_var.a*_DarkRGBA_var.a)*_EdgeClip*i.vertexColor.a*_ShapeAlphaR_var.r) - 0.5);
                SHADOW_COLLECTOR_FRAGMENT(i)
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers glcore gles gles3 metal d3d9
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _BaseRGBA; uniform float4 _BaseRGBA_ST;
            uniform float _EdgeClip;
            uniform sampler2D _DarkRGBA; uniform float4 _DarkRGBA_ST;
            uniform float _AutoSpeed;
            uniform sampler2D _ShapeAlphaR; uniform float4 _ShapeAlphaR_ST;
            uniform fixed _Shape2uv;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
/////// Vectors:
                fixed4 node_4769 = _Time + _TimeEditor;
                float node_3116 = (node_4769.g*_AutoSpeed);
                half2 P2 = (i.uv0+node_3116*float2(0.1,0));
                float4 _BaseRGBA_var = tex2D(_BaseRGBA,TRANSFORM_TEX(P2, _BaseRGBA));
                float2 P1 = (i.uv0+node_3116*float2(0,0.35));
                float4 _DarkRGBA_var = tex2D(_DarkRGBA,TRANSFORM_TEX(P1, _DarkRGBA));
                float2 _Shape2uv_var = lerp( i.uv0, i.uv1, _Shape2uv );
                float4 _ShapeAlphaR_var = tex2D(_ShapeAlphaR,TRANSFORM_TEX(_Shape2uv_var, _ShapeAlphaR));
                clip(((_BaseRGBA_var.a*_DarkRGBA_var.a)*_EdgeClip*i.vertexColor.a*_ShapeAlphaR_var.r) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
