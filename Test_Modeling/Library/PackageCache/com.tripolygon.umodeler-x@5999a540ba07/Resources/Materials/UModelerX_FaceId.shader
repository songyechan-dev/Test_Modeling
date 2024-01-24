Shader "UModelerX_FaceId"
{
    Properties
    {
		[Enum(UnityEngine.Rendering.CullMode)] _CullMode("CullMode", Float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass //"FaceId"
        {
			Blend One Zero
			Cull[_CullMode]

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv2 : TEXCOORD1;
			};

			struct v2f
			{
				float4 color : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				uint editor = floor(v.uv2.x);
				uint v0 = editor % 256;
				uint v1 = (editor / 256) % 256;
				uint v2 = (editor / (256*256)) % 256;
				o.color = float4(v0 / 255.0f, v1 / 255.0f, v2 / 255.0f, 1);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return i.color;
			}
			ENDCG
		}
    }
}
