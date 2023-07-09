// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.10 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.10;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,nrsp:0,limd:0,spmd:1,grmd:0,uamb:False,mssp:True,bkdf:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:False,hqlp:True,tesm:0,blpr:3,bsrc:0,bdst:6,culm:2,dpts:2,wrdp:False,dith:0,ufog:False,aust:False,igpj:True,qofs:0,qpre:4,rntp:5,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.2306556,fgcg:0.1892301,fgcb:0.7352941,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:40,x:32027,y:32574,varname:node_40,prsc:2|emission-9942-OUT,alpha-8781-OUT;n:type:ShaderForge.SFN_Tex2d,id:217,x:30904,y:32208,ptovrint:True,ptlb:Base-RGBA,ptin:_BaseRGBA,varname:_BaseRGBA,prsc:2,tex:f1b8bc6eadeddb24e9f3ba34972e9292,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:6096,x:31071,y:32796,ptovrint:False,ptlb:EdgeClip,ptin:_EdgeClip,varname:_EdgeClip,prsc:2,min:0,cur:5,max:5;n:type:ShaderForge.SFN_VertexColor,id:4009,x:31196,y:32915,varname:node_4009,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9942,x:31508,y:32872,varname:node_9942,prsc:2|A-2950-OUT,B-4009-A,C-8531-RGB,D-6096-OUT,E-4009-RGB;n:type:ShaderForge.SFN_Tex2d,id:5290,x:30887,y:32462,ptovrint:False,ptlb:Shape-RGB,ptin:_ShapeRGB,varname:_ShapeRGB,prsc:2,tex:81eb5b84007875e42a3eaeb3cb7268dd,ntxv:0,isnm:False|UVIN-7969-OUT;n:type:ShaderForge.SFN_Multiply,id:2950,x:31253,y:32492,varname:node_2950,prsc:2|A-9872-OUT,B-5290-RGB;n:type:ShaderForge.SFN_Multiply,id:7969,x:30629,y:32421,varname:node_7969,prsc:2|A-8669-OUT,B-8377-UVOUT;n:type:ShaderForge.SFN_Slider,id:8669,x:30217,y:32345,ptovrint:False,ptlb:UV,ptin:_UV,varname:node_8669,prsc:2,min:0.9,cur:0.9,max:12;n:type:ShaderForge.SFN_TexCoord,id:8377,x:30344,y:32513,varname:node_8377,prsc:2,uv:1;n:type:ShaderForge.SFN_Vector1,id:8781,x:31490,y:33127,varname:node_8781,prsc:2,v1:1;n:type:ShaderForge.SFN_Add,id:9872,x:31257,y:32209,varname:node_9872,prsc:2|A-217-RGB,B-7647-RGB;n:type:ShaderForge.SFN_Color,id:7647,x:31257,y:32011,ptovrint:False,ptlb:ColorAdd,ptin:_ColorAdd,varname:node_7647,prsc:2,glob:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Color,id:8531,x:31206,y:33117,ptovrint:False,ptlb:ColorMul,ptin:_ColorMul,varname:_Color_copy,prsc:2,glob:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:217-5290-6096-8669-7647-8531;pass:END;sub:END;*/

Shader "EJoyShader/Effect/Soft/SoftEdge-2T-RingUv" {
    Properties {
        _BaseRGBA ("Base-RGBA", 2D) = "white" {}
        _ShapeRGB ("Shape-RGB", 2D) = "white" {}
        _EdgeClip ("EdgeClip", Range(0, 5)) = 5
        _UV ("UV", Range(0.9, 12)) = 0.9
        _ColorAdd ("ColorAdd", Color) = (0.5,0.5,0.5,1)
        _ColorMul ("ColorMul", Color) = (0.5,0.5,0.5,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Overlay"
            "RenderType"="Overlay"
        }
        LOD 200
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One OneMinusSrcColor
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers glcore gles gles3 metal d3d9 
            #pragma target 3.0
            uniform sampler2D _BaseRGBA; uniform float4 _BaseRGBA_ST;
            uniform float _EdgeClip;
            uniform sampler2D _ShapeRGB; uniform float4 _ShapeRGB_ST;
            uniform float _UV;
            uniform float4 _ColorAdd;
            uniform float4 _ColorMul;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
/////// Vectors:
////// Lighting:
////// Emissive:
                float4 _BaseRGBA_var = tex2D(_BaseRGBA,TRANSFORM_TEX(i.uv0, _BaseRGBA));
                float2 node_7969 = (_UV*i.uv1);
                float4 _ShapeRGB_var = tex2D(_ShapeRGB,TRANSFORM_TEX(node_7969, _ShapeRGB));
                float3 emissive = (((_BaseRGBA_var.rgb+_ColorAdd.rgb)*_ShapeRGB_var.rgb)*i.vertexColor.a*_ColorMul.rgb*_EdgeClip*i.vertexColor.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
