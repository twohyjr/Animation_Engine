import simd

protocol sizeable{ }
extension sizeable{
    static var size: Int{
        return MemoryLayout<Self>.size
    }
    
    static var stride: Int{
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int)->Int{
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int)->Int{
        return MemoryLayout<Self>.stride * count
    }
}

extension Float: sizeable { }
extension float2: sizeable { }
extension float3: sizeable { }
extension float4: sizeable { }
extension int3: sizeable { }
extension Int32: sizeable { }
extension UInt16: sizeable { }
extension matrix_float4x4: sizeable { }

struct Vertex: sizeable {
    var position: float3
    var normal: float3
    var jointIndices: int3
    var weights: float3
    var textureCoords: float2
}
