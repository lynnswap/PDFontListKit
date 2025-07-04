# PDFontListKit

PDFontListKit is a Swift package that provides a SwiftUI view for browsing and selecting fonts available on iOS and macOS.

## Features

- Lists font families and their individual fonts.
- Built with SwiftUI and works on iOS and macOS.
- Searchable list with smooth animations.
- Simple selection binding to receive the chosen font name.
- List style can be customized externally via SwiftUI modifiers.

## Usage

Add `PDFontListKit` as a dependency in your Swift Package or Xcode project. Then use `FontList` in your SwiftUI view:

```swift
@State private var selectedFontName: String = ""

var body: some View {
    FontList(selection: $selectedFontName)
        // Customize the list style from your own view
        .listStyle(.plain)
}
```

## Apps Using

<p float="left">
    <a href="https://apps.apple.com/jp/app/tweetpd/id1671411031"><img src="https://i.imgur.com/AC6eGdx.png" width="65" height="65"></a>
</p>

## License

This project is released under the MIT License. See [LICENSE](LICENSE) for details.
