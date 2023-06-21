// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.16 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.16;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:880,x:33105,y:32696,varname:node_880,prsc:2|alpha-6529-OUT,refract-7702-OUT;n:type:ShaderForge.SFN_Tex2d,id:5342,x:32439,y:32911,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_WaveMap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False|UVIN-7863-UVOUT;n:type:ShaderForge.SFN_ComponentMask,id:1040,x:32652,y:32979,varname:node_1040,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-5342-RGB;n:type:ShaderForge.SFN_Slider,id:9492,x:32439,y:33187,ptovrint:False,ptlb:WarpPower,ptin:_WarpPower,varname:_WarpPower,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.03846154,max:0.5;n:type:ShaderForge.SFN_VertexColor,id:6029,x:32533,y:33317,varname:node_6029,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:3524,x:32018,y:32921,varname:node_3524,prsc:2,uv:0;n:type:ShaderForge.SFN_Vector1,id:6529,x:32812,y:32846,varname:node_6529,prsc:2,v1:0;n:type:ShaderForge.SFN_Multiply,id:7702,x:32891,y:33084,varname:node_7702,prsc:2|A-1040-OUT,B-9492-OUT,C-6029-A;n:type:ShaderForge.SFN_Panner,id:7863,x:32234,y:32982,varname:node_7863,prsc:2,spu:0.11,spv:0.22|UVIN-3524-UVOUT;proporder:5342-9492;pass:END;sub:END;*/

Shader "Moba_EF/36_AirWave_UVanm" {
    Properties {
        _MainTex ("MainTex", 2D) = "black" {}
        _WarpPower ("WarpPower", Range(0, 0.5)) = 0.03846154
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
        _SpeedX ("Speed_X", float) = 0.1
        _SpeedY ("Speed_Y", float) = 0.1
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
            Cull Off
            Zwrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform float4 _TimeEditor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _WarpPower;
            uniform float _SpeedX;
            uniform float _SpeedY;
            
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
                float4 node_3427 = _Time + _TimeEditor;
                float2 node_7863 = (i.uv0+node_3427.g*float2(_SpeedX,_SpeedY));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_7863, _MainTex));
                float2 sceneUVs = float2(1,grabSign)*i.screenPos.xy*0.5+0.5 + (_MainTex_var.rgb.rg*_WarpPower*i.vertexColor.a);
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
