//
//  MTLVignette.metal
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

#include <metal_stdlib>
using namespace metal;

kernel void mtlvignette(texture2d<float, access::read> inputTexture [[texture(0)]],
                        texture2d<float, access::write> outputTexture [[texture(1)]],
                        constant float &radius [[buffer(0)]],
                        constant float &intensity [[buffer(1)]],
                        uint2 gid [[thread_position_in_grid]]) {

    if (gid.x >= outputTexture.get_width() || gid.y >= outputTexture.get_height()) {
        return;
    }

    float clampedIntensity = clamp(intensity, 0.0, 1.0);

    float2 uv = float2(gid) / float2(outputTexture.get_width(), outputTexture.get_height());
    float2 center = float2(0.5, 0.5);
    
    float rad = 1.0-radius;
    float dist = distance(uv, center);
    float vignette = smoothstep(rad/2, rad, dist);

    vignette = mix(1.0, 1.0 - vignette, clampedIntensity);

    float4 color = inputTexture.read(gid);
    color.rgb *= vignette;

    outputTexture.write(clamp(color, 0.0, 1.0), gid);
}


