// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.10 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.10;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,nrsp:0,limd:3,spmd:0,grmd:0,uamb:False,mssp:True,bkdf:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:False,hqlp:True,tesm:0,blpr:1,bsrc:3,bdst:7,culm:2,dpts:2,wrdp:False,dith:0,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.2306556,fgcg:0.1892301,fgcb:0.7352941,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:40,x:32027,y:32574,varname:node_40,prsc:2|emission-9942-OUT,alpha-218-OUT;n:type:ShaderForge.SFN_Tex2d,id:217,x:30939,y:32632,ptovrint:True,ptlb:Base-RGBA,ptin:_BaseRGBA,varname:_BaseRGBA,prsc:2,tex:6ace6f0388e3dc34ebd335f2048ad257,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:218,x:31683,y:33033,varname:node_218,prsc:2|A-8596-OUT,B-6096-OUT;n:type:ShaderForge.SFN_Slider,id:6096,x:31258,y:33201,ptovrint:False,ptlb:Alpha,ptin:_Alpha,varname:_Alpha,prsc:2,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Multiply,id:9942,x:31773,y:32674,varname:node_9942,prsc:2|A-217-RGB,B-6505-RGB;n:type:ShaderForge.SFN_Tex2d,id:5290,x:30942,y:32999,ptovrint:False,ptlb:Shape-RGBA,ptin:_ShapeRGBA,varname:_ShapeRGB,prsc:2,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:6505,x:31482,y:32740,ptovrint:False,ptlb:BaseColor,ptin:_BaseColor,varname:_BaseColor,prsc:2,glob:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:8596,x:31312,y:32912,varname:node_8596,prsc:2|A-217-A,B-5290-R;proporder:217-5290-6096-6505;pass:END;sub:END;*/

Shader "EJoyShader/Effect/Soft/SoftEdge-2T-DarkBlender" {
    Properties {
        _BaseRGBA ("Base-RGBA", 2D) = "white" {}
        _ShapeRGBA ("Shape-RGBA", 2D) = "white" {}
        _Alpha ("Alpha", Range(0, 10)) = 1
        _BaseColor ("BaseColor", Color) = (1,1,1,1)
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
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers d3d11 d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _BaseRGBA; uniform float4 _BaseRGBA_ST;
            uniform float _Alpha;
            uniform sampler2D _ShapeRGBA; uniform float4 _ShapeRGBA_ST;
            uniform float4 _BaseColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
/////// Vectors:
////// Lighting:
////// Emissive:
                float4 _BaseRGBA_var = tex2D(_BaseRGBA,TRANSFORM_TEX(i.uv0, _BaseRGBA));
                float3 emissive = (_BaseRGBA_var.rgb*_BaseColor.rgb);
                float3 finalColor = emissive;
                float4 _ShapeRGBA_var = tex2D(_ShapeRGBA,TRANSFORM_TEX(i.uv0, _ShapeRGBA));
                return fixed4(finalColor,((_BaseRGBA_var.a*_ShapeRGBA_var.r)*_Alpha));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
