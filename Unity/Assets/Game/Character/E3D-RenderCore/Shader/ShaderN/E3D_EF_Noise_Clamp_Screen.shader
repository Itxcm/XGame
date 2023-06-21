// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.16 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.16;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,ufog:True,aust:False,igpj:False,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:True;n:type:ShaderForge.SFN_Final,id:3292,x:34019,y:33246,varname:node_3292,prsc:2|custl-2357-OUT,clip-9879-OUT;n:type:ShaderForge.SFN_Multiply,id:2357,x:33504,y:33268,varname:node_2357,prsc:2|A-2725-RGB,B-5768-OUT;n:type:ShaderForge.SFN_ScreenPos,id:2940,x:31938,y:33176,varname:node_2940,prsc:2,sctp:0;n:type:ShaderForge.SFN_Multiply,id:2675,x:32164,y:33232,varname:node_2675,prsc:2|A-2940-UVOUT,B-7561-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7561,x:31986,y:33365,ptovrint:False,ptlb:DetailScale,ptin:_DetailScale,varname:_DetailScale,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Panner,id:9135,x:32372,y:33183,varname:node_9135,prsc:2,spu:0.01,spv:-0.4|UVIN-2675-OUT;n:type:ShaderForge.SFN_Panner,id:3999,x:32372,y:33400,varname:node_3999,prsc:2,spu:-0.01,spv:-0.3|UVIN-2675-OUT;n:type:ShaderForge.SFN_Tex2d,id:5637,x:32698,y:33258,varname:_node_5637,prsc:2,ntxv:0,isnm:False|UVIN-9135-UVOUT,TEX-5757-TEX;n:type:ShaderForge.SFN_Tex2d,id:450,x:32698,y:33453,varname:_node_9426,prsc:2,ntxv:0,isnm:False|UVIN-3999-UVOUT,TEX-5757-TEX;n:type:ShaderForge.SFN_Add,id:2250,x:33053,y:33346,varname:node_2250,prsc:2|A-5637-A,B-450-A,C-6451-OUT;n:type:ShaderForge.SFN_VertexColor,id:6850,x:33102,y:33625,varname:node_6850,prsc:2;n:type:ShaderForge.SFN_Color,id:2725,x:33127,y:33121,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:_MainColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2dAsset,id:5757,x:32402,y:33647,ptovrint:False,ptlb:DetailMap,ptin:_DetailMap,varname:_DetailMap,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:8345,x:33555,y:33619,varname:node_8345,prsc:2|A-4792-OUT,B-6850-A;n:type:ShaderForge.SFN_Tex2d,id:3523,x:32837,y:33823,varname:_aa,prsc:2,ntxv:0,isnm:False|UVIN-8006-UVOUT,TEX-3325-TEX;n:type:ShaderForge.SFN_Panner,id:8006,x:32552,y:33844,varname:node_8006,prsc:2,spu:-0.05,spv:0|UVIN-335-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:335,x:32239,y:33829,varname:node_335,prsc:2,uv:0;n:type:ShaderForge.SFN_Panner,id:2426,x:32589,y:34052,varname:node_2426,prsc:2,spu:0.1,spv:0|UVIN-2643-OUT;n:type:ShaderForge.SFN_Multiply,id:2643,x:32415,y:34062,varname:node_2643,prsc:2|A-335-UVOUT,B-7230-OUT;n:type:ShaderForge.SFN_Tex2d,id:905,x:32889,y:34070,varname:_node_905,prsc:2,ntxv:0,isnm:False|UVIN-2426-UVOUT,TEX-3325-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:3325,x:32667,y:34228,ptovrint:False,ptlb:FalloffMap,ptin:_FalloffMap,varname:_FalloffMap,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Vector1,id:7230,x:32217,y:34096,varname:node_7230,prsc:2,v1:0.75;n:type:ShaderForge.SFN_Multiply,id:4792,x:33404,y:33859,varname:node_4792,prsc:2|A-4907-OUT,B-3829-OUT;n:type:ShaderForge.SFN_Add,id:4907,x:33138,y:33877,varname:node_4907,prsc:2|A-3523-A,B-905-A;n:type:ShaderForge.SFN_Slider,id:3829,x:33036,y:34259,ptovrint:False,ptlb:FalloffRange,ptin:_FalloffRange,varname:_FalloffRange,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Vector1,id:6451,x:32698,y:33630,varname:node_6451,prsc:2,v1:0.5;n:type:ShaderForge.SFN_RemapRange,id:5768,x:33275,y:33386,varname:node_5768,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-2250-OUT;n:type:ShaderForge.SFN_Lerp,id:9879,x:33795,y:33719,varname:node_9879,prsc:2|A-8345-OUT,B-6665-OUT,T-6117-OUT;n:type:ShaderForge.SFN_OneMinus,id:6117,x:33388,y:33715,varname:node_6117,prsc:2|IN-6850-R;n:type:ShaderForge.SFN_Vector1,id:6665,x:33581,y:33820,varname:node_6665,prsc:2,v1:1;proporder:7561-2725-5757-3325-3829;pass:END;sub:END;*/

Shader "Moba_EF/38_Noise_Clamp_Screen" {
    Properties {
        _DetailScale ("DetailScale", Float ) = 3
        _MainColor ("MainColor", Color) = (0.5,0.5,0.5,1)
        _DetailMap ("DetailMap", 2D) = "white" {}
        _FalloffMap ("FalloffMap", 2D) = "white" {}
        _FalloffRange ("FalloffRange", Range(0, 1)) = 0.5
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
        _TexSpeedAX ("TexSpeed_A_X", Float ) = 1.0
        _TexSpeedAY ("TexSpeed_A_Y", Float ) = 1.0
        _TexSpeedBX ("TexSpeed_B_X", Float ) = 0.0
        _TexSpeedBY ("TexSpeed_B_Y", Float ) = 0.0
    }
    SubShader {
        Tags {
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
            uniform float _DetailScale;
            uniform float4 _MainColor;
            uniform sampler2D _DetailMap; uniform float4 _DetailMap_ST;
            uniform sampler2D _FalloffMap; uniform float4 _FalloffMap_ST;
            uniform float _FalloffRange;
            uniform float _TexSpeedAX;
            uniform float _TexSpeedAY;
            uniform float _TexSpeedBX;
            uniform float _TexSpeedBY;
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
                float4 node_7384 = _Time + _TimeEditor;
                float2 node_8006 = (i.uv0+node_7384.g*float2(_TexSpeedAX,_TexSpeedAY));
                float4 _aa = tex2D(_FalloffMap,TRANSFORM_TEX(node_8006, _FalloffMap));
                float2 node_2426 = ((i.uv0*0.75)+node_7384.g*float2(_TexSpeedBX,_TexSpeedBY));
                float4 _node_905 = tex2D(_FalloffMap,TRANSFORM_TEX(node_2426, _FalloffMap));
                clip(lerp((((_aa.a+_node_905.a)*_FalloffRange)*i.vertexColor.a),1.0,(1.0 - i.vertexColor.r)) - 0.5);
////// Lighting:
                float2 node_2675 = (i.screenPos.rg*_DetailScale);
                float2 node_9135 = (node_2675+node_7384.g*float2(0.01,-0.4));
                float4 _node_5637 = tex2D(_DetailMap,TRANSFORM_TEX(node_9135, _DetailMap));
                float2 node_3999 = (node_2675+node_7384.g*float2(-0.01,-0.3));
                float4 _node_9426 = tex2D(_DetailMap,TRANSFORM_TEX(node_3999, _DetailMap));
                float3 finalColor = (_MainColor.rgb*((_node_5637.a+_node_9426.a+0.5)*0.5+0.5));
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }

    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
