//
//  CGImage+Extensions.swift
//  WarpGeometryFilter
//
//  Created by beta on 2019/08/15.
//

import CoreGraphics

extension CGImage {
  static func make(cvPixelBuffer: CVPixelBuffer, colorspace: CGColorSpace = CGColorSpaceCreateDeviceRGB()) -> CGImage? {
    CVPixelBufferLockBaseAddress(cvPixelBuffer, .init(rawValue: 0))
    guard let sourceBaseAddr = CVPixelBufferGetBaseAddress(cvPixelBuffer) else {
      CVPixelBufferUnlockBaseAddress(cvPixelBuffer, .init(rawValue: 0))
      return nil
    }
    let height: Int = CVPixelBufferGetHeight(cvPixelBuffer)
    let width: Int = CVPixelBufferGetWidth(cvPixelBuffer)
    let bytesPerRow: Int = CVPixelBufferGetBytesPerRow(cvPixelBuffer)
    let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
    var cvPixelBuffer = cvPixelBuffer
    guard let provider = CGDataProvider(dataInfo: &cvPixelBuffer, data: sourceBaseAddr, size: bytesPerRow * height, releaseData: { (rawPixelBuffer, data, size) in
      if let usedPixelBuffer = rawPixelBuffer?.bindMemory(to: CVPixelBuffer.self, capacity: size) {
        CVPixelBufferUnlockBaseAddress(usedPixelBuffer.pointee, .init(rawValue: 0))
      }
    }) else {
      CVPixelBufferUnlockBaseAddress(cvPixelBuffer, .init(rawValue: 0))
      return nil
    }
    return CGImage(
      width: width,
      height: height,
      bitsPerComponent: 8,
      bitsPerPixel: 32,
      bytesPerRow: bytesPerRow,
      space: colorspace,
      bitmapInfo: bitmapInfo,
      provider: provider,
      decode: nil,
      shouldInterpolate: true,
      intent: .defaultIntent
    )
  }
}
