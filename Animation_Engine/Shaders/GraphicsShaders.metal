#include <metal_stdlib>
using namespace metal;


struct Vertex {
    float3 position [[ attribute(0) ]];
    float3 normal [[ attribute(1) ]];
    int3 jointIndices [[ attribute(2) ]];
    float3 weights [[ attribute(3) ]];
    float2 textureCoords [[ attribute(4) ]];
};

struct ModelConstants {
    float4x4 modelMatrix;
};

struct SceneConstants {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

struct RasterizeData {
    float4 position [[ position ]];
};

vertex RasterizeData animation_vertex_shader(Vertex vertexIn [[ stage_in ]]) {
    RasterizeData rd;

    return rd;
}

fragment half4 animation_fragment_shader(RasterizeData rd [[ stage_in ]]) {
    float4 color = float4(0.6, 0.3, 0.1, 1.0);
    
    return half4(color.r, color.g, color.b, color.a);
}

