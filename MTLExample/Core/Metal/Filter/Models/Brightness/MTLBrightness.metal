//
//  MTLBrightness.metal
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

#include <metal_stdlib>
using namespace metal;

kernel void mtlbrightness(texture2d<half, access::read> inputTexture [[texture(0)]],
                          texture2d<half, access::write> outputTexture [[texture(1)]],
                          constant float &brightness [[buffer(0)]],
                          uint2 gid [[thread_position_in_grid]]) {
    
    if ((gid.x >= outputTexture.get_width()) || (gid.y >= outputTexture.get_height())) {
        return;
    }
    
    float adjustedBrightness = (brightness/2.0);

    const half4 inColor = inputTexture.read(gid);
    const half4 outColor(inColor.rgb + half3(adjustedBrightness), inColor.a);
    outputTexture.write(outColor, gid);
}


