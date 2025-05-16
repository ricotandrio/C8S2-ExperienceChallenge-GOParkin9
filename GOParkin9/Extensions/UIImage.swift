//
//  UIImage.swift
//  GOParkin9
//
//  Created by Rico Tandrio on 16/05/25.
//

import UIKit

extension UIImage {
    func resized(to targetSize: CGSize, compressionQuality: CGFloat = 0.7) -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = true

        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        let image = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }

        guard let jpegData = image.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }

        return UIImage(data: jpegData)
    }
}
