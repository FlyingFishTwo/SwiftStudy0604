//
//  UIImage+Extension.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/27.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 获取网络图片尺寸
    /// - Parameter url: 网络图片链接
    /// - Returns: 图片尺寸size
    class func getImageSize(_ url: String?) -> CGSize {
        guard let urlStr = url else {
            return CGSize.zero
        }
        let tempUrl = URL(string: urlStr)
        let imageSourceRef = CGImageSourceCreateWithURL(tempUrl! as CFURL, nil)
        var width: CGFloat = 0
        var height: CGFloat = 0
        if let imageSRef = imageSourceRef {
            let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSRef, 0, nil)
            if let imageP = imageProperties {
                let imageDict = imageP as Dictionary
                width = imageDict[kCGImagePropertyPixelWidth] as! CGFloat
                height = imageDict[kCGImagePropertyPixelHeight] as! CGFloat
            }
        }
        return CGSize(width: width, height: height)
    }


    /// 通过图片url获取图片尺寸
    ///
    /// - Parameter url: 图片路径
    /// - Returns: 返回图片尺寸，有可能为zero
    class func getImageSizeWithURL(url:String?) -> CGSize {
        var imageSize:CGSize = .zero
        guard let imageUrlStr = url else { return imageSize }
        guard imageUrlStr != "" else {return imageSize}
        guard let imageUrl = URL(string: imageUrlStr) else { return imageSize }
        
        guard let imageSourceRef = CGImageSourceCreateWithURL(imageUrl as CFURL, nil) else {return imageSize}
        guard let imagePropertie = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, nil)  as? Dictionary<String,Any> else {return imageSize }
        imageSize.width = CGFloat((imagePropertie[kCGImagePropertyPixelWidth as String] as! NSNumber).floatValue)
        imageSize.height = CGFloat((imagePropertie[kCGImagePropertyPixelHeight as String] as! NSNumber).floatValue)
        return imageSize
    }
    
    
    
    
}



extension UIImage{

    class func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}


