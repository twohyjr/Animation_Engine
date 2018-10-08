import Foundation
import simd

class ColladaLoader {
    
    public static func loadModelMesh(modelName: String)->Mesh?{
        var geometryData: GeometryData!
        
        let modelXML: XML? = getColladaXMLData(modelName)
        if(modelXML != nil){
            geometryData = getGeometryData(modelXML: modelXML!)
        }else {
            return nil
        }

        return generateMesh(geometryData: geometryData)
    }
    
    private static func generateMesh(geometryData: GeometryData)->Mesh {
        return Mesh(vertices: geometryData.vertices, indices: geometryData.indices)
    }
    
    private static func getGeometryData(modelXML: XML)->GeometryData {
        let geometryNode = modelXML["#library_geometries"].xml!
        let geometryLoader = GeometryLoader(geometryNode: geometryNode)
        return geometryLoader.extractGeometryData()
    }
    
    private static func getColladaXMLData(_ modelName: String)->XML?{
        if let url = Bundle.main.url(forResource: modelName, withExtension: "dae") {
            return XML(url: url)
        }
        return nil
    }
}
