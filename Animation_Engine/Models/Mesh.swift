import MetalKit

class Mesh {
    
    private var vertices: [Vertex]!
    private var vertexBuffer: MTLBuffer!
    private var vertexCount: Int{ return vertices.count }
    private var indices: [UInt16]!
    private var indexBuffer: MTLBuffer!
    private var indexCount: Int{ return indices.count }
    
    public init(vertices: [Vertex], indices: [UInt16]) {
        self.vertices = vertices
        self.indices = indices
        generateBuffers()
    }
    
    private func generateBuffers(){
        vertexBuffer = Engine.Device.makeBuffer(bytes: self.vertices, length: Vertex.stride(vertexCount), options: [])
        if(indexCount > 0){
            indexBuffer = Engine.Device.makeBuffer(bytes: self.indices, length: UInt16.stride(indexCount), options: [])
        }
    }
    
    public func draw(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        if(indexCount > 0){
            renderCommandEncoder.drawIndexedPrimitives(type: .triangle,
                                                       indexCount: indexCount,
                                                       indexType: .uint16,
                                                       indexBuffer: indexBuffer,
                                                       indexBufferOffset: 0)
        }else {
            renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
        }
        
    }
    
}
