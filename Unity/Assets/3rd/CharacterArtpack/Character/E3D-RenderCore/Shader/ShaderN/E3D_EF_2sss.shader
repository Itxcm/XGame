// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.16 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.16;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,ufog:True,aust:False,igpj:False,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:True;n:type:ShaderForge.SFN_Final,id:3292,x:34446,y:33222,varname:node_3292,prsc:2|custl-7343-OUT,alpha-1233-OUT;n:type:ShaderForge.SFN_Tex2d,id:2275,x:33041,y:32704,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:1898,x:32655,y:32879,ptovrint:False,ptlb:Falloff,ptin:_Falloff,varname:_Falloff,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3159-OUT;n:type:ShaderForge.SFN_Multiply,id:2357,x:33450,y:33117,varname:node_2357,prsc:2|A-2275-RGB,B-2250-OUT,C-8093-OUT;n:type:ShaderForge.SFN_ScreenPos,id:2940,x:31938,y:33176,varname:node_2940,prsc:2,sctp:0;n:type:ShaderForge.SFN_Multiply,id:2675,x:32164,y:33232,varname:node_2675,prsc:2|A-2940-UVOUT,B-7561-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7561,x:31986,y:33365,ptovrint:False,ptlb:DetailScale,ptin:_DetailScale,varname:_DetailScale,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Panner,id:9135,x:32372,y:33183,varname:node_9135,prsc:2,spu:0.01,spv:-0.4|UVIN-2675-OUT;n:type:ShaderForge.SFN_Panner,id:3999,x:32372,y:33400,varname:node_3999,prsc:2,spu:-0.01,spv:-0.3|UVIN-2675-OUT;n:type:ShaderForge.SFN_Tex2d,id:5637,x:32698,y:33258,varname:_node_4991,prsc:2,ntxv:0,isnm:False|UVIN-9135-UVOUT,TEX-2091-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:2091,x:32372,y:33625,ptovrint:False,ptlb:DetailMap,ptin:_DetailMap,varname:_DetailMap,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:450,x:32698,y:33453,varname:_node_9426,prsc:2,ntxv:0,isnm:False|UVIN-3999-UVOUT,TEX-2091-TEX;n:type:ShaderForge.SFN_NormalVector,id:6293,x:31938,y:32871,prsc:2,pt:False;n:type:ShaderForge.SFN_ViewVector,id:8362,x:31937,y:33021,varname:node_8362,prsc:2;n:type:ShaderForge.SFN_Dot,id:528,x:32129,y:32916,varname:node_528,prsc:2,dt:1|A-6293-OUT,B-8362-OUT;n:type:ShaderForge.SFN_Append,id:9063,x:32309,y:32905,varname:node_9063,prsc:2|A-528-OUT,B-528-OUT;n:type:ShaderForge.SFN_OneMinus,id:9859,x:32879,y:33014,varname:node_9859,prsc:2|IN-1898-A;n:type:ShaderForge.SFN_Add,id:8093,x:33179,y:33011,varname:node_8093,prsc:2|A-9859-OUT,B-5899-OUT;n:type:ShaderForge.SFN_Vector1,id:5899,x:32857,y:32920,varname:node_5899,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Add,id:2250,x:33127,y:33318,varname:node_2250,prsc:2|A-5637-RGB,B-9094-OUT;n:type:ShaderForge.SFN_Multiply,id:9094,x:32955,y:33475,varname:node_9094,prsc:2|A-5637-A,B-450-A;n:type:ShaderForge.SFN_Slider,id:1751,x:33260,y:33445,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:_Opacity,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_VertexColor,id:6850,x:33093,y:33699,varname:node_6850,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3239,x:33752,y:33510,varname:node_3239,prsc:2|A-1751-OUT,B-6850-A;n:type:ShaderForge.SFN_Lerp,id:7343,x:33685,y:33307,varname:node_7343,prsc:2|A-2821-OUT,B-2357-OUT,T-6850-R;n:type:ShaderForge.SFN_Slider,id:4218,x:32129,y:32703,ptovrint:False,ptlb:FalloffRange,ptin:_FalloffRange,varname:_FalloffRange,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1,max:1;n:type:ShaderForge.SFN_Add,id:3159,x:32472,y:32748,varname:node_3159,prsc:2|A-4218-OUT,B-9063-OUT;n:type:ShaderForge.SFN_Multiply,id:2821,x:33450,y:32954,varname:node_2821,prsc:2|A-2275-RGB,B-2250-OUT;n:type:ShaderForge.SFN_Tex2d,id:7589,x:33457,y:33798,ptovrint:False,ptlb:DissolveNoise,ptin:_DissolveNoise,varname:_DissolveNoise,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Step,id:902,x:33770,y:33852,varname:node_902,prsc:2|A-7589-R,B-1830-OUT;n:type:ShaderForge.SFN_Slider,id:1830,x:33359,y:34087,ptovrint:False,ptlb:Dissolve,ptin:_Dissolve,varname:_Dissolve,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:1233,x:34000,y:33645,varname:node_1233,prsc:2|A-3239-OUT,B-902-OUT;proporder:2275-1898-7561-2091-1751-4218-7589-1830;pass:END;sub:END;*/

Shader "Moba_C/2sss" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Falloff ("Falloff", 2D) = "white" {}
        _DetailScale ("DetailScale", Float ) = 3
        _DetailMap ("DetailMap", 2D) = "white" {}
        _Opacity ("Opacity", Range(0, 1)) = 1
        _FalloffRange ("FalloffRange", Range(0, 1)) = 0.1
        _DissolveNoise ("DissolveNoise", 2D) = "white" {}
        _Dissolve ("Dissolve", Range(0, 1)) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="Transparent"
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
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 2.0
            uniform float4 _TimeEditor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _Falloff; uniform float4 _Falloff_ST;
            uniform float _DetailScale;
            uniform sampler2D _DetailMap; uniform float4 _DetailMap_ST;
            uniform float _Opacity;
            uniform float _FalloffRange;
            uniform sampler2D _DissolveNoise; uniform float4 _DissolveNoise_ST;
            uniform float _Dissolve;
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
                float4 screenPos : TEXCOORD3;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                UNITY_TRANSFER_FOG(o,o.pos);
                o.screenPos = o.pos;
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                i.screenPos = float4( i.screenPos.xy / i.screenPos.w, 0, 0 );
                i.screenPos.y *= _ProjectionParams.x;
/////// Vectors:
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 node_8410 = _Time + _TimeEditor;
                float2 node_2675 = (i.screenPos.rg*_DetailScale);
                float2 node_9135 = (node_2675+node_8410.g*float2(0.01,-0.4));
                float4 _node_4991 = tex2D(_DetailMap,TRANSFORM_TEX(node_9135, _DetailMap));
                float2 node_3999 = (node_2675+node_8410.g*float2(-0.01,-0.3));
                float4 _node_9426 = tex2D(_DetailMap,TRANSFORM_TEX(node_3999, _DetailMap));
                float3 node_2250 = (_node_4991.rgb+(_node_4991.a*_node_9426.a));
                float node_528 = max(0,dot(i.normalDir,viewDirection));
                float2 node_3159 = (_FalloffRange+float2(node_528,node_528));
                float4 _Falloff_var = tex2D(_Falloff,TRANSFORM_TEX(node_3159, _Falloff));
                float3 finalColor = lerp((_MainTex_var.rgb*node_2250),(_MainTex_var.rgb*node_2250*((1.0 - _Falloff_var.a)+0.3)),i.vertexColor.r);
                float4 _DissolveNoise_var = tex2D(_DissolveNoise,TRANSFORM_TEX(i.uv0, _DissolveNoise));
                fixed4 finalRGBA = fixed4(finalColor,((_Opacity*i.vertexColor.a)*step(_DissolveNoise_var.r,_Dissolve)));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
