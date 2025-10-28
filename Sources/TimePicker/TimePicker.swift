// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// A customizable SwiftUI view that displays a time picker with hours, minutes, and seconds.
///
/// `TimePicker` provides a minimal, wheel-style time selection interface.
/// You can customize its background style and bind to hour, minute, and second values.
///
/// Example:
/// ```swift
/// @State private var hours = 0
/// @State private var minutes = 0
/// @State private var seconds = 0
///
/// TimePicker(hours: $hours, minutes: $minutes, seconds: $seconds)
/// ```
///
/// - Note: Requires iOS 17.0 or later.
@available(iOS 17.0, *)
public struct TimePicker: View {
    
    /// The background style applied to the picker container.
    var style: AnyShapeStyle
    
    /// The binding representing the selected hour value.
    @Binding var hours: Int
    
    /// The binding representing the selected minute value.
    @Binding var minutes: Int
    
    /// The binding representing the selected second value.
    @Binding var seconds: Int
    
    /// Creates a new instance of `TimePicker`.
    ///
    /// - Parameters:
    ///   - style: The visual style for the picker background. Defaults to `.bar`.
    ///   - hours: A binding to the selected hour value.
    ///   - minutes: A binding to the selected minute value.
    ///   - seconds: A binding to the selected second value.
    public init(
        style: AnyShapeStyle = .init(.bar),
        hours: Binding<Int>,
        minutes: Binding<Int>,
        seconds: Binding<Int>
    ) {
        self.style = style
        self._hours = hours
        self._minutes = minutes
        self._seconds = seconds
    }
    
    /// The content and layout of the time picker.
    public var body: some View {
        HStack(spacing: 0) {
            CustomView("hours", 0...24, $hours)
            CustomView("mins", 0...60, $minutes)
            CustomView("secs", 0...60, $seconds)
        }
        .offset(x: -25)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(style)
                .frame(height: 35)
        }
        .padding(.horizontal, 15)
    }
  
    /// A helper view builder that creates an individual picker (hours, minutes, or seconds).
    ///
    /// - Parameters:
    ///   - title: The label displayed beside the picker.
    ///   - range: The range of selectable values.
    ///   - selection: The binding representing the selected value.
    @ViewBuilder
    private func CustomView(
        _ title: String,
        _ range: ClosedRange<Int>,
        _ selection: Binding<Int>
    ) -> some View {
        PickerWithoutIndicator(selection: selection) {
            ForEach(range, id: \.self) { value in
                Text("\(value)")
                    .frame(width: 35, alignment: .trailing)
                    .tag(value)
            }
        }
        .overlay {
            Text(title)
                .font(.callout.bold())
                .frame(width: 50, alignment: .leading)
                .lineLimit(1)
                .offset(x: 50)
        }
    }
}

// MARK: - View Extension for Sheet Presentation

@available(iOS 17.0, *)
public extension View {
    
    /// Presents a `TimePicker` as a sheet over the current view.
    ///
    /// - Parameters:
    ///   - isPresented: A binding that controls the visibility of the sheet.
    ///   - style: The visual style for the picker background. Defaults to `.bar`.
    ///   - hours: A binding to the selected hour value.
    ///   - minutes: A binding to the selected minute value.
    ///   - seconds: A binding to the selected second value.
    ///
    /// Example:
    /// ```swift
    /// @State private var showPicker = false
    /// @State private var hours = 0
    /// @State private var minutes = 0
    /// @State private var seconds = 0
    ///
    /// Button("Select Time") {
    ///     showPicker = true
    /// }
    /// .timePicker(
    ///     isPresented: $showPicker,
    ///     hours: $hours,
    ///     minutes: $minutes,
    ///     seconds: $seconds
    /// )
    /// ```
    @ViewBuilder
    func timePicker(
        isPresented: Binding<Bool>,
        style: AnyShapeStyle = .init(.bar),
        hours: Binding<Int>,
        minutes: Binding<Int>,
        seconds: Binding<Int>
    ) -> some View {
        self.sheet(isPresented: isPresented) {
            VStack {
                Button("Done") {
                    isPresented.wrappedValue = false
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 16)
                .padding(.trailing, 25)
                
                TimePicker(
                    style: style,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds
                )
            }
            .presentationDetents([.height(250)])
        }
    }
}

// MARK: - PickerWithoutIndicator

@available(iOS 17.0, *)
fileprivate struct PickerWithoutIndicator<Content: View, Selection: Hashable>: View {
    
    /// The currently selected value.
    @Binding var selection: Selection
    
    /// The content of the picker.
    @ViewBuilder var content: Content
    
    /// Tracks whether the default picker indicator lines have been hidden.
    @State private var isHidden: Bool = false
    
    /// The content and behavior of the custom picker.
    var body: some View {
        Picker("", selection: $selection) {
            if !isHidden {
                RemovePickerIndicator {
                    isHidden = true
                }
            }
            content
        }
        .pickerStyle(.wheel)
    }
}

// MARK: - RemovePickerIndicator

/// A UIKit-based helper that removes the default indicator lines from `UIPickerView`.
fileprivate struct RemovePickerIndicator: UIViewRepresentable {
    
    /// Called after the picker indicators are successfully removed.
    var result: () -> ()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        // Remove picker separator lines asynchronously to ensure view hierarchy is ready.
        DispatchQueue.main.async {
            if let pickerView = view.pickerView {
                if pickerView.subviews.count >= 2 {
                    pickerView.subviews[1].backgroundColor = .clear
                }
                result()
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
}

// MARK: - UIView Extension

fileprivate extension UIView {
    /// Recursively searches for the parent `UIPickerView` in the view hierarchy.
    var pickerView: UIPickerView? {
        if let view = superview as? UIPickerView {
            return view
        }
        return superview?.pickerView
    }
}
