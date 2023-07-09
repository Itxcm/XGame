// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// 注意：手动更改此数据可能会妨碍您在 Shader Forge 中打开它
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33192,y:32502,varname:node_9361,prsc:2|custl-7535-OUT,clip-6433-OUT;n:type:ShaderForge.SFN_Tex2d,id:4902,x:32442,y:32545,ptovrint:False,ptlb:Tex,ptin:_Tex,varname:node_4902,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:11611ca7eef09a34ba61e3867a8a2bfd,ntxv:0,isnm:False|UVIN-7485-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:6284,x:32080,y:32611,varname:node_6284,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:7485,x:32242,y:32621,varname:node_7485,prsc:2,spu:0,spv:-0.5|UVIN-6284-UVOUT;n:type:ShaderForge.SFN_Color,id:8148,x:32385,y:32361,ptovrint:False,ptlb:color,ptin:_color,varname:node_8148,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:7535,x:32731,y:32468,varname:node_7535,prsc:2|A-8148-RGB,B-4902-RGB;n:type:ShaderForge.SFN_Tex2d,id:6844,x:32363,y:33024,ptovrint:False,ptlb:node_6844,ptin:_node_6844,varname:node_6844,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:11611ca7eef09a34ba61e3867a8a2bfd,ntxv:0,isnm:False|UVIN-7485-UVOUT;n:type:ShaderForge.SFN_Step,id:6433,x:32843,y:32937,varname:node_6433,prsc:2|A-7664-OUT,B-1546-OUT;n:type:ShaderForge.SFN_Vector1,id:7664,x:32555,y:32884,varname:node_7664,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Tex2d,id:4092,x:32407,y:33281,ptovrint:False,ptlb:node_4092,ptin:_node_4092,varname:node_4092,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:8c4a7fca2884fab419769ccc0355c0c1,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:1546,x:32607,y:33184,varname:node_1546,prsc:2|A-6844-R,B-4092-R;n:type:ShaderForge.SFN_Subtract,id:9243,x:32888,y:33133,varname:node_9243,prsc:2|A-7664-OUT,B-6940-OUT;n:type:ShaderForge.SFN_Vector1,id:6940,x:32698,y:33351,varname:node_6940,prsc:2,v1:0;n:type:ShaderForge.SFN_Step,id:2390,x:33078,y:33053,varname:node_2390,prsc:2;proporder:4902-8148-6844-4092;pass:END;sub:END;*/

Shader "Shader Forge/firetest" {
    Properties {
        _Tex ("Tex", 2D) = "white" {}
        [HDR]_color ("color", Color) = (0.5,0.5,0.5,1)
        _node_6844 ("node_6844", 2D) = "white" {}
        _node_4092 ("node_4092", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Tex; uniform float4 _Tex_ST;
            uniform float4 _color;
            uniform sampler2D _node_6844; uniform float4 _node_6844_ST;
            uniform sampler2D _node_4092; uniform float4 _node_4092_ST;
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
                float node_7664 = 0.5;
                float4 node_5764 = _Time;
                float2 node_7485 = (i.uv0+node_5764.g*float2(0,-0.5));
                float4 _node_6844_var = tex2D(_node_6844,TRANSFORM_TEX(node_7485, _node_6844));
                float4 _node_4092_var = tex2D(_node_4092,TRANSFORM_TEX(i.uv0, _node_4092));
                clip(step(node_7664,(_node_6844_var.r*_node_4092_var.r)) - 0.5);
////// Lighting:
                float4 _Tex_var = tex2D(_Tex,TRANSFORM_TEX(node_7485, _Tex));
                float3 finalColor = (_color.rgb*_Tex_var.rgb);
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _node_6844; uniform float4 _node_6844_ST;
            uniform sampler2D _node_4092; uniform float4 _node_4092_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float node_7664 = 0.5;
                float4 node_7002 = _Time;
                float2 node_7485 = (i.uv0+node_7002.g*float2(0,-0.5));
                float4 _node_6844_var = tex2D(_node_6844,TRANSFORM_TEX(node_7485, _node_6844));
                float4 _node_4092_var = tex2D(_node_4092,TRANSFORM_TEX(i.uv0, _node_4092));
                clip(step(node_7664,(_node_6844_var.r*_node_4092_var.r)) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
