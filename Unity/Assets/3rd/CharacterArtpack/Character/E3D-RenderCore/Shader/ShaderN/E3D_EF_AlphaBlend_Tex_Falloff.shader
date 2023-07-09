// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.16 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.16;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:False,rfrpn:Refraction,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:8119,x:34051,y:32837,varname:node_8119,prsc:2|custl-2593-OUT,alpha-202-OUT;n:type:ShaderForge.SFN_Tex2d,id:3421,x:33201,y:32870,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:1551,x:33201,y:32579,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:_MainColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_VertexColor,id:4405,x:33201,y:32724,varname:node_4405,prsc:2;n:type:ShaderForge.SFN_Multiply,id:202,x:33739,y:33073,varname:node_202,prsc:2|A-4804-OUT,B-4598-OUT,C-6902-OUT;n:type:ShaderForge.SFN_Slider,id:6902,x:33063,y:33348,ptovrint:False,ptlb:Power,ptin:_Power,varname:node_6902,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:3;n:type:ShaderForge.SFN_Fresnel,id:5721,x:33032,y:33049,varname:node_5721,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2593,x:33510,y:32667,varname:node_2593,prsc:2|A-1551-RGB,B-4405-RGB,C-3421-RGB;n:type:ShaderForge.SFN_Multiply,id:4804,x:33510,y:32858,varname:node_4804,prsc:2|A-1551-A,B-4405-A,C-3421-A;n:type:ShaderForge.SFN_Slider,id:7150,x:32977,y:33211,ptovrint:False,ptlb:Falloff,ptin:_Falloff,varname:node_7150,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2.091284,max:10;n:type:ShaderForge.SFN_Multiply,id:6659,x:33243,y:33058,varname:node_6659,prsc:2|A-5721-OUT,B-7150-OUT;n:type:ShaderForge.SFN_OneMinus,id:4598,x:33484,y:33073,varname:node_4598,prsc:2|IN-6659-OUT;proporder:3421-1551-6902-7150;pass:END;sub:END;*/

Shader "Moba_EF/45_AlphaBlend_Tex_Falloff" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _Power ("Power", Range(0, 3)) = 1
        _Falloff ("Falloff", Range(0, 10)) = 2.091284
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            //"Queue"="Transparent -100"
            "Queue"="AlphaTest"
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
            ZWrite Off
            //Ztest Always
            //Cull off
            
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
            uniform float _Power;
            uniform float _Falloff;
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
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 node_2593 = (_MainColor.rgb*i.vertexColor.rgb*_MainTex_var.rgb);
                float3 finalColor = node_2593;
                return fixed4(finalColor,((_MainColor.a*i.vertexColor.a*_MainTex_var.a)*(1.0 - ((1.0-max(0,dot(normalDirection, viewDirection)))*_Falloff))*_Power));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
