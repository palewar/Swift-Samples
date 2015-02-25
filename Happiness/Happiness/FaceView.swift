//
//  FaceView.swift
//  Happiness
//
//  Created by Sachin Palewar on 2/24/15.
//  Copyright (c) 2015 SwiftWala. All rights reserved.
//

import UIKit

//@IBDesignable is not required, but it's used to render FaceView in Storyboard
//without compiling. Very useful feature along with @IBInspectable introduced
//with XCode 6. Read about it at:
//http://nshipster.com/ibinspectable-ibdesignable/

@IBDesignable class FaceView: UIView {

    //@IBInspectable is used to make these properties available in Attributes Inspector
    //while using Storyboard.
    @IBInspectable var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    @IBInspectable var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    @IBInspectable var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }

    // -1 smiliness means really sad. 0 means neither sad, neither happy. 1 means really happy
    @IBInspectable var smiliness: Double =  0.98 { didSet { setNeedsDisplay() }}

    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }

    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }

    //Common struct to store all our constants
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiustoMouthOffsetRatio: CGFloat = 3
    }

    private enum Eye { case Left, Right }

    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio

        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye {
        case .Left: eyeCenter.x -= eyeHorizontalSeparation / 2
        case .Right: eyeCenter.x += eyeHorizontalSeparation / 2
        }

        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }

    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiustoMouthOffsetRatio

        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight

        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)

        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }

    override func drawRect(rect: CGRect) {

        //Drawing Face
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()

        //Eyes
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()

        //Mouth
        bezierPathForSmile(smiliness).stroke()
    }


}
