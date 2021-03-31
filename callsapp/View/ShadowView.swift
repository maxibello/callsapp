//
//  ShadowView.swift
//  callsapp
//
//  Created by Maxim Kuznetsov on 31.03.2021.
//

import UIKit

class ShadowView: UIView {
    private var shapeLayer: CAShapeLayer {
        layer as! CAShapeLayer
    }
    
    override static var layerClass: AnyClass {
        CAShapeLayer.self
    }
    
    private var _cornerRadius: CGFloat?
    private var _roundedCorners: UIRectCorner = .allCorners
    
    init(_ style: ShadowStyle, background: UIColor? = nil, cornerRadius: CGFloat? = nil, roundedCorners: UIRectCorner = .allCorners) {
        super.init(frame: .zero)
        shapeLayer.setStyle(style)
        shapeLayer.fillColor = background?.cgColor
        _cornerRadius = cornerRadius
        _roundedCorners = roundedCorners
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let cornerRadius = _cornerRadius else { return }
        shapeLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: _roundedCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        shapeLayer.shadowPath = shapeLayer.path
    }
}

struct ShadowStyle {
    var color: UIColor
    var offset: CGSize
    var radius: CGFloat
    
    init(_ color: UIColor, _ offset: CGSize, _ radius: CGFloat) {
        self.color = color
        self.offset = offset
        self.radius = radius
    }
}

extension ShadowStyle {
    static var drop_shadow_0_2_2_4: ShadowStyle { .init(UIColor.black.withAlphaComponent(0.08), CGSize(width: 0, height: 2), 4) }
}

extension CAShapeLayer {
    func setStyle(_ style: ShadowStyle) {
        shadowColor = style.color.cgColor
        shadowOffset = style.offset
        shadowOpacity = 1
        shadowRadius = style.radius
    }
}
