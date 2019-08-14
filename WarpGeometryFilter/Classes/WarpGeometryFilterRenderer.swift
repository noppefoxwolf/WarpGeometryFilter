//
//  WarpGeometryFilterRenderer.swift
//  WarpGeometryFilter
//
//  Created by beta on 2019/08/15.
//

import SpriteKit

class WarpGeometryFilterRenderer {
  private let device: MTLDevice
  private let scene: SKScene = .init()
  private let rootNode: SKNode = .init()
  private let spriteNode: SKSpriteNode = .init()
  private let renderer: SKRenderer
  private let commandQueue: MTLCommandQueue
  private var offscreenTexture: MTLTexture!
  private let colorspace: CGColorSpace
  private let context: CIContext
  var outputImage: CIImage? {
    guard let texture = offscreenTexture else { return nil }
    return CIImage(mtlTexture: texture, options: [.colorSpace : colorspace])
  }
  var warpGeometry: SKWarpGeometry? {
    get { return spriteNode.warpGeometry }
    set { spriteNode.warpGeometry = newValue }
  }
  
  init(device: MTLDevice, colorspace: CGColorSpace = CGColorSpaceCreateDeviceRGB()) {
    self.device = device
    self.renderer = SKRenderer(device: device)
    self.colorspace = colorspace
    self.commandQueue = device.makeCommandQueue()!
    self.context = CIContext(mtlDevice: device)
    scene.addChild(spriteNode)
  }
  
  func render(ciImage: CIImage) {
    guard let pixelBuffer = ciImage.makePixelBuffer(context: context) else { return }
    guard let commandBuffer = commandQueue.makeCommandBuffer() else { return }
    offscreenTexture = offscreenTexture ?? device.makeBlankTexture(cvPixelBuffer: pixelBuffer)
    
    let width = CVPixelBufferGetWidth(pixelBuffer)
    let height = CVPixelBufferGetHeight(pixelBuffer)
    let viewport = CGRect(x: 0, y: 0, width: width, height: height)
    
    
    let renderPassDescriptor: MTLRenderPassDescriptor = .init()
    MTLRenderPassDescriptor: do {
      renderPassDescriptor.colorAttachments[0].texture = offscreenTexture
      renderPassDescriptor.colorAttachments[0].loadAction = .clear
      renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 0, 0)
      renderPassDescriptor.colorAttachments[0].storeAction = .store
    }
    
    if let image = CGImage.make(cvPixelBuffer: pixelBuffer, colorspace: colorspace) {
      scene.size = .init(width: width, height: height)
      spriteNode.position = .init(x: width / 2, y: height / 2)
      spriteNode.size = .init(width: width, height: height)
      spriteNode.yScale = -1
      spriteNode.texture = .init(cgImage: image)
    }
    
    renderer.scene = scene
    renderer.render(withViewport: viewport, commandBuffer: commandBuffer, renderPassDescriptor: renderPassDescriptor)
    
    commandBuffer.commit()
    commandBuffer.waitUntilCompleted()
  }
}

