//
//  CVPixelBuffer+Extensions.swift
//  WarpGeometryFilter
//
//  Created by beta on 2019/08/15.
//

import CoreVideo

extension CVPixelBuffer {
  static func make(width: Int,
                   height: Int,
                   pixelFormatType: OSType = kCVPixelFormatType_32BGRA) -> CVPixelBuffer? {
    var pixelBuffer: CVPixelBuffer?
    let options: CFDictionary = [
      kCVPixelBufferCGImageCompatibilityKey as String: true,
      kCVPixelBufferCGBitmapContextCompatibilityKey as String: true,
      kCVPixelBufferIOSurfacePropertiesKey as String: [:]
    ] as CFDictionary
    CVPixelBufferCreate(kCFAllocatorDefault, width, height, pixelFormatType, options, &pixelBuffer)
    return pixelBuffer
  }
}
