import MetalKit

class GraphicsView: MTKView {
    
    var renderer: Renderer!
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        self.clearColor = MTLClearColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1.0)
        
        self.colorPixelFormat = .bgra8Unorm
        
        self.depthStencilPixelFormat = .depth32Float
        
        Engine.Initialize(self.device!)
        
        self.renderer = Renderer()
        
        Renderer.AspectRatio = Float(self.drawableSize.width) / Float(self.drawableSize.height)
        
        self.delegate = renderer
    }
    
    
}
