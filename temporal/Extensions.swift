//
//  extensions.swift
//  Crisp
//
//  Created by Graham Held on 12/29/14.
//  Copyright (c) 2015 Graham Held. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func CrispColor() -> UIColor{
        return UIColor(red: 1.0, green: 0.75, blue: 0.25, alpha: 1.0)
        //return UIColor(red: 241.0/255.0, green: 170.0/255.0, blue: 72.0/255.0, alpha: 1.0) //Orange V1
        //return UIColor(red: 255.0/255.0, green: 158.0/255.0, blue: 55.0/255.0, alpha: 1.0) //Orange V2
        //return UIColor(red: 241/255.0, green: 170/255.0, blue: 72/255.0, alpha: 1.0)
    }
    class func SnapGreen() -> UIColor{
        return UIColor(red:(97.0/255.0).cg, green:(212.0/255.0).cg, blue:(70.0/255.0).cg, alpha:1.0.cg)
    }
    class func MolestyRed() -> UIColor {
        return UIColor(red:1.0, green:0.3, blue:0.2, alpha:1.0)
    }
    class func colorFromHexString(netHex:String) -> UIColor{

//        let index   = advance(netHex.startIndex, 1)
//        let hex     = netHex.substringFromIndex(index)
        let scanner = NSScanner(string: netHex)
        var hexValue: CUnsignedLongLong = 0
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        if scanner.scanHexLongLong(&hexValue) {
            r = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
            b = CGFloat(hexValue & 0x0000FF) / 255.0
        }

        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    class func lerp(color1:UIColor, color2:UIColor, fac:CGFloat) -> UIColor{
        var neg:CGFloat = 1.0-fac
        var c1 = CGColorGetComponents(color1.CGColor)
        var c2 = CGColorGetComponents(color2.CGColor)
        var r:CGFloat = (c1[0] * neg) + (c2[0] * fac)
        var g:CGFloat = (c1[1] * neg) + (c2[1] * fac)
        var b:CGFloat = (c1[2] * neg) + (c2[2] * fac)
        var a:CGFloat = (c1[3] * neg) + (c2[3] * fac)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    class func colorIsLight(color:UIColor) -> Bool {

        // Counting the perceptive luminance
        // human eye favors green color...
        var c = CGColorGetComponents(color.CGColor)
        var r = c[0]
        var g = c[1]
        var b = c[2]
        var a = 1 - (0.299 * r + 0.587 * g + 0.114 * b);
        return (a < 0.5);
    }
}
extension CGRect {
    var bounds:CGRect {
        return CGRectMake(0, 0, self.width, self.height)
    }
    var diagonal:CGFloat {
        return sqrt(pow(self.width, 2)+pow(self.height,2))
    }
    init (center:CGPoint, size:CGSize){
        self = CGRect(origin: CGPointMake(center.x-(size.width/2.0), center.y-(size.height/2.0)), size: size)
    }
    var halfX:CGFloat {
        return width/2.0
    }
    var halfY:CGFloat {
        return height/2.0
    }
    var center:CGPoint{
        return CGPoint(x: halfX, y: halfY)
    }
}
extension CGPoint {
    var magnitude:CGFloat {
        return sqrt((self.x * self.x)+(self.y * self.y))
    }
    var nx:CGPoint {return CGPointMake(-self.x, self.y)}
    var ny:CGPoint {return CGPointMake(self.x, -self.y)}
}

extension CGSize {
    var h:CGFloat {return height}
    var w:CGFloat {return width}
}

func CGSizeMake(squareSize:CGFloat) -> CGSize{
    return CGSizeMake(squareSize, squareSize)
}

func CGPointOffset(p1:CGPoint, p2:CGPoint) -> CGPoint{
    var diffx:CGFloat = p1.x-p2.x
    var diffy:CGFloat = p1.y-p2.y
    return CGPointMake(diffx, diffy)
}

func CGRectPlace(rect:CGRect, x:CGFloat, y:CGFloat) -> CGRect{
    return CGRectPlace(rect, CGPoint(x: x, y: y))
}
func CGRectPlace(rect:CGRect, point:CGPoint) -> CGRect{
    return CGRect(origin: point, size: rect.size)
}
func signum(x:CGFloat) -> CGFloat{
    if (x != 0){
        var y = abs(x)
        var fuckMeSideways = x/y
        return fuckMeSideways
    } else {
        return 0
    }
}
func toggle(b:Bool) -> Bool{
    return (1 - b.i).b
}
extension UIBezierPath{
    convenience init(circleOutRect: CGRect){
        var cunt = circleOutRect.diagonal
        self.init(ovalInRect: CGRectMake(-(cunt-circleOutRect.width)/2.0, -(cunt-circleOutRect.height)/2.0, cunt, cunt))
    }
}
extension CGFloat{
    var d:Double {return Double(self)}
    var f:Float {return Float(self)}
    var b:Bool {return Bool(self)}
    var i:Int {return Int(self)}
}
extension Double{
    var cg:CGFloat {return CGFloat(self)}
    var f:Float {return Float(self)}
    var b:Bool {return Bool(self)}
    var i:Int {return Int(self)}
}
extension Int{
    var cg:CGFloat {return CGFloat(self)}
    var f:Float {return Float(self)}
    var d:Double {return Double(self)}
    var b:Bool {return Bool(self)}
}

extension Float{
    var cg:CGFloat {return CGFloat(self)}
    var d:Double {return Double(self)}
    var b:Bool {return Bool(self)}
    var i:Int {return Int(self)}
}

extension Bool{
    var cg:CGFloat {return CGFloat(self)}
    var f:Float {return Float(self)}
    var d:Double {return Double(self)}
    var i:Int {return Int(self)}

}

extension UIImage{
    var aspect:CGFloat{return self.size.height/self.size.width}
}

//Brian's Extensions
extension NSDateFormatter{
    func fromISO(dateString: String) -> NSDate{
        self.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        return self.dateFromString(dateString as NSString as String)!
    }
}
