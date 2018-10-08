import simd

class GeometryData {
    
    var vertices: [Vertex] = [ ]
    var indices: [UInt16] = [ ]
    
    init(inputCount: Int, positions: [float3], normals: [float3], textureCoords: [float2], pList: [Int]){
        for i in stride(from: 0, to: pList.count, by: 4) {
            var position = positions[pList[i]]
            let normal = normals[pList[i + 1]]
            let textureCoord = textureCoords[pList[i + 2]]
            position.rotate(axis: X_AXIS, angle: toRadians(-90))
            addVertex(position: position,
                      normal: normal,
                      textureCoords: textureCoord)
        }
    }

    private func addVertex(position: float3 = float3(0),
                          normal: float3 = float3(0),
                          jointIndices: int3 = int3(0),
                          weights: float3 = float3(0),
                          textureCoords: float2 = float2(0)){
        
        vertices.append(Vertex(position: position,
                               normal: normal,
                               jointIndices: jointIndices,
                               weights: weights,
                               textureCoords: textureCoords))
    }
    
    private func addIndex(_ index: UInt16) {
        indices.append(index)
    }
    
    private func addIndexRange(_ indices: [UInt16]){
        self.indices.append(contentsOf: indices)
    }
    
}
