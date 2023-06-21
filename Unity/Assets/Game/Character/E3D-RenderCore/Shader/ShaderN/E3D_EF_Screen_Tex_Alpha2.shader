// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.16 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.16;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:7927,x:32719,y:32712,varname:node_7927,prsc:2|custl-3113-OUT,alpha-3164-OUT;n:type:ShaderForge.SFN_Tex2d,id:2827,x:31922,y:32367,ptovrint:False,ptlb:BaseTex,ptin:_BaseTex,varname:node_2827,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-18-UVOUT;n:type:ShaderForge.SFN_ScreenPos,id:18,x:31552,y:32367,varname:node_18,prsc:2,sctp:0;n:type:ShaderForge.SFN_Vector1,id:4563,x:31922,y:32573,varname:node_4563,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:8951,x:32199,y:32554,varname:node_8951,prsc:2|A-2827-RGB,B-4563-OUT;n:type:ShaderForge.SFN_Add,id:3113,x:32456,y:32758,varname:node_3113,prsc:2|A-8951-OUT,B-3776-RGB;n:type:ShaderForge.SFN_Color,id:3776,x:32199,y:32777,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:node_3776,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:2220,x:32092,y:33184,ptovrint:False,ptlb:MaskTex,ptin:_MaskTex,varname:node_2220,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-2494-UVOUT;n:type:ShaderForge.SFN_Multiply,id:3164,x:32417,y:33190,varname:node_3164,prsc:2|A-2220-A,B-1063-A,C-3776-A;n:type:ShaderForge.SFN_VertexColor,id:1063,x:32189,y:33365,varname:node_1063,prsc:2;n:type:ShaderForge.SFN_Panner,id:2494,x:31858,y:33184,varname:node_2494,prsc:2,spu:0.1,spv:1;proporder:2827-3776-2220;pass:END;sub:END;*/

Shader "Moba_EF/19_Screen_Tex_Alpha" {
    Properties {
        _BaseTex ("BaseTex", 2D) = "white" {}
        _MainColor ("MainColor", Color) = (0.5,0.5,0.5,1)
        _MaskTex ("MaskTex", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
        _Speed("Speed", Range(-10, 10)) = -0.3
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 200
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _BaseTex; uniform float4 _BaseTex_ST;
            uniform float4 _MainColor;
            uniform sampler2D _MaskTex; uniform float4 _MaskTex_ST;
            uniform float _Speed;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 screenPos : TEXCOORD1;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos(v.vertex);
                UNITY_TRANSFER_FOG(o,o.pos);
                o.screenPos = o.pos;
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.screenPos = float4( i.screenPos.xy / i.screenPos.w, 0, 0 );
                i.screenPos.y *= _ProjectionParams.x;
/////// Vectors:
////// Lighting:
                float4 _BaseTex_var = tex2D(_BaseTex,TRANSFORM_TEX(i.screenPos.rg, _BaseTex));
                float3 finalColor = ((_BaseTex_var.rgb*0.5)+_MainColor.rgb);
                float4 node_7968 = _Time + _TimeEditor;
                float2 node_2494 = (i.uv0+node_7968.g*float2(0.1,_Speed));
                float4 _MaskTex_var = tex2D(_MaskTex,TRANSFORM_TEX(node_2494, _MaskTex));
                fixed4 finalRGBA = fixed4(finalColor,(_MaskTex_var.a*i.vertexColor.a*_MainColor.a));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
