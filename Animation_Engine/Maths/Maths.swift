import simd

public var X_AXIS: float3{
    return float3(1,0,0)
}

public var Y_AXIS: float3{
    return float3(0,1,0)
}

public var Z_AXIS: float3{
    return float3(0,0,1)
}

public func toRadians(_ degrees: Float)->Float{
    return (degrees / 180) * Float.pi
}

public func toDegrees(_ radians: Float) -> Float{
    return radians * (180 / Float.pi)
}

func randomBounded(lowerBound: Int, upperBound: Int) -> Int {
    return lowerBound + Int(arc4random_uniform(UInt32(upperBound - lowerBound)))
}

func barryCentric(_ p1: float3,_ p2: float3,_ p3: float3,_ pos: float2)->Float{
    let det = (p2.z - p3.z) * (p1.x - p3.x) + (p3.x - p2.x) * (p1.z - p3.z);
    let l1 = ((p2.z - p3.z) * (pos.x - p3.x) + (p3.x - p2.x) * (pos.y - p3.z)) / det;
    let l2 = ((p3.z - p1.z) * (pos.x - p3.x) + (p1.x - p3.x) * (pos.y - p3.z)) / det;
    let l3 = 1.0 - l1 - l2;
    return l1 * p1.y + l2 * p2.y + l3 * p3.y;
}


extension matrix_float4x4{
    
    init(orthographicLeft left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) {
        
        self.init()
        
        columns = (
            float4(2 / (right - left), 0, 0, 0),
            float4(0, 2 / (top - bottom), 0, 0),
            float4(0, 0, 1 / (far - near), 0),
            float4((left + right) / (left - right), (top + bottom) / (bottom - top), near / (near - far), 1)
        )
        
    }
    
    //https://gamedev.stackexchange.com/questions/120338/what-does-a-perspective-projection-matrix-look-like-in-opengl
    static func perspective(degreesFov: Float, aspectRatio: Float, near: Float, far: Float)->matrix_float4x4{
        let fov = toRadians(degreesFov)
        
        let t: Float = tan(fov / 2)
        
        let x: Float = 1 / (aspectRatio * t)
        let y: Float = 1 / t
        let z: Float = -((far + near) / (far - near))
        let w: Float = -((2 * far * near) / (far - near))
        
        var result = matrix_identity_float4x4
        result.columns = (
            float4(x,  0,  0,   0),
            float4(0,  y,  0,   0),
            float4(0,  0,  z,  -1),
            float4(0,  0,  w,   0)
        )
        return result
    }
    
    mutating func translate(direction: float3){
        var result = matrix_identity_float4x4
        
        let x: Float = direction.x
        let y: Float = direction.y
        let z: Float = direction.z
        
        result.columns = (
            float4(1,0,0,0),
            float4(0,1,0,0),
            float4(0,0,1,0),
            float4(x,y,z,1)
        )
        
        self = matrix_multiply(self, result)
    }
    
    mutating func scale(axis: float3){
        var result = matrix_identity_float4x4
        
        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z
        
        result.columns = (
            float4(x,0,0,0),
            float4(0,y,0,0),
            float4(0,0,z,0),
            float4(0,0,0,1)
        )
        
        self = matrix_multiply(self, result)
    }
    
    mutating func rotate(angle: Float, axis: float3){
        var result = matrix_identity_float4x4
        
        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z
        
        let c: Float = cos(angle)
        let s: Float = sin(angle)
        
        let mc: Float = (1 - c)
        
        let r1c1: Float = x * x * mc + c
        let r2c1: Float = x * y * mc + z * s
        let r3c1: Float = x * z * mc - y * s
        let r4c1: Float = 0.0
        
        let r1c2: Float = y * x * mc - z * s
        let r2c2: Float = y * y * mc + c
        let r3c2: Float = y * z * mc + x * s
        let r4c2: Float = 0.0
        
        let r1c3: Float = z * x * mc + y * s
        let r2c3: Float = z * y * mc - x * s
        let r3c3: Float = z * z * mc + c
        let r4c3: Float = 0.0
        
        let r1c4: Float = 0.0
        let r2c4: Float = 0.0
        let r3c4: Float = 0.0
        let r4c4: Float = 1.0
        
        result.columns = (
            float4(r1c1, r2c1, r3c1, r4c1),
            float4(r1c2, r2c2, r3c2, r4c2),
            float4(r1c3, r2c3, r3c3, r4c3),
            float4(r1c4, r2c4, r3c4, r4c4)
        )
        
        self = matrix_multiply(self, result)
    }
    
    var upperLeftMatrix: matrix_float3x3 {
        return matrix_float3x3(columns: (
            float3(columns.0.x, columns.0.y, columns.0.z),
            float3(columns.1.x, columns.1.y, columns.1.z),
            float3(columns.2.x, columns.2.y, columns.2.z)
        ))
    }
}

extension matrix_float4x4 {
    var m00: Float { return self[0][0] }
    var m01: Float { return self[0][1] }
    var m02: Float { return self[0][2] }
    var m03: Float { return self[0][3] }
    
    var m10: Float { return self[1][0] }
    var m11: Float { return self[1][1] }
    var m12: Float { return self[1][2] }
    var m13: Float { return self[1][3] }
    
    var m20: Float { return self[2][0] }
    var m21: Float { return self[2][1] }
    var m22: Float { return self[2][2] }
    var m23: Float { return self[2][3] }
    
    var m30: Float { return self[3][0] }
    var m31: Float { return self[3][1] }
    var m32: Float { return self[3][2] }
    var m33: Float { return self[3][3] }
}

extension Int {
    static postfix func ++(_ left: inout Int)->Int{
        left += 1
        return left - 1
    }
    
    static postfix func --(_ left: inout Int)->Int{
        left -= 1
        return left + 1
    }
}
