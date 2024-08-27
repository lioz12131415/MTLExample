//
//  MTLBlur.metal
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

#include <metal_stdlib>
using namespace metal;

kernel void mtlblur(texture2d<float, access::read> inputTexture [[texture(0)]],
                    texture2d<float, access::write> outputTexture [[texture(1)]],
                    constant float &intensity [[buffer(0)]],
                    uint2 gid [[thread_position_in_grid]]) {
    
    if (gid.x >= outputTexture.get_width() || gid.y >= outputTexture.get_height()) {
         return;
     }

     float clampedIntensity = clamp(intensity, 0.0, 1.0);
     int offset = int(5.0 * clampedIntensity);

     float4 color = float4(0.0);

     color += inputTexture.read(uint2(gid.x - offset, gid.y - offset));
     color += inputTexture.read(uint2(gid.x, gid.y - offset));
     color += inputTexture.read(uint2(gid.x + offset, gid.y - offset));
     
     color += inputTexture.read(uint2(gid.x - offset, gid.y));
     color += inputTexture.read(uint2(gid.x, gid.y));
     color += inputTexture.read(uint2(gid.x + offset, gid.y));
     
     color += inputTexture.read(uint2(gid.x - offset, gid.y + offset));
     color += inputTexture.read(uint2(gid.x, gid.y + offset));
     color += inputTexture.read(uint2(gid.x + offset, gid.y + offset));

     color /= 9.0;

     outputTexture.write(clamp(color, 0.0, 1.0), gid);
}



