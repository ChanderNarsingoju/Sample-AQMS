//
//  Extensions.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/1/22.
//

import Foundation
import UIKit

@IBDesignable extension UIView {
    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }

    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
            set {
                layer.borderColor = newValue?.cgColor
            }
            get {
                guard let color = layer.borderColor else {
                    return nil
                }
                return UIColor(cgColor: color)
            }
        }
        @IBInspectable var borderWidth: CGFloat {
            set {
                layer.borderWidth = newValue
            }
            get {
                return layer.borderWidth
            }
        }
        @IBInspectable var cornerRadius: CGFloat {
            set {
                layer.cornerRadius = newValue
                clipsToBounds = newValue > 0
            }
            get {
                return layer.cornerRadius
            }
        }
}

public extension UILabel {
    func addCharacterSpacing(kernValue: Double = 1.5) {
            if let labelText = text, labelText.count > 0 {
                let attributedString = NSMutableAttributedString(string: labelText)
                attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
                attributedText = attributedString
            }
        }
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            session.dataTask(with: request,completionHandler: {(data,response,error) in
                if data != nil {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data!)
                    }
                }
            }).resume()
        }
    }
}
