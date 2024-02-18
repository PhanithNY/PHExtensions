//
//  UIImageExtensions.swift
//  Xplore
//
//  Created by Phanith Ny on 11/29/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

public extension UIImage {
  
  var aspectRatio: CGFloat {
    size.height / size.width
  }
  
  class func imageWithColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(CGRect(origin: CGPoint.zero, size: size))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image ?? UIImage()
  }
  
  final func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    let rect: CGRect = CGRect(origin: .zero, size: size)
    return UIGraphicsImageRenderer(size: rect.size).image { context in
      let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.width/2)
      path.addClip()
      self.draw(at: .zero)
    }
  }

  final func vImageByResize(to size: CGSize) -> UIImage? {
    if size.width <= 0 || size.height <= 0 {
      return nil
    }
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(in: CGRect(x: 0, y: 0, size: size))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }

  final func resize(to targetSize: CGSize) -> UIImage? {

    let widthMultiplier : CGFloat = targetSize.width / self.size.width
    let heightMultiplier : CGFloat = targetSize.height / self.size.height
    let sizeMultiplier = max(widthMultiplier, heightMultiplier)
    let newSize: CGSize = CGSize(width: self.size.width * sizeMultiplier, height: self.size.height * sizeMultiplier)

    let renderer = UIGraphicsImageRenderer(size: newSize)
    return renderer.image { (context) in
      self.draw(in: CGRect(origin: .zero, size: newSize))
    }
    
  }
  
  final func scale(to scale: CGFloat) -> UIImage? {
    
    let imageRect = CGRect(x: 0, y: 0, width: self.size.width/scale, height: self.size.height/scale)

    UIGraphicsBeginImageContext(imageRect.size)

    let bezierPath = UIBezierPath(roundedRect: imageRect, cornerRadius: 0)
    bezierPath.addClip()

    let widthMultiplier : CGFloat = self.size.width / self.size.width
    let heightMultiplier : CGFloat = self.size.height / self.size.height
    let sizeMultiplier = max(widthMultiplier, heightMultiplier)

    var drawRect = CGRect(x: 0, y: 0, width: self.size.width * sizeMultiplier, height: self.size.height * sizeMultiplier)
    if (drawRect.maxX > imageRect.maxX) {
        drawRect.origin.x -= (drawRect.maxX - imageRect.maxX) / 2
    }
    if (drawRect.maxY > imageRect.maxY) {
        drawRect.origin.y -= (drawRect.maxY - imageRect.maxY) / 2
    }

    self.draw(in: drawRect)

    let processedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return processedImage
    
  }
  
  final func colorImage(with color: UIColor) -> UIImage? {
    guard let cgImage = self.cgImage else { return nil }
    UIGraphicsBeginImageContext(self.size)
    let contextRef = UIGraphicsGetCurrentContext()
    
    contextRef?.translateBy(x: 0, y: self.size.height)
    contextRef?.scaleBy(x: 1.0, y: -1.0)
    let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
    
    contextRef?.setBlendMode(CGBlendMode.normal)
    contextRef?.draw(cgImage, in: rect)
    contextRef?.setBlendMode(CGBlendMode.sourceIn)
    color.setFill()
    contextRef?.fill(rect)
    
    let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return coloredImage
  }
  
}
