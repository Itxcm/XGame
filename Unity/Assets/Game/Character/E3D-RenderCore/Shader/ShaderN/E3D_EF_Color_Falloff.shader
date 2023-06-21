// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// 注意：手动更改此数据可能会妨碍您在 Shader Forge 中打开它
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:True,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:7196,x:33418,y:32774,varname:node_7196,prsc:2|custl-2721-OUT;n:type:ShaderForge.SFN_Color,id:3068,x:32360,y:32868,ptovrint:False,ptlb:MainColor,ptin:_MainColor,varname:_MainColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_VertexColor,id:5695,x:32360,y:33056,varname:node_5695,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9384,x:32635,y:32937,varname:node_9384,prsc:2|A-3068-RGB,B-5695-RGB;n:type:ShaderForge.SFN_NormalVector,id:8674,x:32373,y:33189,prsc:2,pt:False;n:type:ShaderForge.SFN_ViewVector,id:5592,x:32373,y:33331,varname:node_5592,prsc:2;n:type:ShaderForge.SFN_Dot,id:7398,x:32576,y:33217,varname:node_7398,prsc:2,dt:0|A-8674-OUT,B-5592-OUT;n:type:ShaderForge.SFN_Power,id:4177,x:32813,y:33142,varname:node_4177,prsc:2|VAL-7398-OUT,EXP-8998-OUT;n:type:ShaderForge.SFN_Slider,id:5701,x:32804,y:33491,ptovrint:False,ptlb:FalloffPower,ptin:_FalloffPower,varname:node_5701,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Exp,id:7721,x:32692,y:33469,varname:node_7721,prsc:2,et:1|IN-5701-OUT;n:type:ShaderForge.SFN_Multiply,id:9245,x:33053,y:33240,varname:node_9245,prsc:2|A-4177-OUT,B-5701-OUT,C-5695-A;n:type:ShaderForge.SFN_Slider,id:8998,x:32328,y:33471,ptovrint:False,ptlb:FalloffRange,ptin:_FalloffRange,varname:node_8998,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Multiply,id:2721,x:33204,y:32927,varname:node_2721,prsc:2|A-9384-OUT,B-9245-OUT;proporder:3068-5701-8998;pass:END;sub:END;*/

Shader "Moba_EF/43_Color_Falloff" {
    Properties {
        _MainColor ("MainColor", Color) = (0.5,0.5,0.5,1)
        _FalloffPower ("FalloffPower", Range(0, 10)) = 1
        _FalloffRange ("FalloffRange", Range(0, 10)) = 1
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
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles n3ds wiiu 
            #pragma target 2.0
            uniform float4 _MainColor;
            uniform float _FalloffPower;
            uniform float _FalloffRange;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
                float3 finalColor = ((_MainColor.rgb*i.vertexColor.rgb)*(pow(dot(i.normalDir,viewDirection),_FalloffRange)*_FalloffPower*i.vertexColor.a));
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
