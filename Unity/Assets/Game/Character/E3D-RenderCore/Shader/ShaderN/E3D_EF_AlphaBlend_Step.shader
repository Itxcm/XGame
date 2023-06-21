// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.19 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.19;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:-1,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:8119,x:34122,y:32859,varname:node_8119,prsc:2|custl-4887-OUT,alpha-8425-OUT;n:type:ShaderForge.SFN_Tex2d,id:3421,x:33471,y:32893,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:1551,x:33471,y:33080,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:_MainColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_VertexColor,id:4405,x:33126,y:33084,varname:node_4405,prsc:2;n:type:ShaderForge.SFN_Multiply,id:4887,x:33801,y:32944,varname:node_4887,prsc:2|A-3421-RGB,B-1551-RGB,C-4405-RGB;n:type:ShaderForge.SFN_Multiply,id:8425,x:33859,y:33195,varname:node_8425,prsc:2|A-3421-A,B-1551-A,C-4456-OUT;n:type:ShaderForge.SFN_Tex2d,id:5025,x:33142,y:33315,ptovrint:False,ptlb:StepTex,ptin:_StepTex,varname:node_5025,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Step,id:4456,x:33650,y:33370,varname:node_4456,prsc:2|A-6573-OUT,B-2382-OUT;n:type:ShaderForge.SFN_Slider,id:2382,x:33331,y:33596,ptovrint:False,ptlb:StepPower,ptin:_StepPower,varname:node_2382,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.3,max:1;n:type:ShaderForge.SFN_OneMinus,id:3934,x:33307,y:33355,varname:node_3934,prsc:2|IN-5025-A;n:type:ShaderForge.SFN_OneMinus,id:9829,x:33288,y:33228,varname:node_9829,prsc:2|IN-4405-A;n:type:ShaderForge.SFN_Multiply,id:6573,x:33477,y:33274,varname:node_6573,prsc:2|A-9829-OUT,B-3934-OUT;proporder:1551-3421-5025-2382;pass:END;sub:END;*/

Shader "Moba_EF/27B_AlphaBlend_Step" {
    Properties {
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _StepTex ("StepTex", 2D) = "white" {}
        _StepPower ("StepPower", Range(0, 1)) = 0.3
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent -1"
            "RenderType"="Transparent"
            "ForceNoShadowCasting"="True"
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _MainColor;
            uniform sampler2D _StepTex; uniform float4 _StepTex_ST;
            uniform float _StepPower;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
/////// Vectors:
////// Lighting:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 finalColor = (_MainTex_var.rgb*_MainColor.rgb*i.vertexColor.rgb);
                float4 _StepTex_var = tex2D(_StepTex,TRANSFORM_TEX(i.uv0, _StepTex));
                return fixed4(finalColor,(_MainTex_var.a*_MainColor.a*step(((1.0 - i.vertexColor.a)*(1.0 - _StepTex_var.a)),_StepPower)));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
