// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.16 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.16;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:880,x:33105,y:32696,varname:node_880,prsc:2|alpha-9288-OUT,refract-9094-OUT;n:type:ShaderForge.SFN_Tex2d,id:5342,x:32439,y:33001,ptovrint:False,ptlb:MaskTex,ptin:_MaskTex,varname:_WaveMap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False;n:type:ShaderForge.SFN_ComponentMask,id:1040,x:32682,y:33001,varname:node_1040,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-5342-RGB;n:type:ShaderForge.SFN_Slider,id:9492,x:32250,y:33361,ptovrint:False,ptlb:WarpPower,ptin:_WarpPower,varname:_WarpPower,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1,max:0.5;n:type:ShaderForge.SFN_Multiply,id:9094,x:32896,y:33001,varname:node_9094,prsc:2|A-1040-OUT,B-7186-OUT,C-5342-A;n:type:ShaderForge.SFN_VertexColor,id:6029,x:32363,y:33174,varname:node_6029,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7186,x:32606,y:33217,varname:node_7186,prsc:2|A-6029-A,B-9492-OUT;n:type:ShaderForge.SFN_Vector1,id:9288,x:32552,y:32757,varname:node_9288,prsc:2,v1:0;proporder:5342-9492;pass:END;sub:END;*/

Shader "Moba_EF/30A_AirWaveTexAlpha" {
    Properties {
        _MaskTex ("MaskTex", 2D) = "black" {}
        _WarpPower ("WarpPower", Range(0, 0.5)) = 0.1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 200
        GrabPass{ }
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform sampler2D _MaskTex; uniform float4 _MaskTex_ST;
            uniform float _WarpPower;
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
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.screenPos = o.pos;
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                #if UNITY_UV_STARTS_AT_TOP
                    float grabSign = -_ProjectionParams.x;
                #else
                    float grabSign = _ProjectionParams.x;
                #endif
                i.screenPos = float4( i.screenPos.xy / i.screenPos.w, 0, 0 );
                i.screenPos.y *= _ProjectionParams.x;
                float4 _MaskTex_var = tex2D(_MaskTex,TRANSFORM_TEX(i.uv0, _MaskTex));
                float2 sceneUVs = float2(1,grabSign)*i.screenPos.xy*0.5+0.5 + (_MaskTex_var.rgb.rg*(i.vertexColor.a*_WarpPower)*_MaskTex_var.a);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
/////// Vectors:
////// Lighting:
                float3 finalColor = 0;
                return fixed4(lerp(sceneColor.rgb, finalColor,0.0),1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
