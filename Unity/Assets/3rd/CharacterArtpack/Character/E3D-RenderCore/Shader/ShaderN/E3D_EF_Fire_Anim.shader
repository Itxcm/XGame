// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.25 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.25;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3292,x:34529,y:33063,varname:node_3292,prsc:2|custl-2357-OUT,alpha-7334-OUT;n:type:ShaderForge.SFN_Tex2d,id:2275,x:33864,y:31786,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:961d20a8e5427b541ba58f8a5c6a1356,ntxv:0,isnm:False|UVIN-4467-OUT;n:type:ShaderForge.SFN_Multiply,id:2357,x:33354,y:33273,varname:node_2357,prsc:2|A-2116-RGB,B-3036-OUT;n:type:ShaderForge.SFN_ScreenPos,id:2940,x:31938,y:33176,varname:node_2940,prsc:2,sctp:0;n:type:ShaderForge.SFN_Multiply,id:2675,x:32146,y:33297,varname:node_2675,prsc:2|A-2940-UVOUT,B-7561-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7561,x:31938,y:33367,ptovrint:False,ptlb:DetailScale,ptin:_DetailScale,varname:_DetailScale,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Panner,id:9135,x:32323,y:33232,varname:node_9135,prsc:2,spu:0.01,spv:-0.4|UVIN-2675-OUT;n:type:ShaderForge.SFN_Panner,id:3999,x:32323,y:33425,varname:node_3999,prsc:2,spu:-0.01,spv:-0.3|UVIN-2675-OUT;n:type:ShaderForge.SFN_Tex2d,id:5637,x:32698,y:33258,varname:_node_5637,prsc:2,ntxv:0,isnm:False|UVIN-9135-UVOUT,TEX-2091-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:2091,x:32360,y:33663,ptovrint:False,ptlb:DetailMap,ptin:_DetailMap,varname:_DetailMap,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:450,x:32698,y:33453,varname:_node_9426,prsc:2,ntxv:0,isnm:False|UVIN-3999-UVOUT,TEX-2091-TEX;n:type:ShaderForge.SFN_Add,id:3036,x:33132,y:33404,varname:node_3036,prsc:2|A-5637-RGB,B-3320-OUT;n:type:ShaderForge.SFN_Color,id:2116,x:33132,y:33213,ptovrint:False,ptlb:FireColor,ptin:_FireColor,varname:_FireColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:3320,x:32943,y:33574,varname:node_3320,prsc:2|A-5637-A,B-450-A;n:type:ShaderForge.SFN_Multiply,id:7272,x:33793,y:32946,varname:node_7272,prsc:2|A-2275-A,B-8986-OUT;n:type:ShaderForge.SFN_Slider,id:8986,x:32605,y:32965,ptovrint:False,ptlb:ClipPower,ptin:_ClipPower,varname:_ClipPower,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:2;n:type:ShaderForge.SFN_Slider,id:2941,x:33331,y:33518,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:_Opacity,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:7979,x:33677,y:33457,varname:node_7979,prsc:2|A-7272-OUT,B-2941-OUT;n:type:ShaderForge.SFN_Time,id:5446,x:32033,y:32587,varname:node_5446,prsc:2;n:type:ShaderForge.SFN_Vector4Property,id:4595,x:32139,y:32033,ptovrint:False,ptlb:Sheet Params,ptin:_SheetParams,varname:_SheetParams,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1,v2:8,v3:8,v4:0;n:type:ShaderForge.SFN_Multiply,id:6710,x:32391,y:32177,varname:node_6710,prsc:2|A-4595-X,B-4595-Y;n:type:ShaderForge.SFN_Frac,id:2783,x:32592,y:32606,varname:node_2783,prsc:2|IN-173-OUT;n:type:ShaderForge.SFN_Fmod,id:1424,x:33151,y:32028,varname:node_1424,prsc:2|A-1585-OUT,B-4595-X;n:type:ShaderForge.SFN_Divide,id:7918,x:32248,y:32606,varname:node_7918,prsc:2|A-6710-OUT,B-4595-Z;n:type:ShaderForge.SFN_Floor,id:1585,x:32910,y:32552,varname:node_1585,prsc:2|IN-2813-OUT;n:type:ShaderForge.SFN_Append,id:7919,x:33593,y:32095,varname:node_7919,prsc:2|A-7817-OUT,B-3161-OUT;n:type:ShaderForge.SFN_Multiply,id:2813,x:32726,y:32552,varname:node_2813,prsc:2|A-6710-OUT,B-2783-OUT;n:type:ShaderForge.SFN_Divide,id:9672,x:32870,y:32252,varname:node_9672,prsc:2|A-1585-OUT,B-4595-X;n:type:ShaderForge.SFN_TexCoord,id:4558,x:33019,y:31651,varname:node_4558,prsc:2,uv:0;n:type:ShaderForge.SFN_Divide,id:7011,x:33254,y:31784,varname:node_7011,prsc:2|A-4558-UVOUT,B-4969-OUT;n:type:ShaderForge.SFN_Append,id:4969,x:33019,y:31831,varname:node_4969,prsc:2|A-4595-X,B-4595-Y;n:type:ShaderForge.SFN_Add,id:4467,x:33581,y:31786,varname:node_4467,prsc:2|A-7011-OUT,B-7919-OUT;n:type:ShaderForge.SFN_Divide,id:7817,x:33357,y:32028,varname:node_7817,prsc:2|A-1424-OUT,B-4595-X;n:type:ShaderForge.SFN_Floor,id:7734,x:33049,y:32252,varname:node_7734,prsc:2|IN-9672-OUT;n:type:ShaderForge.SFN_Divide,id:9322,x:33226,y:32252,varname:node_9322,prsc:2|A-7734-OUT,B-4595-Y;n:type:ShaderForge.SFN_OneMinus,id:3161,x:33400,y:32252,varname:node_3161,prsc:2|IN-9322-OUT;n:type:ShaderForge.SFN_Divide,id:173,x:32434,y:32562,varname:node_173,prsc:2|A-5446-T,B-7918-OUT;n:type:ShaderForge.SFN_Tex2d,id:2528,x:33608,y:33651,ptovrint:False,ptlb:DissolveNoise,ptin:_DissolveNoise,varname:_DissolveNoise,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:4776,x:33530,y:33930,ptovrint:False,ptlb:Dissolve,ptin:_Dissolve,varname:_Dissolve,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Step,id:1685,x:34023,y:33762,varname:node_1685,prsc:2|A-2528-R,B-4776-OUT;n:type:ShaderForge.SFN_Multiply,id:7334,x:34231,y:33567,varname:node_7334,prsc:2|A-7979-OUT,B-1685-OUT,C-8769-OUT;n:type:ShaderForge.SFN_Fresnel,id:6955,x:33818,y:33592,varname:node_6955,prsc:2;n:type:ShaderForge.SFN_OneMinus,id:8769,x:33992,y:33592,varname:node_8769,prsc:2|IN-6955-OUT;proporder:2275-4595-2091-7561-2116-8986-2941-2528-4776;pass:END;sub:END;*/

Shader "Moba_C/2sss_Fire_Anim" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _SheetParams ("Sheet Params", Vector) = (1,8,8,0)
        _DetailMap ("DetailMap", 2D) = "white" {}
        _DetailScale ("DetailScale", Float ) = 3
        _FireColor ("FireColor", Color) = (0.5,0.5,0.5,1)
        _ClipPower ("ClipPower", Range(0, 2)) = 1
        _Opacity ("Opacity", Range(0, 1)) = 1
        _DissolveNoise ("DissolveNoise", 2D) = "white" {}
        _Dissolve ("Dissolve", Range(0, 1)) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _DetailScale;
            uniform sampler2D _DetailMap; uniform float4 _DetailMap_ST;
            uniform float4 _FireColor;
            uniform float _ClipPower;
            uniform float _Opacity;
            uniform float4 _SheetParams;
            uniform sampler2D _DissolveNoise; uniform float4 _DissolveNoise_ST;
            uniform float _Dissolve;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 screenPos : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                o.screenPos = o.pos;
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                i.screenPos = float4( i.screenPos.xy / i.screenPos.w, 0, 0 );
                i.screenPos.y *= _ProjectionParams.x;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
                float4 node_9266 = _Time + _TimeEditor;
                float2 node_2675 = (i.screenPos.rg*_DetailScale);
                float2 node_9135 = (node_2675+node_9266.g*float2(0.01,-0.4));
                float4 _node_5637 = tex2D(_DetailMap,node_9135);
                float2 node_3999 = (node_2675+node_9266.g*float2(-0.01,-0.3));
                float4 _node_9426 = tex2D(_DetailMap,node_3999);
                float3 finalColor = (_FireColor.rgb*(_node_5637.rgb+(_node_5637.a*_node_9426.a)));
                float node_6710 = (_SheetParams.r*_SheetParams.g);
                float4 node_5446 = _Time + _TimeEditor;
                float node_1585 = floor((node_6710*frac((node_5446.g/(node_6710/_SheetParams.b)))));
                float2 node_4467 = ((i.uv0/float2(_SheetParams.r,_SheetParams.g))+float2((fmod(node_1585,_SheetParams.r)/_SheetParams.r),(1.0 - (floor((node_1585/_SheetParams.r))/_SheetParams.g))));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_4467, _MainTex));
                float4 _DissolveNoise_var = tex2D(_DissolveNoise,TRANSFORM_TEX(i.uv0, _DissolveNoise));
                return fixed4(finalColor,(((_MainTex_var.a*_ClipPower)*_Opacity)*step(_DissolveNoise_var.r,_Dissolve)*(1.0 - (1.0-max(0,dot(normalDirection, viewDirection))))));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
