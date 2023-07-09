// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// 注意：手动更改此数据可能会妨碍您在 Shader Forge 中打开它
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33439,y:32705,varname:node_9361,prsc:2|custl-4593-OUT,alpha-9219-A;n:type:ShaderForge.SFN_Tex2d,id:9219,x:33126,y:32791,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_9219,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:df10e407c9d029c4196a7cc525034a87,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:4780,x:31948,y:32761,varname:node_4780,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Sin,id:2363,x:32483,y:32794,varname:node_2363,prsc:2|IN-1525-OUT;n:type:ShaderForge.SFN_RemapRange,id:2221,x:32105,y:32730,varname:node_2221,prsc:2,frmn:0,frmx:1,tomn:0,tomx:3.14|IN-4780-U;n:type:ShaderForge.SFN_Power,id:5672,x:32611,y:32928,varname:node_5672,prsc:2|VAL-2363-OUT,EXP-1238-OUT;n:type:ShaderForge.SFN_Slider,id:7321,x:31895,y:33201,ptovrint:False,ptlb:node_7321,ptin:_node_7321,varname:node_7321,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:10;n:type:ShaderForge.SFN_RemapRange,id:1814,x:32242,y:33147,varname:node_1814,prsc:2,frmn:0,frmx:10,tomn:10,tomx:1|IN-7321-OUT;n:type:ShaderForge.SFN_Color,id:8203,x:32640,y:33269,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_8203,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:3329,x:32917,y:33076,varname:node_3329,prsc:2|A-5672-OUT,B-7226-OUT,C-8203-RGB;n:type:ShaderForge.SFN_Vector1,id:7226,x:32690,y:33184,varname:node_7226,prsc:2,v1:2;n:type:ShaderForge.SFN_Add,id:4593,x:33297,y:32890,varname:node_4593,prsc:2|A-9219-RGB,B-3329-OUT;n:type:ShaderForge.SFN_Exp,id:1238,x:32445,y:33164,varname:node_1238,prsc:2,et:0|IN-1814-OUT;n:type:ShaderForge.SFN_Slider,id:8227,x:31895,y:32973,ptovrint:False,ptlb:Offset,ptin:_Offset,varname:node_8227,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-3.2,cur:0,max:3.2;n:type:ShaderForge.SFN_Add,id:1525,x:32291,y:32827,varname:node_1525,prsc:2|A-2221-OUT,B-8227-OUT;n:type:ShaderForge.SFN_Clamp,id:3121,x:32814,y:32872,varname:node_3121,prsc:2;proporder:9219-7321-8203-8227;pass:END;sub:END;*/

Shader "Shader Forge/SaoguangTest" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _node_7321 ("node_7321", Range(0, 10)) = 0
        [HDR]_Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Offset ("Offset", Range(-3.2, 3.2)) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _node_7321;
            uniform float4 _Color;
            uniform float _Offset;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 finalColor = (_MainTex_var.rgb+(pow(sin(((i.uv0.r*3.14+0.0)+_Offset)),exp((_node_7321*-0.9+10.0)))*2.0*_Color.rgb));
                fixed4 finalRGBA = fixed4(finalColor,_MainTex_var.a);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
