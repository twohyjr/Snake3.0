
import simd

class Camera: Node {
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.rotate(angle: self.getRotationX(), axis: X_AXIS)
        viewMatrix.rotate(angle: self.getRotationY(), axis: Y_AXIS)
        viewMatrix.rotate(angle: self.getRotationZ(), axis: Z_AXIS)
        viewMatrix.translate(-getPosition())
        return viewMatrix
    }
    
    var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: 90,
                                           aspectRatio: GameSettings.GridCellsHigh / GameSettings.GridCellsWide,
                                           near: 0.1,
                                           far: 100)
    }
}

