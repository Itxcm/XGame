// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:449,x:33971,y:33032,varname:node_449,prsc:2|emission-2391-OUT,alpha-1163-OUT;n:type:ShaderForge.SFN_Tex2d,id:4183,x:32422,y:32581,ptovrint:False,ptlb:Textures,ptin:_Textures,varname:_Textures,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b109cbebe8ef6e44f8c9eae13a246647,ntxv:0,isnm:False|UVIN-5091-OUT;n:type:ShaderForge.SFN_Multiply,id:2391,x:33630,y:33080,varname:node_2391,prsc:2|A-4183-RGB,B-7355-OUT;n:type:ShaderForge.SFN_Color,id:8415,x:31792,y:33083,ptovrint:False,ptlb:DifuseColor,ptin:_DifuseColor,varname:_DifuseColor,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.9586205,c3:1,c4:1;n:type:ShaderForge.SFN_VertexColor,id:4862,x:32151,y:32803,varname:node_4862,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:4500,x:32850,y:33390,ptovrint:False,ptlb:OpactiyTex,ptin:_OpactiyTex,varname:_OpactiyTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:1163,x:33496,y:33383,varname:node_1163,prsc:2|A-4183-A,B-4862-A,C-4500-R,D-4834-OUT;n:type:ShaderForge.SFN_Add,id:5091,x:32135,y:32602,varname:node_5091,prsc:2|A-2060-UVOUT,B-9808-OUT;n:type:ShaderForge.SFN_TexCoord,id:2060,x:31584,y:32473,varname:node_2060,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:6629,x:31377,y:32662,ptovrint:False,ptlb:Tex_U_Speed,ptin:_Tex_U_Speed,varname:_Tex_U_Speed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:5076,x:31378,y:33002,ptovrint:False,ptlb:Tex_V_Speed,ptin:_Tex_V_Speed,varname:_Tex_V_Speed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Time,id:2664,x:31378,y:32788,varname:node_2664,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2622,x:31591,y:32669,varname:node_2622,prsc:2|A-6629-OUT,B-2664-T;n:type:ShaderForge.SFN_Multiply,id:2568,x:31609,y:32890,varname:node_2568,prsc:2|A-2664-T,B-5076-OUT;n:type:ShaderForge.SFN_Append,id:9808,x:31830,y:32797,varname:node_9808,prsc:2|A-2622-OUT,B-2568-OUT;n:type:ShaderForge.SFN_TexCoord,id:2294,x:31219,y:33348,varname:node_2294,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Tex2d,id:9979,x:31198,y:33537,ptovrint:False,ptlb:Disslove Tex,ptin:_DissloveTex,varname:_DissloveTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e5e4f8d6f0dfeca45a8fcc8174dfa252,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Step,id:1348,x:31540,y:33466,varname:node_1348,prsc:2|A-2294-U,B-9979-R;n:type:ShaderForge.SFN_SwitchProperty,id:4834,x:33055,y:33689,ptovrint:False,ptlb:Disslove,ptin:_Disslove,varname:_Disslove,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-8229-OUT,B-6572-OUT;n:type:ShaderForge.SFN_Vector1,id:8229,x:32757,y:33591,varname:node_8229,prsc:2,v1:1;n:type:ShaderForge.SFN_Step,id:5444,x:31540,y:33708,varname:node_5444,prsc:2|A-2294-U,B-8241-OUT;n:type:ShaderForge.SFN_Add,id:8241,x:31338,y:33742,varname:node_8241,prsc:2|A-9979-R,B-9854-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9854,x:31104,y:33764,ptovrint:False,ptlb:Thickness  ,ptin:_Thickness,varname:node_9854,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;n:type:ShaderForge.SFN_Subtract,id:5117,x:31911,y:33662,varname:node_5117,prsc:2|A-5444-OUT,B-1348-OUT;n:type:ShaderForge.SFN_Add,id:6572,x:32757,y:33774,varname:node_6572,prsc:2|A-1348-OUT,B-5117-OUT;n:type:ShaderForge.SFN_Color,id:7238,x:31792,y:33310,ptovrint:False,ptlb:EdgeColor,ptin:_EdgeColor,varname:node_7238,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4482756,c2:0,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:9993,x:32283,y:33460,varname:node_9993,prsc:2|A-7238-RGB,B-5117-OUT;n:type:ShaderForge.SFN_Add,id:9589,x:32467,y:33200,varname:node_9589,prsc:2|A-1132-OUT,B-9993-OUT;n:type:ShaderForge.SFN_Multiply,id:1132,x:32106,y:33187,varname:node_1132,prsc:2|A-8415-RGB,B-1348-OUT;n:type:ShaderForge.SFN_Multiply,id:7355,x:32758,y:33183,varname:node_7355,prsc:2|A-9589-OUT,B-4500-R,C-4183-A;proporder:4183-4500-8415-6629-5076-9979-4834-9854-7238;pass:END;sub:END;*/

Shader "OM/Effect/OM-Disslove" {
    Properties {
        _Textures ("Textures", 2D) = "white" {}
        _OpactiyTex ("OpactiyTex", 2D) = "white" {}
        [HDR]_DifuseColor ("DifuseColor", Color) = (0,0.9586205,1,1)
        _Tex_U_Speed ("Tex_U_Speed", Float ) = 0
        _Tex_V_Speed ("Tex_V_Speed", Float ) = 0
        _DissloveTex ("Disslove Tex", 2D) = "white" {}
        [MaterialToggle] _Disslove ("Disslove", Float ) = 0
        _Thickness ("Thickness  ", Float ) = 0.2
        [HDR]_EdgeColor ("EdgeColor", Color) = (0.4482756,0,1,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 100
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
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles metal 
            #pragma target 3.0
            uniform sampler2D _Textures; uniform float4 _Textures_ST;
            uniform float4 _DifuseColor;
            uniform sampler2D _OpactiyTex; uniform float4 _OpactiyTex_ST;
            uniform float _Tex_U_Speed;
            uniform float _Tex_V_Speed;
            uniform sampler2D _DissloveTex; uniform float4 _DissloveTex_ST;
            uniform fixed _Disslove;
            uniform float _Thickness;
            uniform float4 _EdgeColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 node_2664 = _Time;
                float2 node_5091 = (i.uv0+float2((_Tex_U_Speed*node_2664.g),(node_2664.g*_Tex_V_Speed)));
                float4 _Textures_var = tex2D(_Textures,TRANSFORM_TEX(node_5091, _Textures));
                float4 _DissloveTex_var = tex2D(_DissloveTex,TRANSFORM_TEX(i.uv0, _DissloveTex));
                float node_1348 = step(i.uv1.r,_DissloveTex_var.r);
                float node_5117 = (step(i.uv1.r,(_DissloveTex_var.r+_Thickness))-node_1348);
                float4 _OpactiyTex_var = tex2D(_OpactiyTex,TRANSFORM_TEX(i.uv0, _OpactiyTex));
                float3 emissive = (_Textures_var.rgb*(((_DifuseColor.rgb*node_1348)+(_EdgeColor.rgb*node_5117))*_OpactiyTex_var.r*_Textures_var.a));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,(_Textures_var.a*i.vertexColor.a*_OpactiyTex_var.r*lerp( 1.0, (node_1348+node_5117), _Disslove )));
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
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles metal 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
