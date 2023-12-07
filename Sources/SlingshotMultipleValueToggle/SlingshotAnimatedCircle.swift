//  MIT License
//
//  Copyright (c) 2023 Loránd Ignát
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import SwiftUI

struct SlingshotToggleCircle: Shape {
  
  var slingshotDistance = 0.0
  var animatableData: Double {
    get {
      slingshotDistance
    }
    set {
      slingshotDistance = newValue
    }
  }
  
  private let circleSizeDifference = 2.0
  
  func path(in rect: CGRect) -> Path {
    
    let width = rect.size.width
    let height = rect.size.height
    
    let point1 = CGPoint(x: width / 2, y: circleSizeDifference)
    
    let point2 = CGPoint(x: (width - height) / 2 + circleSizeDifference + (slingshotDistance < 0 ? (slingshotDistance > -1 ? slingshotDistance * height : -height) : 0), y: height / 2)
    let pointControl1 = CGPoint(x: (width - height) / 2 + circleSizeDifference, y: circleSizeDifference)
    
    let point3 = CGPoint(x: width / 2, y: height - circleSizeDifference)
    let pointControl2 = CGPoint(x: (width - height) / 2 + circleSizeDifference, y: height - circleSizeDifference)
    
    let point4 = CGPoint(x: (width + height) / 2 - circleSizeDifference +  (slingshotDistance > 0 ? (slingshotDistance < 1 ? slingshotDistance * height : height) : 0), y: height / 2)
    let pointControl3 = CGPoint(x: (width + height) / 2 - circleSizeDifference, y: height - circleSizeDifference)
    
    let pointControl4 = CGPoint(x: (width + height) / 2 - circleSizeDifference, y: circleSizeDifference)
    
    return Path { path in
      path.move(to: point1)
      path.addQuadCurve(to: point2, control: pointControl1)
      path.addQuadCurve(to: point3, control: pointControl2)
      path.addQuadCurve(to: point4, control: pointControl3)
      path.addQuadCurve(to: point1, control: pointControl4)
      path.closeSubpath()
    }
  }
}
