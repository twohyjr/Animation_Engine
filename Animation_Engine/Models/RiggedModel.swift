import MetalKit

class RiggedModel {
    
    private var modelConstants = ModelConstants()
    private var mesh: Mesh!
    
    init() {
        mesh = ColladaLoader.loadModelMesh()
    }
    
    public func update(_ deltaTime: Float){
        
    }
    
    public func render(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        mesh.draw(renderCommandEncoder)
    }
    
}
