import simd

class ColladaLoader {
    
    public static func loadModelMesh()->Mesh{
        
        let vertices: [Vertex] = [
            Vertex(position: float3(0, 1, 0),
                   normal: float3(3, 4, 5),
                   jointIndices: int3(6,7,8),
                   weights: float3(9, 10, 11),
                   textureCoords: float2(12,13)),
            
            Vertex(position: float3(-1, -1, 0),
                   normal: float3(3, 4, 5),
                   jointIndices: int3(6,7,8),
                   weights: float3(9, 10, 11),
                   textureCoords: float2(12,13)),
            
            Vertex(position: float3(1, -1, 0),
                    normal: float3(3, 4, 5),
                    jointIndices: int3(6,7,8),
                    weights: float3(9, 10, 11),
                    textureCoords: float2(12,13))
        ]
        
        let indices: [UInt16] = [
            0, 1, 2
        ]
        
        return Mesh(vertices: vertices, indices: indices)
    }
}
