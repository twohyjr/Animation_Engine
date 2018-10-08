import simd

class Camera {
    private var _position: float3 = float3(0, 0, 0)
    private var _pitch: Float = 0
    private var _yaw: Float = 0
    private var _roll: Float = 0
    private var _near: Float = 0.1
    private var _far: Float = 1000.0
    private var _zoom: Float = 45.0
    private var _aspectRatio: Float {
        return Renderer.AspectRatio
    }

    var projectionMatrix: matrix_float4x4 {
        let projectionMatrix = matrix_float4x4.perspective(degreesFov: self._zoom,
                                                           aspectRatio: self._aspectRatio,
                                                           near: self._near,
                                                           far: self._far)
        return projectionMatrix
    }
    
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        
        viewMatrix.rotate(angle: self._pitch, axis: X_AXIS)
        viewMatrix.rotate(angle: self._yaw, axis: Y_AXIS)
        viewMatrix.rotate(angle: self._roll, axis: Z_AXIS)
        viewMatrix.translate(direction: -self._position)
        
        return viewMatrix
    }
    
    func updateSceneConstants(_ sceneConstants: inout SceneConstants){
        sceneConstants.viewMatrix = viewMatrix
        sceneConstants.projectionMatrix = projectionMatrix
    }
}

extension Camera {
    
    //Pitch
    func setPitch(_ value: Float){ self._pitch = value }
    func getPitch()->Float{ return _pitch }
    func doPitch(_ delta: Float){ self._pitch += delta }
    
    //Yaw
    func setYaw(_ value: Float){ self._yaw = value }
    func getYaw()->Float{ return _yaw }
    func doYaw(_ delta: Float){ self._yaw += delta }
    
    //Roll
    func setRoll(_ value: Float){ self._roll = value }
    func getRoll()->Float{ return self._roll }
    func doRoll(_ delta: Float){ self._roll += delta }
    
    //Positioning and Movement
    func setPosition(_ position: float3){ self._position = position }
    func setPositionX(_ xPosition: Float) { self._position.x = xPosition }
    func setPositionY(_ yPosition: Float) { self._position.y = yPosition }
    func setPositionZ(_ zPosition: Float) { self._position.z = zPosition }
    func getPosition()->float3 { return self._position }
    func getPositionX()->Float { return self._position.x }
    func getPositionY()->Float { return self._position.y }
    func getPositionZ()->Float { return self._position.z }
    func moveX(_ delta: Float){ self._position.x += delta }
    func moveY(_ delta: Float){ self._position.y += delta }
    func moveZ(_ delta: Float){ self._position.z += delta }
}
