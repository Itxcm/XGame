// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// 注意：手动更改此数据可能会妨碍您在 Shader Forge 中打开它
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:34441,y:32480,varname:node_4013,prsc:2|spec-9759-OUT,gloss-7979-OUT,emission-4663-OUT,alpha-2307-OUT,clip-7035-OUT,refract-5803-OUT;n:type:ShaderForge.SFN_Tex2d,id:4844,x:32676,y:32573,ptovrint:False,ptlb:Basetex,ptin:_Basetex,varname:node_4844,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:592,x:32802,y:32241,ptovrint:False,ptlb:Specular,ptin:_Specular,varname:node_592,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:7979,x:33075,y:32496,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_7979,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_NormalVector,id:3069,x:32122,y:33040,prsc:2,pt:False;n:type:ShaderForge.SFN_Transform,id:8362,x:32309,y:33040,varname:node_8362,prsc:2,tffrom:0,tfto:3|IN-3069-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8721,x:32524,y:33040,varname:node_8721,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8362-XYZ;n:type:ShaderForge.SFN_ValueProperty,id:1661,x:33237,y:32851,ptovrint:False,ptlb:Fresnel_opacity,ptin:_Fresnel_opacity,varname:node_1661,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:5803,x:34094,y:32877,varname:node_5803,prsc:2|A-2678-OUT,B-424-OUT,C-7464-A,D-7035-OUT;n:type:ShaderForge.SFN_ValueProperty,id:424,x:33821,y:32851,ptovrint:False,ptlb:Re_intensity,ptin:_Re_intensity,varname:node_424,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Fresnel,id:744,x:33416,y:32817,varname:node_744,prsc:2|EXP-1661-OUT;n:type:ShaderForge.SFN_Tex2d,id:3259,x:32524,y:32745,ptovrint:False,ptlb:normal,ptin:_normal,varname:node_3259,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Add,id:2678,x:32907,y:32945,varname:node_2678,prsc:2|A-122-OUT,B-8721-OUT;n:type:ShaderForge.SFN_ComponentMask,id:122,x:32708,y:32777,varname:node_122,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-3259-RGB;n:type:ShaderForge.SFN_Tex2d,id:8722,x:32725,y:32325,ptovrint:False,ptlb:specular,ptin:_specular,varname:node_8722,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:9759,x:33075,y:32280,varname:node_9759,prsc:2|A-592-OUT,B-8722-R;n:type:ShaderForge.SFN_Multiply,id:5074,x:33263,y:32398,varname:node_5074,prsc:2|A-8358-RGB,B-4844-RGB;n:type:ShaderForge.SFN_Color,id:8358,x:32901,y:32399,ptovrint:False,ptlb:Basecolor,ptin:_Basecolor,varname:node_8358,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Fresnel,id:6983,x:33075,y:32817,varname:node_6983,prsc:2|EXP-4230-OUT;n:type:ShaderForge.SFN_Add,id:4663,x:33720,y:32514,varname:node_4663,prsc:2|A-5074-OUT,B-2461-OUT,C-4974-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4230,x:32917,y:32851,ptovrint:False,ptlb:Fresnel_intensity,ptin:_Fresnel_intensity,varname:node_4230,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:2461,x:33237,y:32690,varname:node_2461,prsc:2|A-7421-RGB,B-6983-OUT;n:type:ShaderForge.SFN_Color,id:7421,x:33075,y:32668,ptovrint:False,ptlb:Fresnel_color,ptin:_Fresnel_color,varname:node_7421,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:9771,x:33618,y:32835,varname:node_9771,prsc:2|A-744-OUT,B-683-OUT;n:type:ShaderForge.SFN_ValueProperty,id:683,x:33281,y:32938,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:node_683,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_VertexColor,id:7464,x:33394,y:32690,varname:node_7464,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2307,x:34081,y:32580,varname:node_2307,prsc:2|A-7464-A,B-9771-OUT;n:type:ShaderForge.SFN_Desaturate,id:4679,x:33286,y:32525,varname:node_4679,prsc:2|COL-4844-RGB;n:type:ShaderForge.SFN_Step,id:7035,x:33743,y:32700,varname:node_7035,prsc:2|A-4679-OUT,B-7464-A;n:type:ShaderForge.SFN_Cubemap,id:5153,x:33360,y:32234,ptovrint:False,ptlb:cubemap,ptin:_cubemap,varname:node_5153,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0;n:type:ShaderForge.SFN_Multiply,id:4974,x:33575,y:32321,varname:node_4974,prsc:2|A-5153-RGB,B-6929-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6929,x:33394,y:32485,ptovrint:False,ptlb:Cubemap,ptin:_Cubemap,varname:node_6929,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;proporder:4844-592-7979-1661-424-3259-8722-8358-4230-7421-683-5153-6929;pass:END;sub:END;*/

Shader "E3DEffect/C3/crystal" {
    Properties {
        _Basetex ("Basetex", 2D) = "white" {}
        _Specular ("Specular", Float ) = 0
        _Gloss ("Gloss", Float ) = 0
        _Fresnel_opacity ("Fresnel_opacity", Float ) = 0
        _Re_intensity ("Re_intensity", Float ) = 0
        _normal ("normal", 2D) = "bump" {}
        _specular ("specular", 2D) = "white" {}
        _Basecolor ("Basecolor", Color) = (0.5,0.5,0.5,1)
        _Fresnel_intensity ("Fresnel_intensity", Float ) = 0
        _Fresnel_color ("Fresnel_color", Color) = (0.5,0.5,0.5,1)
        _Opacity ("Opacity", Float ) = 0
        _cubemap ("cubemap", Cube) = "_Skybox" {}
        _Cubemap ("Cubemap", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles n3ds wiiu 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _GrabTexture;
            uniform sampler2D _Basetex; uniform float4 _Basetex_ST;
            uniform float _Specular;
            uniform float _Gloss;
            uniform float _Fresnel_opacity;
            uniform float _Re_intensity;
            uniform sampler2D _normal; uniform float4 _normal_ST;
            uniform sampler2D _specular; uniform float4 _specular_ST;
            uniform float4 _Basecolor;
            uniform float _Fresnel_intensity;
            uniform float4 _Fresnel_color;
            uniform float _Opacity;
            uniform samplerCUBE _cubemap;
            uniform float _Cubemap;
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
                float4 projPos : TEXCOORD3;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 _normal_var = UnpackNormal(tex2D(_normal,TRANSFORM_TEX(i.uv0, _normal)));
                float4 _Basetex_var = tex2D(_Basetex,TRANSFORM_TEX(i.uv0, _Basetex));
                float node_7035 = step(dot(_Basetex_var.rgb,float3(0.3,0.59,0.11)),i.vertexColor.a);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + ((_normal_var.rgb.rg+mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb.rg)*_Re_intensity*i.vertexColor.a*node_7035);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
                clip(node_7035 - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float4 _specular_var = tex2D(_specular,TRANSFORM_TEX(i.uv0, _specular));
                float node_9759 = (_Specular*_specular_var.r);
                float3 specularColor = float3(node_9759,node_9759,node_9759);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
////// Emissive:
                float3 emissive = ((_Basecolor.rgb*_Basetex_var.rgb)+(_Fresnel_color.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel_intensity))+(texCUBE(_cubemap,viewReflectDirection).rgb*_Cubemap));
/// Final Color:
                float3 finalColor = specular + emissive;
                fixed4 finalRGBA = fixed4(lerp(sceneColor.rgb, finalColor,(i.vertexColor.a*(pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel_opacity)*_Opacity))),1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles n3ds wiiu 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _GrabTexture;
            uniform sampler2D _Basetex; uniform float4 _Basetex_ST;
            uniform float _Specular;
            uniform float _Gloss;
            uniform float _Fresnel_opacity;
            uniform float _Re_intensity;
            uniform sampler2D _normal; uniform float4 _normal_ST;
            uniform sampler2D _specular; uniform float4 _specular_ST;
            uniform float4 _Basecolor;
            uniform float _Fresnel_intensity;
            uniform float4 _Fresnel_color;
            uniform float _Opacity;
            uniform samplerCUBE _cubemap;
            uniform float _Cubemap;
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
                float4 projPos : TEXCOORD3;
                LIGHTING_COORDS(4,5)
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 _normal_var = UnpackNormal(tex2D(_normal,TRANSFORM_TEX(i.uv0, _normal)));
                float4 _Basetex_var = tex2D(_Basetex,TRANSFORM_TEX(i.uv0, _Basetex));
                float node_7035 = step(dot(_Basetex_var.rgb,float3(0.3,0.59,0.11)),i.vertexColor.a);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + ((_normal_var.rgb.rg+mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb.rg)*_Re_intensity*i.vertexColor.a*node_7035);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
                clip(node_7035 - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float4 _specular_var = tex2D(_specular,TRANSFORM_TEX(i.uv0, _specular));
                float node_9759 = (_Specular*_specular_var.r);
                float3 specularColor = float3(node_9759,node_9759,node_9759);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/// Final Color:
                float3 finalColor = specular;
                fixed4 finalRGBA = fixed4(finalColor * (i.vertexColor.a*(pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel_opacity)*_Opacity)),0);
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
            #pragma only_renderers d3d9 d3d11 glcore gles n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _Basetex; uniform float4 _Basetex_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _Basetex_var = tex2D(_Basetex,TRANSFORM_TEX(i.uv0, _Basetex));
                float node_7035 = step(dot(_Basetex_var.rgb,float3(0.3,0.59,0.11)),i.vertexColor.a);
                clip(node_7035 - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
