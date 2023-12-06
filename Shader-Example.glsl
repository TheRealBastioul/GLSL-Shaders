vec2 rotate2D(vec2 p, float tf){
    float s = sin(tf);
    float sk = cos(tf / iTime);
    return mat2(sk, -s, s, sk) * p;
}
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 p = (fragCoord.xy * 2.0 - iResolution.xy);
    p /= min(iResolution.x, iResolution.y);
    float fft = texture( iChannel0, vec2(p.x, 3.33) ).x;
    float wave = texture( iChannel0, vec2(p.x, 1.0) ).x;
    vec3 rColor = vec3(0.7*fft, 0.1*fft, 0.8*fft);
    vec3 gColor = vec3(0.0, 1.8*wave, 1.3*fft);
    vec3 bColor = vec3(0.0, 1.3*fft, 1.8/fft);
    vec3 yColor = vec3(0.7*fft, 1.8*wave, 0.3);
    float a;
    float b;
    float c;
    float d;
    float e;
    float f;
    float g;
    float h;
    p = rotate2D(p, iTime);
    for(float i = 0.0; i < 32.0; i++){
        float factor = (sin(iTime) * 0.33 + 0.33) + 1.33;
        i += factor;
        float tf = i / 3.0;
        a = sin(p.y * 3.33 - iTime * 6.66) / tf;
        e = 0.01 / abs(p.x + a);
        b = sin(p.y * 3.33 - iTime * 3.33) / tf;
        f = 0.01 / abs(p.x + b);
        c = sin(p.y * 6.66 - iTime * 8.88) / tf;
        g = 0.01 / abs(p.x + c);
        d = sin(p.y * 1.11 - iTime * 8.22) / tf;
        h = 0.01 / abs(p.x + d);
        yColor += 0.33 - smoothstep(0.33, 0.10, abs(wave - p.y / tf) );
    }
    vec3 destColor = rColor * e + gColor * f + bColor * g + yColor * h;
    fragColor = vec4(destColor, 1.0);
}
