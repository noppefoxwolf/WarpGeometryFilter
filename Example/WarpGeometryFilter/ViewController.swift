//
//  ViewController.swift
//  WarpGeometryFilter
//
//  Created by noppefoxwolf on 08/15/2019.
//  Copyright (c) 2019 noppefoxwolf. All rights reserved.
//

import UIKit
import SpriteKit
import WarpGeometryFilter

final class ViewController: UIViewController {
  @IBOutlet private weak var imageView: UIImageView!
  private let filter: WarpGeometryFilter = .init(device: MTLCreateSystemDefaultDevice()!)
  private lazy var handleViews: [HandleView] = (0..<source.count).map({ _ in HandleView(frame: .zero) })
  let source: [vector_float2] = [
    .init(0, 0), .init(0.25, 0), .init(0.5, 0), .init(0.75, 0), .init(1, 0),
    .init(0, 0.25), .init(0.25, 0.25), .init(0.5, 0.25), .init(0.75, 0.25), .init(1, 0.25),
    .init(0, 0.5), .init(0.25, 0.5), .init(0.5, 0.5), .init(0.75, 0.5), .init(1, 0.5),
    .init(0, 0.75), .init(0.25, 0.75), .init(0.5, 0.75), .init(0.75, 0.75), .init(1, 0.75),
    .init(0, 1), .init(0.25, 1), .init(0.5, 1), .init(0.75, 1), .init(1, 1),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.clipsToBounds = false
    imageView.isUserInteractionEnabled = true
    setupHandles()
    updateImage()
  }
  
  func setupHandles() {
    imageView.subviews.forEach({ $0.removeFromSuperview() })
    source.enumerated().forEach { (offset, vector) in
      let handleView = self.handleViews[offset]
      handleView.frame = .init(origin: .zero, size: .init(width: 44, height: 44))
      handleView.center = CGPoint(
        x: CGFloat(vector.x) * self.imageView.bounds.width,
        y: CGFloat(vector.y) * self.imageView.bounds.height
      )
      handleView.delegate = self
      handleView.tag = offset
      self.imageView.addSubview(handleView)
    }
  }
  
  private func updateImage() {
    let distination = handleViews.map({ vector_float2(x: Float($0.center.x) / Float(self.imageView.bounds.width), y:  Float($0.center.y) / Float(self.imageView.bounds.height)) })
    let warpGeometry = SKWarpGeometryGrid(columns: 4, rows: 4, sourcePositions: source, destinationPositions: distination)
    let inputImage = #imageLiteral(resourceName: "Lenna")
    filter.setValue(CIImage(image: inputImage)!.oriented(.downMirrored), forKey: kCIInputImageKey)
    filter.setValue(warpGeometry, forKey: kCIInputWarpGeometryKey)
    let outputImage = UIImage(ciImage: filter.outputImage!.oriented(.downMirrored))
    imageView.image = outputImage
  }
}

extension ViewController: HandleViewDelegate {
  func didMoved(_ handleView: HandleView) {
    updateImage()
  }
}

