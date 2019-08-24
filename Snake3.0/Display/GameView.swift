import MetalKit

class GameView: MTKView {

    required init(coder: NSCoder) {
        super.init(coder: coder)
    
        self.delegate = self
    }
    
}

extension GameView: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        
    }
    
}
