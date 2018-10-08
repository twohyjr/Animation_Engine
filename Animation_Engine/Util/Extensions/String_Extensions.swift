import Foundation
import simd

extension String {
    
    static var Empty: String {
        return ""
    }
    
    func toFloat2Array()->[float2]{
        var result = [float2]()
        
        let pointArray: [Float] = self.split(separator: Character(" ")).map { Float($0) ?? 0.0 }
        var offset: Int = 0
        while(offset < pointArray.count) {
            result.append(float2(pointArray[offset], pointArray[offset + 1]))
            offset += 2
        }
        
        return result
    }
    
    func toFloat3Array()->[float3]{
        var result = [float3]()
        
        let pointArray: [Float] = self.split(separator: Character(" ")).map { Float($0) ?? 0.0 }
        var offset: Int = 0
        while(offset < pointArray.count) {
            result.append(float3(pointArray[offset], pointArray[offset + 1], pointArray[offset + 2]))
            offset += 3
        }
        
        return result
    }
    
    func toFloat4Array()->[float4]{
        var result = [float4]()
        
        let pointArray: [Float] = self.split(separator: Character(" ")).map { Float($0) ?? 0.0 }
        var offset: Int = 0
        while(offset < pointArray.count) {
            result.append(float4(pointArray[offset], pointArray[offset + 1], pointArray[offset + 2], pointArray[offset + 3]))
            offset += 4
        }
        
        return result
    }
    
    func toFloat4ArrayFromStride3()->[float4]{
        var result = [float4]()
        
        let pointArray: [Float] = self.split(separator: Character(" ")).map { Float($0) ?? 0.0 }
        var offset: Int = 0
        while(offset < pointArray.count) {
            result.append(float4(pointArray[offset], pointArray[offset + 1], pointArray[offset + 2], 1.0))
            offset += 3
        }
        
        return result
    }
    
    func toIntArray()->[Int]{
        var result = [Int]()
        
        let pointArray: [Int] = self.split(separator: Character(" ")).map { Int($0) ?? 0 }
        for var i in 0..<pointArray.count {
            result.append(Int(pointArray[i++]))
        }
        
        return result
        
    }
    
    func toFloatArray()->[Float]{
        var result = [Float]()
        
        let pointArray: [Float] = self.split(separator: Character(" ")).map { Float($0)! }
        for var i in 0..<pointArray.count {
            result.append(Float(pointArray[i++]))
        }
        
        return result
        
    }
    
    func convertToMatrix4x4()->matrix_float4x4{
        var result = matrix_identity_float4x4
        
        let floatArray = self.toFloatArray()
        if(floatArray.count == 16){
            result.columns.0.x = floatArray[0]
            result.columns.0.y = floatArray[4]
            result.columns.0.z = floatArray[8]
            result.columns.0.w = floatArray[12]
            
            result.columns.1.x = floatArray[1]
            result.columns.1.y = floatArray[5]
            result.columns.1.z = floatArray[9]
            result.columns.1.w = floatArray[13]
            
            result.columns.2.x = floatArray[2]
            result.columns.2.y = floatArray[6]
            result.columns.2.z = floatArray[10]
            result.columns.2.w = floatArray[14]
            
            result.columns.3.x = floatArray[3]
            result.columns.3.y = floatArray[7]
            result.columns.3.z = floatArray[11]
            result.columns.3.w = floatArray[15]
            
        }
        
        return result
    }
    
    func convertToMatrix4x4Array()->[matrix_float4x4]{
        var result: [matrix_float4x4] = []
        
        let floatArray = self.toFloatArray()
        let sequence = stride(from: 0, to: floatArray.count, by: 16)
        
        for element in sequence {
            var value = matrix_identity_float4x4
            value.columns.0.x = floatArray[0  + element]
            value.columns.0.y = floatArray[4  + element]
            value.columns.0.z = floatArray[8  + element]
            value.columns.0.w = floatArray[12 + element]
            
            value.columns.1.x = floatArray[1  + element]
            value.columns.1.y = floatArray[5  + element]
            value.columns.1.z = floatArray[9  + element]
            value.columns.1.w = floatArray[13 + element]
            
            value.columns.2.x = floatArray[2  + element]
            value.columns.2.y = floatArray[6  + element]
            value.columns.2.z = floatArray[10 + element]
            value.columns.2.w = floatArray[14 + element]
            
            value.columns.3.x = floatArray[3  + element]
            value.columns.3.y = floatArray[7  + element]
            value.columns.3.z = floatArray[11 + element]
            value.columns.3.w = floatArray[15 + element]
            result.append(matrix_identity_float4x4)
        }
        
        return result
    }
    
    func toStringArray()->[String]{
        return self.split(separator: Character(" ")).map { String($0) }
        
    }
    
    var dropHash: String {
        return self.replacingOccurrences(of: "#", with: "")
    }
    
}
