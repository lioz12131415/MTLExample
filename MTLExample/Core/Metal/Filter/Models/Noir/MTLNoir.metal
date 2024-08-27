//
//  MTLNoir.metal
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

#include <metal_stdlib>
using namespace metal;

kernel void mtlnoir(texture2d<float, access::read> inputTexture [[texture(0)]],
                    texture2d<float, access::write> outputTexture [[texture(1)]],
                    constant float &intensity [[buffer(0)]],
                    uint2 gid [[thread_position_in_grid]]) {
    
    if (gid.x >= outputTexture.get_width() || gid.y >= outputTexture.get_height()) {
        return;
    }
    
    float4 color = inputTexture.read(gid);
    
    
    float luminance = dot(color.rgb, float3(0.299, 0.587, 0.114));
    float contrast = (luminance - 0.5) * 2.0 + 0.5;
    
    contrast = clamp(contrast, 0.0, 1.0);
    
    float4 noirColor = float4(contrast, contrast, contrast, color.a);
    float4 finalColor = mix(color, noirColor, intensity);
    
    outputTexture.write(finalColor, gid);
}


