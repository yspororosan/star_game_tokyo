Shader "Custom/test"
{
	Properties
	{
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
		_RotateSpeed("Rotate Speed", float) = 1.0
		_Tiling("Tiling", float) = 1.0
	}
		SubShader
		{
			Tags { "Queue" = "Transparent" }

			Pass
			{
				CGPROGRAM
			   #pragma vertex vert
			   #pragma fragment frag
			   #include "UnityCG.cginc"

			   #define PI 3.141592

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				sampler2D   _MainTex;
				float4      _MainTex_ST;
				float      _RotateSpeed;
				float      _Tiling;

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = v.uv;
					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					// Timeを入力として現在の回転角度を作る
					half angle = frac(_Time.x) * PI * 2;
					// 回転行列を作る
					half angleCos = cos(angle * _RotateSpeed);
					half angleSin = sin(angle * _RotateSpeed);
					half2x2 rotateMatrix = half2x2(angleCos, -angleSin, angleSin, angleCos);
					// タイリング処理
					i.uv = frac(i.uv * _Tiling);
					// 中心を起点にUVを回転させる
					i.uv = mul(i.uv - 0.5, rotateMatrix) + 0.5;

					fixed4 col = tex2D(_MainTex, i.uv);
					return col;
				}

				//fixed4 frag(v2f i) : COLOR
				{
				return col;
				}
				ENDCG
			}
		}
	//Properties{
	//	_MainTex("Texture", 2D) = "white"{}
	//}
	//	SubShader{
	//		Tags { "Queue" = "Transparent" }
	//		LOD 200

	//		CGPROGRAM
	//		#pragma surface surf Standard alpha:fade
	//		#pragma target 3.0

	//		struct Input {
	//			float2 uv_MainTex;
	//			float3 worldPos;
	//		};

	//		sampler2D _MainTex;
	//		float4 _ObjectPosition;

	//		void surf(Input IN, inout SurfaceOutputStandard o) {
	//			float dist = distance(_ObjectPosition, IN.worldPos);
	//			//float val = abs(sin(dist * 3.0 + _Time * 50));

	//			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
	//			o.Albedo = c.rgb;
	//			o.Alpha = (c.r * 0.3 + c.g * 0.6 + c.b * 0.1 < 0.2) ? 0 : 0.4;
	//		}
	//		ENDCG
	//}
	//	FallBack "Diffuse"
}
