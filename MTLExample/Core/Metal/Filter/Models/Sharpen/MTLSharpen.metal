//
//  MTLSharpen.metal
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

#include <metal_stdlib>
using namespace metal;

kernel void mtlsharpen(texture2d<float, access::read> inputTexture [[texture(0)]],
                       texture2d<float, access::write> outputTexture [[texture(1)]],
                       constant float &intensity [[buffer(0)]],
                       uint2 gid [[thread_position_in_grid]]) {
    
    if (gid.x >= outputTexture.get_width() || gid.y >= outputTexture.get_height()) {
        return;
    }
    
    float clampedIntensity = clamp(intensity, 0.0, 1.0);
    
    float4 centerPixel = inputTexture.read(gid);
    float4 leftPixel = inputTexture.read(uint2(gid.x - 1, gid.y));
    float4 rightPixel = inputTexture.read(uint2(gid.x + 1, gid.y));
    float4 topPixel = inputTexture.read(uint2(gid.x, gid.y - 1));
    float4 bottomPixel = inputTexture.read(uint2(gid.x, gid.y + 1));
    
    float4 surroundingAvg = (leftPixel + rightPixel + topPixel + bottomPixel) * 0.25;
    
    float4 detail = centerPixel - surroundingAvg;
    
    float4 enhancedDetail = detail * (1.0 + 4.0 * clampedIntensity);
    
    float4 sharpenedColor = centerPixel + enhancedDetail;
    
    outputTexture.write(clamp(sharpenedColor, 0.0, 1.0), gid);
}


