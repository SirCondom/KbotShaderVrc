// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WhiteOaksShaders/Kbot"
{
	Properties
	{
		_Color("Color", Color) = (0,0,0,0)
		_Effect("Effect", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "white" {}
		_Texture2("Texture 2", 2D) = "white" {}
		_Texture4("Texture 4", 2D) = "white" {}
		_Pan("Pan", Vector) = (1,0,1,0)
		_FlashSpeed("Flash Speed", Vector) = (0,0,1,1)
		_Float0("Float 0", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color;
		uniform sampler2D _Effect;
		uniform float4 _FlashSpeed;
		uniform float4 _Pan;
		uniform sampler2D _Texture1;
		uniform sampler2D _Texture2;
		uniform sampler2D _Texture4;
		uniform float _Float0;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TexCoord5 = i.uv_texcoord + float2( 0,0.25 );
			float2 panner6 = ( ( _FlashSpeed.x * _Time.y ) * float2( 1,0 ) + uv_TexCoord5);
			float mulTime8 = _Time.y * _Pan.x;
			float2 temp_cast_0 = (mulTime8).xx;
			float simplePerlin2D7 = snoise( temp_cast_0*2.04 );
			simplePerlin2D7 = simplePerlin2D7*0.5 + 0.5;
			float4 temp_output_9_0 = ( tex2D( _Effect, panner6 ) * simplePerlin2D7 );
			float4 clampResult48 = clamp( temp_output_9_0 , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float2 uv_TexCoord21 = i.uv_texcoord + float2( 0,0.25 );
			float2 panner22 = ( ( _Pan.y * _Time.y ) * float2( 1,0 ) + uv_TexCoord21);
			float mulTime16 = _Time.y * _Pan.x;
			float2 temp_cast_1 = (mulTime16).xx;
			float simplePerlin2D19 = snoise( temp_cast_1*2.04 );
			simplePerlin2D19 = simplePerlin2D19*0.5 + 0.5;
			float4 clampResult49 = clamp( ( tex2D( _Texture1, panner22 ) * simplePerlin2D19 ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float2 uv_TexCoord29 = i.uv_texcoord + float2( 0,0.25 );
			float2 panner30 = ( ( _Pan.z * _Time.y ) * float2( 1,0 ) + uv_TexCoord29);
			float mulTime24 = _Time.y * _Pan.x;
			float2 temp_cast_2 = (mulTime24).xx;
			float simplePerlin2D27 = snoise( temp_cast_2*2.04 );
			simplePerlin2D27 = simplePerlin2D27*0.5 + 0.5;
			float4 clampResult50 = clamp( ( tex2D( _Texture2, panner30 ) * simplePerlin2D27 ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float2 uv_TexCoord45 = i.uv_texcoord + float2( 0,0.25 );
			float2 panner46 = ( ( _FlashSpeed.y * _Time.y ) * float2( 1,0 ) + uv_TexCoord45);
			float mulTime40 = _Time.y * _Pan.x;
			float2 temp_cast_3 = (mulTime40).xx;
			float simplePerlin2D43 = snoise( temp_cast_3*2.04 );
			simplePerlin2D43 = simplePerlin2D43*0.5 + 0.5;
			float4 clampResult52 = clamp( ( tex2D( _Texture4, panner46 ) * simplePerlin2D43 ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float4 lighting56 = ( _Color * ( clampResult48 + clampResult49 + clampResult50 + clampResult52 + temp_output_9_0 ) );
			o.Emission = lighting56.rgb;
			o.Alpha = _Float0;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18933
68;188;1311;684;2306.204;355.4442;2.505047;True;True
Node;AmplifyShaderEditor.SimpleTimeNode;14;-3508.914,3270.677;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;11;-3511.215,3105.643;Inherit;False;Property;_FlashSpeed;Flash Speed;7;0;Create;True;0;0;0;False;0;False;0,0,1,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;10;-3507.492,2952.274;Inherit;False;Property;_Pan;Pan;6;0;Create;True;0;0;0;False;0;False;1,0,1,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1914.496,5797.433;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1980.51,1054.037;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-2161.919,553.3478;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0.25;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1908.081,3317.556;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-2077.773,1542.55;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0.25;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;45;-2095.905,5296.743;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0.25;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-2089.49,2816.866;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0.25;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1999.52,2142.574;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;6;-1910.84,558.1636;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;8;-2138.139,856.1212;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;24;-2065.71,3119.64;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;2;-1916.433,229.7735;Inherit;True;Property;_Effect;Effect;1;0;Create;True;0;0;0;False;0;False;d768914247e1fa34691e7e746d7345e9;d768914247e1fa34691e7e746d7345e9;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.PannerNode;22;-1929.85,1646.7;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;16;-2073.096,1883.529;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;40;-2072.125,5599.517;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;20;-1935.443,1318.31;Inherit;True;Property;_Texture1;Texture 1;2;0;Create;True;0;0;0;False;0;False;d768914247e1fa34691e7e746d7345e9;d768914247e1fa34691e7e746d7345e9;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.PannerNode;46;-1844.826,5301.559;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;30;-1838.411,2821.682;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;28;-1844.004,2493.292;Inherit;True;Property;_Texture2;Texture 2;3;0;Create;True;0;0;0;False;0;False;d768914247e1fa34691e7e746d7345e9;d768914247e1fa34691e7e746d7345e9;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;44;-1850.419,4973.169;Inherit;True;Property;_Texture4;Texture 4;5;0;Create;True;0;0;0;False;0;False;d768914247e1fa34691e7e746d7345e9;d768914247e1fa34691e7e746d7345e9;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;4;-1635.141,380.9601;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;19;-1831.171,1906.684;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;2.04;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;43;-1746.147,5561.542;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;2.04;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;7;-1812.161,818.1467;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;2.04;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-1654.151,1469.497;Inherit;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;27;-1739.732,3081.665;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;2.04;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;-1569.127,5124.355;Inherit;True;Property;_TextureSample4;Texture Sample 4;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-1562.712,2644.479;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-1260.847,1684.235;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1169.408,2859.217;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1241.837,595.6982;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1175.823,5339.094;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;48;-844.8917,2400.641;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;49;-848.6238,2690.734;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;52;-847.565,3120.484;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;50;-833.4302,2846.681;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1;-814.5208,-116.1116;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;53;-739.4763,416.3053;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-519.3819,349.3215;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-515.4552,191.3404;Inherit;False;lighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;32;-2093.659,4493.835;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;35;-1767.681,4455.861;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;2.04;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;38;-1866.36,4195.878;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;51;-833.7014,2974.787;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-430.9853,248.5529;Inherit;False;Property;_Float0;Float 0;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;33;-1590.661,4018.675;Inherit;True;Property;_TextureSample3;Texture Sample 3;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-1197.357,4233.413;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-1936.03,4691.751;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;-241.9722,22.44681;Inherit;False;56;lighting;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;36;-1871.953,3867.488;Inherit;True;Property;_Texture3;Texture 3;4;0;Create;True;0;0;0;False;0;False;d768914247e1fa34691e7e746d7345e9;d768914247e1fa34691e7e746d7345e9;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-2117.439,4191.062;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0.25;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;WhiteOaksShaders/Kbot;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;47;0;11;2
WireConnection;47;1;14;0
WireConnection;13;0;11;1
WireConnection;13;1;14;0
WireConnection;31;0;10;3
WireConnection;31;1;14;0
WireConnection;23;0;10;2
WireConnection;23;1;14;0
WireConnection;6;0;5;0
WireConnection;6;1;13;0
WireConnection;8;0;10;1
WireConnection;24;0;10;1
WireConnection;22;0;21;0
WireConnection;22;1;23;0
WireConnection;16;0;10;1
WireConnection;40;0;10;1
WireConnection;46;0;45;0
WireConnection;46;1;47;0
WireConnection;30;0;29;0
WireConnection;30;1;31;0
WireConnection;4;0;2;0
WireConnection;4;1;6;0
WireConnection;19;0;16;0
WireConnection;43;0;40;0
WireConnection;7;0;8;0
WireConnection;17;0;20;0
WireConnection;17;1;22;0
WireConnection;27;0;24;0
WireConnection;41;0;44;0
WireConnection;41;1;46;0
WireConnection;25;0;28;0
WireConnection;25;1;30;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;9;0;4;0
WireConnection;9;1;7;0
WireConnection;42;0;41;0
WireConnection;42;1;43;0
WireConnection;48;0;9;0
WireConnection;49;0;18;0
WireConnection;52;0;42;0
WireConnection;50;0;26;0
WireConnection;53;0;48;0
WireConnection;53;1;49;0
WireConnection;53;2;50;0
WireConnection;53;3;52;0
WireConnection;53;4;9;0
WireConnection;54;0;1;0
WireConnection;54;1;53;0
WireConnection;56;0;54;0
WireConnection;32;0;10;1
WireConnection;35;0;32;0
WireConnection;38;0;37;0
WireConnection;38;1;39;0
WireConnection;51;0;34;0
WireConnection;33;0;36;0
WireConnection;33;1;38;0
WireConnection;34;0;33;0
WireConnection;34;1;35;0
WireConnection;39;0;10;4
WireConnection;39;1;14;0
WireConnection;0;2;57;0
WireConnection;0;9;59;0
ASEEND*/
//CHKSM=743A1241350A37BB8ABA7685256A66E85D076617