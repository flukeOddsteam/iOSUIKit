//
//  UIImageViewExtension.swift
//  ONE_oneapp-designsystem-ios-UIKit
//
//  Created by flukeInwza on 14/1/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(with url: URL?, placeHolder: UIImage?, cacheable: Bool = true, completion: (() -> Void)? = nil) {

        if cacheable {
            self.kf.setImage(with: url, placeholder: placeHolder) { _ in
                completion?()
            }
        } else {
            self.image = placeHolder

            guard let url = url else { return }

            let session = URLSession(configuration: URLSessionConfiguration.default)
            let request = URLRequest(url: url)
            session.dataTask(with: request) { data, _, _ in
                DispatchQueue.main.async { [weak self] in
                    if let data = data, let image = UIImage(data: data) {
                        self?.image = image
                    } else {
                        self?.image = placeHolder
                    }
                    completion?()
                }
            }
            .resume()
        }
    }

    func setColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIImage {
    func maskWithColor(color: UIColor) -> UIImage? {
        guard let maskImage = cgImage else {
            return nil
        }
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        guard let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}

extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }

        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

