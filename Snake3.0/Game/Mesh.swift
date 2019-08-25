import MetalKit

class QuadMesh {
    private var _vertices: [Vertex] = []
    private var _indices: [UInt32] = []
    private var _vertexBuffer: MTLBuffer!
    private var _indexBuffer: MTLBuffer!
    
    init() {
        buildMesh()
        buildBuffers()
    }
    
    private func addVertex(postion: float3,
                           textureCoordinate: float2 = float2(0,0)) {
        self._vertices.append(Vertex(position: postion, textureCoordinate: textureCoordinate))
    }
    
    private func buildMesh() {
        addVertex(postion: float3( 0.5, 0.5, 0.0))// Top Right
        addVertex(postion: float3(-0.5, 0.5, 0.0))// Top Left
        addVertex(postion: float3(-0.5,-0.5, 0.0))// Bottom Left
        addVertex(postion: float3( 0.5,-0.5, 0.0))// Bottom Right
        
        _indices = [ 0, 1, 2,    0, 2, 3 ]
    }

    private func buildBuffers() {
        _vertexBuffer = Engine.Device.makeBuffer(bytes: _vertices,
                                                 length: Vertex.stride(_vertices.count),
                                                 options: [])
        
        _indexBuffer = Engine.Device.makeBuffer(bytes: _indices,
                                                length: UInt32.stride(self._indices.count),
                                                options: [])
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(_vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawIndexedPrimitives(type: .triangle,
                                                   indexCount: _indices.count,
                                                   indexType: .uint32,
                                                   indexBuffer: _indexBuffer,
                                                   indexBufferOffset: 0,
                                                   instanceCount: 1)
    }
}
