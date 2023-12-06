vec2 rotate2D(vec2 p, float tf){
    float s = sin(tf / iTime);
    float sk = cos(tf);
    return mat2(sk, -s, s, sk) * p;
}
vec2 rotate2D2(vec2 p, float tf){
    float s = sin(tf);
    float sk = cos(tf / iTime);
    return mat2(sk, -s, s, sk) * p;
}
float lerp(float start, float end, float amt){
    return (1.0 - amt) * start + amt * end;
}
void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 p = (fragCoord.xy * 2.0 - iResolution.xy);
    p /= min(iResolution.x, iResolution.y);
    vec2 newp = (fragCoord.xy * 2.0 - iResolution.xy);
    newp /= min(iResolution.x, iResolution.y);
    newp = rotate2D(newp, iTime);
    p = rotate2D2(p, iTime);
    float dec, before, cords, bliss;
    float ylerp = lerp(p.y, newp.y, iTime);
    float xlerp = lerp(p.x, newp.x, 3.14);
    vec3 rColor = vec3(-0.7, -0.3, -0.3);
    vec3 bColor = vec3(0.1, 0.2, 0.8);
    vec3 gColor = vec3(0.3, 0.9, 0.1);
    for(float i=0.0; i < 33.0; i++){
        xlerp = lerp(p.x, newp.x, i * iTime);
        ylerp = lerp(p.y, newp.y, i * iTime);
        dec += cos(xlerp * ylerp * iTime + 3.14 + i * ylerp + 0.033);
        before += sin(dec * ylerp * p.y * p.y * iTime + newp.y * newp.y);
        cords += sin(dec + 3.00 * p.x * p.y * iTime + newp.y * newp.y);
        bliss += cos(dec + xlerp * p.y * p.x * iTime + newp.x * newp.y * ylerp);
    }
    vec3 interesting = rColor * before + bColor * cords;
    vec3 blister = gColor * bliss;
    fragColor = vec4(interesting + blister, 0.4);
}
