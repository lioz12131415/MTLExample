//
//  MTLQuantization.metal
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

#include <metal_stdlib>
using namespace metal;

kernel void mtlquantization(texture2d<float, access::read> inputTexture [[texture(0)]],
                            texture2d<float, access::write> outputTexture [[texture(1)]],
                            constant float &numColors [[buffer(0)]],
                            uint2 gid [[thread_position_in_grid]]) {
    
    if (gid.x >= outputTexture.get_width() || gid.y >= outputTexture.get_height()) {
        return;
    }
    
    float levels = 10.0 - numColors * 8.6;
    
    float4 color = inputTexture.read(gid);
    
    float3 quantizedColor = floor(color.rgb * levels + 0.5) / levels;
    
    outputTexture.write(float4(quantizedColor, color.a), gid);
}


