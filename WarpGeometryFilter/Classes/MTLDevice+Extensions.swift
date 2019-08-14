//
//  MTLDevice+Extensions.swift
//  WarpGeometryFilter
//
//  Created by beta on 2019/08/15.
//

import Metal

extension MTLDevice {
  func makeBlankTexture(cvPixelBuffer: CVPixelBuffer) -> MTLTexture? {
    let width = CVPixelBufferGetWidth(cvPixelBuffer)
    let height = CVPixelBufferGetHeight(cvPixelBuffer)
    let pixelFormat: MTLPixelFormat = .rgba8Unorm
    let bytesPerRow = CVPixelBufferGetBytesPerRow(cvPixelBuffer)
    var rawData0 = [UInt8](repeating: 0, count: bytesPerRow * height)
    let textureDescriptor: MTLTextureDescriptor = .texture2DDescriptor(pixelFormat: pixelFormat, width: width, height: height, mipmapped: false)
    textureDescriptor.usage = MTLTextureUsage(rawValue: MTLTextureUsage.renderTarget.rawValue | MTLTextureUsage.shaderRead.rawValue)
    let texture = makeTexture(descriptor: textureDescriptor)
    let region = MTLRegionMake2D(0, 0, width, height)
    texture?.replace(region: region, mipmapLevel: 0, withBytes: &rawData0, bytesPerRow: bytesPerRow)
    return texture
  }
}
