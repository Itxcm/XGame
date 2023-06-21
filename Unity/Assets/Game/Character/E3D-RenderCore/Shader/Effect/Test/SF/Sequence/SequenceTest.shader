// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// 注意：手动更改此数据可能会妨碍您在 Shader Forge 中打开它
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33265,y:32712,varname:node_9361,prsc:2|custl-5008-RGB;n:type:ShaderForge.SFN_TexCoord,id:639,x:32201,y:32525,varname:node_639,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_UVTile,id:8001,x:32799,y:32687,varname:node_8001,prsc:2|UVIN-6-OUT,WDT-207-OUT,HGT-6072-OUT,TILE-9542-OUT;n:type:ShaderForge.SFN_Append,id:6,x:32621,y:32562,varname:node_6,prsc:2|A-639-U,B-2745-OUT;n:type:ShaderForge.SFN_RemapRange,id:2745,x:32375,y:32562,varname:node_2745,prsc:2,frmn:0,frmx:1,tomn:1,tomx:0|IN-639-V;n:type:ShaderForge.SFN_Tex2d,id:5008,x:33017,y:32706,ptovrint:False,ptlb:node_5008,ptin:_node_5008,varname:node_5008,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8001-UVOUT;n:type:ShaderForge.SFN_ValueProperty,id:1588,x:32194,y:32864,ptovrint:False,ptlb:X,ptin:_X,varname:node_1588,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:4;n:type:ShaderForge.SFN_Negate,id:6072,x:32388,y:32835,varname:node_6072,prsc:2|IN-1588-OUT;n:type:ShaderForge.SFN_ValueProperty,id:207,x:32507,y:32713,ptovrint:False,ptlb:Y,ptin:_Y,varname:node_207,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:4;n:type:ShaderForge.SFN_Time,id:4817,x:32210,y:33037,varname:node_4817,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:6896,x:32210,y:33253,ptovrint:False,ptlb:node_6896,ptin:_node_6896,varname:node_6896,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.6;n:type:ShaderForge.SFN_Multiply,id:3118,x:32401,y:33090,varname:node_3118,prsc:2|A-4817-T,B-6896-OUT;n:type:ShaderForge.SFN_Trunc,id:9542,x:32617,y:33008,varname:node_9542,prsc:2|IN-3118-OUT;n:type:ShaderForge.SFN_Tex2d,id:5036,x:32862,y:32956,ptovrint:False,ptlb:node_5036,ptin:_node_5036,varname:node_5036,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:False;proporder:5008-1588-207-6896;pass:END;sub:END;*/

Shader "Shader Forge/SequenceTest" {
    Properties {
        _node_5008 ("node_5008", 2D) = "white" {}
        _X ("X", Float ) = 4
        _Y ("Y", Float ) = 4
        _node_6896 ("node_6896", Float ) = 0.6
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
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _node_5008; uniform float4 _node_5008_ST;
            uniform float _X;
            uniform float _Y;
            uniform float _node_6896;
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
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
                float4 node_4817 = _Time;
                float node_9542 = trunc((node_4817.g*_node_6896));
                float2 node_8001_tc_rcp = float2(1.0,1.0)/float2( _Y, (-1*_X) );
                float node_8001_ty = floor(node_9542 * node_8001_tc_rcp.x);
                float node_8001_tx = node_9542 - _Y * node_8001_ty;
                float2 node_8001 = (float2(i.uv0.r,(i.uv0.g*-1.0+1.0)) + float2(node_8001_tx, node_8001_ty)) * node_8001_tc_rcp;
                float4 _node_5008_var = tex2D(_node_5008,TRANSFORM_TEX(node_8001, _node_5008));
                float3 finalColor = _node_5008_var.rgb;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
