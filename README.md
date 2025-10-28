# 🕒 TimePicker

A **lightweight, customizable SwiftUI time picker** component for selecting **hours, minutes, and seconds** — designed for modern iOS apps that value clarity, animation, and minimalism.  
Built purely with **SwiftUI** and fully documented in **Apple’s documentation style**.

---

## 🧭 Definition

`TimePicker` provides a smooth, wheel-style time selection interface with optional background customization.  
It’s ideal for scenarios such as:
- Timers and stopwatches  
- Scheduling features  
- Input for durations or countdowns  

This package includes:
- `TimePicker`: A fully customizable SwiftUI view.
- `.timePicker(...)`: A modifier for presenting the picker in a sheet.
- Internal helpers (`PickerWithoutIndicator`, `RemovePickerIndicator`) for a clean, minimal design.

---

## 📦 Installation

### 🧰 Swift Package Manager (Recommended)

1. In Xcode, open **File ▸ Add Packages...**  
2. Paste the package URL:
   ```text
   https://github.com/ThakurVijay2191/TimePicker.git
   ```
3. Select the latest version and add it to your app target.

Alternatively, add it directly to your `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/ThakurVijay2191/TimePicker.git", from: "1.0.0")
]
```

---

## 💻 Usage

### 1. **Basic Example**

```swift
import SwiftUI
import TimePicker

struct ContentView: View {
    @State private var showPicker = false
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Selected Time: \(hours)h \(minutes)m \(seconds)s")
                .font(.headline)

            Button("Select Time") {
                showPicker = true
            }
            .timePicker(
                isPresented: $showPicker,
                style: .init(.bar),
                hours: $hours,
                minutes: $minutes,
                seconds: $seconds
            )
        }
        .padding()
    }
}
```

---

### 2. **Direct Usage**

```swift
TimePicker(
    style: .init(.bar),
    hours: $hours,
    minutes: $minutes,
    seconds: $seconds
)
```

You can embed this directly inside custom layouts or modals — it’s not limited to sheets.

---

## 📱 Preview



https://github.com/user-attachments/assets/705c8d5d-c8d6-432d-8e8d-53e5420f5c86


---

## 🎨 Customization

| Parameter | Type | Description |
|------------|------|-------------|
| `style` | `AnyShapeStyle` | Custom background fill (e.g., `.bar`, `.thinMaterial`, `.ultraThickMaterial`, or gradient). |
| `hours` | `Binding<Int>` | Bound variable for hour selection. |
| `minutes` | `Binding<Int>` | Bound variable for minute selection. |
| `seconds` | `Binding<Int>` | Bound variable for second selection. |

Example:
```swift
TimePicker(
    style: .init(.ultraThickMaterial),
    hours: $hours,
    minutes: $minutes,
    seconds: $seconds
)
```

---

## 🧩 Features

- 🔢 Configurable hours, minutes, and seconds pickers  
- 🎨 Supports any SwiftUI `ShapeStyle` background  
- 🧭 Wheel-style interaction (native iOS feel)  
- 🚫 Hides default picker indicators for a minimal design  
- 📱 Presentable via `.timePicker(...)` modifier  
- 🧾 Fully documented using Apple-style symbol comments  

---

## 🧱 Requirements

| Platform | Minimum Version |
|-----------|-----------------|
| iOS | 17.0 |
| Swift | 5.9 |
| Framework | SwiftUI |

---

## 📘 Example Project

This package includes a sample usage preview in `#Preview` for quick visualization in Xcode’s canvas.  
You can also clone the repo and run the demo app target to see the component in action.

---

## 🧾 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 🧑‍💻 Author

**Vijay Thakur**  
iOS Developer • Swift Enthusiast • UI/UX Focused Engineer  
- 💼 [LinkedIn]([https://www.linkedin.com/in/thakurvijay](https://www.linkedin.com/in/vijay-thakur-984646223/))  
- 🧑‍💻 [GitHub](https://github.com/ThakurVijay2191)

---

## 🏷️ Version History

| Version | Changes |
|----------|----------|
| **1.0.0** | Initial public release — added `TimePicker`, `.timePicker()` modifier, and Apple-style documentation. |

---

> “Simplicity is the ultimate sophistication.”  
> — Leonardo da Vinci
