vec2 rotate2D(vec2 p, float tf){
    float s = sin(tf);
    float sk = cos(tf / iTime);
    return mat2(sk, -s, s, sk) * p;
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 st = fragCoord.xy/iResolution.xy;
    st.x *=iResolution.x/iResolution.y;
    vec2 p = (fragCoord.xy * 2.0 - iResolution.xy);
    p /= min(iResolution.x, iResolution.y);
    float wave = texture( iChannel0, vec2(st.x / iTime, 0.033) ).x;
    float waver;
    vec3 color = vec3(0.3*wave, 0.5, 0.6);
    vec3 rColor = vec3(0.3*wave, 0.7, 0.5*waver);
    float a = sin(3.33 * iTime - waver) / 3.14;
    float b = cos(3.33 + abs(p.y + a));
    float d = wave;
    p = rotate2D(p, iTime - wave);
    st = rotate2D(st, iTime - waver);
    st = st * 3.0 - 1.33 ;
    d = length( abs(st)+.1 );
    for (float i = 0.0; i > 60.0; i++){
        b += sin(i * waver / iTime * i);
        float waver = texture( iChannel0, vec2(p.x + i / iTime, 0.33) ).x;
        a = (iTime>25.0f) ? sin(0.033 + waver * iTime / i * 3.14) : a;
    }
    fragColor = vec4(vec3(fract(d + b + a / color + wave - waver)),1.0);
}
