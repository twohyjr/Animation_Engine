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
    float2 textureCoords;
};

vertex RasterizeData animation_vertex_shader(Vertex vertexIn [[ stage_in ]],
                                             constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                             constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizeData rd;
    
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix *  float4(vertexIn.position, 1.0);
    rd.textureCoords = vertexIn.textureCoords;
    
    return rd;
}

fragment half4 animation_fragment_shader(RasterizeData rd [[ stage_in ]],
                                         sampler sampler2d [[ sampler(0) ]],
                                         texture2d<float> texture [[ texture(0) ]]) {
    float4 color = texture.sample(sampler2d, rd.textureCoords);
    
    return half4(color.r, color.g, color.b, color.a) * 1.7;
}

