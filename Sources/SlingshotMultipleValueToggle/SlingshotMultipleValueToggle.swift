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

public struct SlingshotMultipleValueToggle: View {
  
  // MARK: - Private properties changable on init
  
  @Binding private var selectedValue: UInt
  
  private var backgroundColor: Color
  private var backgrondShadowRadius: CGFloat
  
  private var icons: [Image]
  private var iconSelectedColor: Color
  private var iconDefaultColor: Color
  
  private var selectionFillColor: Color
  
  // MARK: - Private properties used internally
  
  @State private var dragDistance: CGFloat = 0.0
  @State private var animatedValue: UInt = 0
  
  private let iconSizeDifference = 4.0
  
  // MARK: - Public initializer
  
  public init(selectedValue: Binding<UInt>,
              backgroundColor: Color = Color(red: 0.8, green: 0.8, blue: 0.9).opacity(0.3),
              backgrondShadowRadius: CGFloat = 10.0,
              icons: [Image] = [Image(systemName: "1.circle"), Image(systemName: "2.circle"), Image(systemName: "3.circle")],
              iconSelectedColor: Color = .black.opacity(0.5),
              iconDefaultColor: Color = .black.opacity(0.3),
              selectionFillColor: Color = .white.opacity(0.5)) {
    
    self._selectedValue = selectedValue
    self.animatedValue = selectedValue.wrappedValue
    
    self.backgroundColor = backgroundColor
    self.backgrondShadowRadius = backgrondShadowRadius
    self.icons = icons
    self.iconSelectedColor = iconSelectedColor
    self.iconDefaultColor = iconDefaultColor
    self.selectionFillColor = selectionFillColor
  }
  
  // MARK: - UI
  
  public var body: some View {
    GeometryReader { geometry in
      GeometryReader { geometry in
        Capsule(style: .continuous)
          .fill(backgroundColor)
          .shadow(radius: backgrondShadowRadius)
        selectionCircle(for: geometry)
          .clipShape(Capsule(style: .continuous))
        icons(for: geometry)
      }
      .onChange(of: $selectedValue.wrappedValue, perform: { value in
        withAnimation(.easeInOut(duration: 0.2)) {
          animatedValue = value
        }
      })
      .frame(minWidth: geometry.size.height * CGFloat((icons.count * 3 / 2)), minHeight: 30, maxHeight: 100)
      .position(x: geometry.size.width / 2,
                y: geometry.size.height / 2)
    }
  }
  
  @ViewBuilder
  private func selectionCircle(for geometry: GeometryProxy) -> some View {
    if icons.count <= 1 {
      EmptyView()
    } else {
      GeometryReader { geometry in
        
        let fullWidth = geometry.size.width * (1 + 1 / (CGFloat(icons.count) - 1))
        let iconWidth = fullWidth / CGFloat(icons.count)
        let iconPlacementOffset = iconWidth * CGFloat(animatedValue)
        
        SlingshotToggleCircle(slingshotDistance: dragDistance)
          .fill(selectionFillColor)
          .frame(width: iconWidth, height: geometry.size.height)
          .position(x: iconPlacementOffset, y: geometry.size.height / 2)
          .blur(radius: 1.0)
          .gesture(
            DragGesture()
              .onEnded { (value) in
                withAnimation {
                  dragDistance = 0.0
                }
              }
              .onChanged { (value) in
                var dragDistanceCalculation = (value.location.x - iconPlacementOffset) / iconWidth * 2
                
                if selectedValue == 0 && dragDistanceCalculation < 0 {
                  dragDistanceCalculation = 0
                }
                if selectedValue == icons.count - 1 && dragDistanceCalculation > 0 {
                  dragDistanceCalculation = 0
                }
                
                withAnimation {
                  dragDistance = dragDistanceCalculation
                }
                
                if dragDistanceCalculation > 1 {
                  selectedValue += 1
                } else if dragDistanceCalculation < -1 {
                  selectedValue -= 1
                }
              }
          )
      }
      .frame(width: geometry.size.width - geometry.size.height, height: geometry.size.height)
      .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    }
  }
  
  @ViewBuilder
  private func icons(for geometry: GeometryProxy) -> some View {
    if icons.count <= 1 {
      EmptyView()
    } else {
      GeometryReader { geometry in
        ForEach((0..<icons.count), id: \.self) {
          let iconIndex = $0
          let fullWidth = geometry.size.width * (1 + 1 / (CGFloat(icons.count) - 1))
          let iconWidth = fullWidth / CGFloat(icons.count)
          let iconPlacementOffset = iconWidth * CGFloat(iconIndex)
          icons[iconIndex]
            .resizable()
            .frame(width: geometry.size.height - iconSizeDifference * 2, height: geometry.size.height - iconSizeDifference * 2)
            .position(x: iconPlacementOffset, y: geometry.size.height / 2)
            .foregroundStyle(animatedValue == iconIndex ? iconSelectedColor : iconDefaultColor)
            .allowsHitTesting(animatedValue != iconIndex)
            .onTapGesture {
              selectedValue = UInt(iconIndex)
            }
        }
      }
      .frame(width: geometry.size.width - geometry.size.height, height: geometry.size.height)
      .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    }
  }
}
