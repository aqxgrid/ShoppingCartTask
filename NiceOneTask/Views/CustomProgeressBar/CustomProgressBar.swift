//
//  File.swift
//  NiceOneTask
//
//  Created by Abdul Qadar on 12/30/23.
//

import UIKit

@IBDesignable
class CustomProgressBar: UIView {

    @IBInspectable var filledValue: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var totalValue: CGFloat = 100.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var firstFillColor: UIColor = .green {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var secondFillColor: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var unfilledColor: UIColor = .lightGray {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // Calculate the progress
        let progress = filledValue / totalValue

        // Calculate filled width
        let filledWidth = rect.width * progress

        // Create rounded corners path
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        path.addClip()

        // Draw the unfilled part
        unfilledColor.setFill()
        UIRectFill(rect)

        // Draw the first color (partially filled)
        let gradient = CGGradient(colorsSpace: nil, colors: [firstFillColor.cgColor, secondFillColor.cgColor] as CFArray, locations: nil)
        if let context = UIGraphicsGetCurrentContext(), let gradient = gradient {
            context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: filledWidth, y: 0), options: [])
        }
    }
}
