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
    defer {
      CVPixelBufferUnlockBaseAddress(cvPixelBuffer, .init(rawValue: 0))
    }
    guard let sourceBaseAddr = CVPixelBufferGetBaseAddress(cvPixelBuffer) else { return nil }
    // 謎の黒い縁が出ることがあるので1px縮小
    let height: Int = CVPixelBufferGetHeight(cvPixelBuffer) - 1
    let width: Int = CVPixelBufferGetWidth(cvPixelBuffer) - 1
    let bytesPerRow: Int = CVPixelBufferGetBytesPerRow(cvPixelBuffer)
    let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
    var cvPixelBuffer = cvPixelBuffer
    guard let provider = CGDataProvider(dataInfo: &cvPixelBuffer, data: sourceBaseAddr, size: bytesPerRow * height, releaseData: { (_, _, _) in }) else { return nil }
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
