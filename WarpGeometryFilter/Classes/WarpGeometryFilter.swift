//
//  WarpGeometryFilter.swift
//  SpriteKit-Warp
//
//  Created by beta on 2019/08/10.
//  Copyright © 2019 Tomoya Hirano. All rights reserved.
//

import SpriteKit
import AVFoundation

public let kCIInputWarpGeometryKey: String = "warpGeometry"

@objc class WarpGeometryFilterGenerator: NSObject, CIFilterConstructor {
  @objc func filter(withName name: String) -> CIFilter? {
    return WarpGeometryFilter(device: MTLCreateSystemDefaultDevice()!)
  }
}

public class WarpGeometryFilter: CIFilter {
  private let renderer: WarpGeometryFilterRenderer
  
  @objc var inputImage: CIImage?
  @objc var warpGeometry: SKWarpGeometry?
  
  public init(device: MTLDevice) {
    self.renderer = WarpGeometryFilterRenderer(device: device)
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    let device: MTLDevice = MTLCreateSystemDefaultDevice()!
    self.renderer = WarpGeometryFilterRenderer(device: device)
    super.init()
  }
  
  public class func register() {
    let attr: [String: AnyObject] = [:]
    CIFilter.registerName("WarpGeometryFilter", constructor: WarpGeometryFilterGenerator(), classAttributes: attr)
  }
  
  override public var outputImage: CIImage? {
    guard let inputImage = inputImage else { return nil }
    guard let warpGeometry = warpGeometry else { return nil }
    renderer.warpGeometry = warpGeometry
    renderer.render(ciImage: inputImage)
    return renderer.outputImage
  }
}
