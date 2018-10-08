import simd

class GeometryLoader {
    
    var geometryNode: XML!
    var meshData: XML {
        return geometryNode["#geometry.mesh"].xml!
    }
    
    init(geometryNode: XML){
        self.geometryNode = geometryNode
    }
    
    public func extractGeometryData()->GeometryData{
        let inputCount = getInputCount()
        let positions = loadPositions()
        let normals = loadNormals()
        let textureCoordinates = loadTextureCoordinates()
        let pList = loadPList()
        

        return GeometryData(inputCount: inputCount,
                            positions: positions,
                            normals: normals,
                            textureCoords: textureCoordinates,
                            pList: pList)
    }
    
    private func getInputCount()->Int {
        return Array(meshData["#polylist.input"]).count
    }
    
    private func loadPositions()->[float3] {
        let positionsId = meshData["#vertices.input.@source"].string!.dropHash
        let positionsData = meshData.getChildWithAttributes(childName: "source", attr: "id", value: positionsId)["#float_array"]
        return positionsData.string!.toFloat3Array()
    }
    
    private func loadNormals()->[float3] {
        let normalsId = meshData["#polylist"].xml!.getChildWithAttributes(childName: "input",
                                                                          attr: "semantic",
                                                                          value: "NORMAL")["@source"].string!.dropHash
        let normalsData = meshData.getChildWithAttributes(childName: "source", attr: "id", value: normalsId)["#float_array"].xml!
        return normalsData.string!.toFloat3Array()
    }
    
    private func loadTextureCoordinates()->[float2] {
        let texCoordsId = meshData["#polylist"].xml!.getChildWithAttributes(childName: "input", attr: "semantic", value: "TEXCOORD")["@source"].string!.dropHash
        let texCoordsData = meshData.getChildWithAttributes(childName: "source", attr: "id", value: texCoordsId)["#float_array"].xml!
        return texCoordsData.string!.toFloat2Array()
    }
    
    private func loadPList()->[Int] {
        return meshData["#polylist.p"].string!.toIntArray()
    }

}
