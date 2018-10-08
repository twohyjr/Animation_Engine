import MetalKit

class TextureLoader {
    public static func Load(imageName: String)->MTLTexture!{
        var texture: MTLTexture! = nil
        if(imageName != ""){
            let textureLoader = MTKTextureLoader(device: Engine.Device)
            let url = Bundle.main.url(forResource: imageName, withExtension: nil)
            
            //Put options on the image here
            let originOption = [MTKTextureLoader.Option.origin:MTKTextureLoader.Origin.bottomLeft]
            
            do{
                texture = try textureLoader.newTexture(URL: url!, options: originOption)
            }catch let textureLoadError as NSError{
                print("ERROR::TEXTURE_LOADING::\(textureLoadError)")
            }
        }
        return texture
    }
}

