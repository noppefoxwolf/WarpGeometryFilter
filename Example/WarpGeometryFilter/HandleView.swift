//
//  HandleView.swift
//  WarpGeometryFilter_Example
//
//  Created by beta on 2019/08/15.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol HandleViewDelegate: class {
  func didMoved(_ handleView: HandleView)
}

class HandleView: UIView {
  weak var delegate: HandleViewDelegate? = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupGestures()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupGestures() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    addGestureRecognizer(panGesture)
  }
  
  @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
    guard let superview = superview else { return }
    let point: CGPoint = gesture.translation(in: superview)
    let movedPoint: CGPoint = CGPoint(x: gesture.view!.center.x + point.x, y: gesture.view!.center.y + point.y)
    gesture.view!.center = movedPoint
    gesture.setTranslation(.zero, in: superview)
    delegate?.didMoved(self)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.height / 2.0
    backgroundColor = UIColor.black.withAlphaComponent(0.2)
  }
}
