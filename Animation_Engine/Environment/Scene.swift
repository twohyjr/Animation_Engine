import MetalKit

class Scene {
    
    private var sceneConstants = SceneConstants()
    private var camera = Camera()
    
    private var riggedModel: RiggedModel!
    
    public init() {
        createScene()
    }
    
    public func createScene() {
        //Add model to scene
        riggedModel = RiggedModel(modelName: "Cowboy", textureName: "CobowyTexture.png")
        riggedModel.setPositionY(-4)

        camera.setPositionZ(14)
    }
    
    public func update(_ deltaTime: Float){
        self.sceneConstants.viewMatrix = camera.viewMatrix
        self.sceneConstants.projectionMatrix = camera.projectionMatrix
        
        self.riggedModel.rotateY(deltaTime)
        
        self.riggedModel.update(deltaTime)
    }
    
    public func render(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        
        self.riggedModel.render(renderCommandEncoder)
    }
    
}
