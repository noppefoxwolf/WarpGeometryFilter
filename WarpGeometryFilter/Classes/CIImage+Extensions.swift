//
//  CIImage+Extensions.swift
//  SpriteKit-Warp
//
//  Created by beta on 2019/08/10.
//  Copyright © 2019 Tomoya Hirano. All rights reserved.
//

import CoreImage

extension CIImage {
  func makePixelBuffer(context: CIContext = .init()) -> CVPixelBuffer? {
    let size: CGSize = extent.size
    guard let pixelBuffer = CVPixelBuffer.make(width: Int(size.width), height: Int(size.height)) else { return nil }
    context.render(self, to: pixelBuffer)
    return pixelBuffer
  }
}
