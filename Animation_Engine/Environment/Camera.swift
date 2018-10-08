import simd

class Camera {

    var projectionMatrix: matrix_float4x4 {
        return matrix_identity_float4x4
    }
    
    var viewMatrix: matrix_float4x4 {
        return matrix_identity_float4x4
    }
    
    func updateSceneConstants(_ sceneConstants: inout SceneConstants){
        sceneConstants.viewMatrix = viewMatrix
        sceneConstants.projectionMatrix = projectionMatrix
    }
    
}
