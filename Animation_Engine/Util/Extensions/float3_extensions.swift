import simd

extension float3 {

    func add(_ val: Float)->float3{
        return self + float3(val)
    }
    
    mutating func zeroInit()->float3 {
        self = float3(0)
        return self
    }
    
    mutating func set(_ val: float3){
        self = val
    }
    
    func sub(_ r: float3)->float3{
        var result = self
        result.x -= r.x
        result.y -= r.y
        result.z -= r.z
        return result
    }
    
    func add(_ r: float3)->float3{
        var result = self
        result.x += r.x
        result.y += r.y
        result.z += r.z
        return result
    }
    
    func mul(_ r: Float)->float3{
        var result = self
        result.x *= r
        result.y *= r
        result.z *= r
        return result
    }
    
    func lerp(dest: float3, lerpFactor: Float)->float3{
        return dest.sub(self).mul(lerpFactor).add(self)
    }
    
    func dot(_ r: float3)->Float{
        return self.x * r.x + self.y * r.y + self.z * r.z
    }
    
    func cross(_ r: float3)->float3{
        let x: Float = self.y * r.z - self.z * r.y
        let y: Float = self.z * r.x - self.x * r.z
        let z: Float = self.x * r.y - self.y * r.x
        return float3(x,y,z)
    }
    
    mutating func rotate(axis: float3, angle: Float) {
        let sinAngle = sin(-angle)
        let cosAngle = cos(-angle)
        
        let var1 = self.cross(axis.mul(sinAngle))
        let var2 = var1.add(self.mul(cosAngle))
        let var3 = var2.add(axis.mul(self.dot(axis.mul(1 - cosAngle))))
        
        self = var3
    }
}
