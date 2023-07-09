// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// 注意：手动更改此数据可能会妨碍您在 Shader Forge 中打开它
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:4,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:True,qofs:0,qpre:2,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.4476644,fgcg:0.468178,fgcb:0.6764706,fgca:1,fgde:0.01,fgrn:0,fgrf:90,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:7119,x:32898,y:32701,varname:node_7119,prsc:2|custl-6152-OUT;n:type:ShaderForge.SFN_Tex2d,id:66,x:32275,y:32714,ptovrint:False,ptlb:lightMap,ptin:_lightMap,varname:_lightMap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:6152,x:32663,y:32893,varname:node_6152,prsc:2|A-66-RGB,B-3653-OUT,C-9481-OUT,D-9487-RGB,E-9487-A;n:type:ShaderForge.SFN_Slider,id:9481,x:32142,y:32928,ptovrint:False,ptlb:LightPower,ptin:_LightPower,varname:_LightPower,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_VertexColor,id:6059,x:32220,y:33089,varname:node_6059,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3653,x:32410,y:33089,varname:node_3653,prsc:2|A-6059-RGB,B-6059-A;n:type:ShaderForge.SFN_Color,id:9487,x:32254,y:33242,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:node_9487,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:66-9481-9487;pass:END;sub:END;*/

Shader "E3D/EffectEN/LightShader" {
    Properties {
        _lightMap ("lightMap", 2D) = "white" {}
        _LightPower ("LightPower", Range(0, 10)) = 1
        _MainColor ("MainColor", Color) = (0.5,0.5,0.5,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="AlphaTest"
            "RenderType"="Transparent"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend DstColor One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _lightMap; uniform float4 _lightMap_ST;
            uniform float _LightPower;
            uniform float4 _MainColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
                float4 _lightMap_var = tex2D(_lightMap,TRANSFORM_TEX(i.uv0, _lightMap));
                float3 finalColor = (_lightMap_var.rgb*(i.vertexColor.rgb*i.vertexColor.a)*_LightPower*_MainColor.rgb*_MainColor.a);
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
