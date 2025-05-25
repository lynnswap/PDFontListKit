// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
#if os(iOS) || os(tvOS)
import UIKit
typealias PlatformFont = UIFont

func platformFamilyNames() -> [String] {
    UIFont.familyNames
}
func platformFontNames(forFamilyName familyName: String) -> [String] {
    UIFont.fontNames(forFamilyName: familyName)
}

#elseif os(macOS)
import AppKit
typealias PlatformFont = NSFont

func platformFamilyNames() -> [String] {
    NSFontManager.shared.availableFontFamilies
}
func platformFontNames(forFamilyName familyName: String) -> [String] {
    let members = NSFontManager.shared.availableMembers(ofFontFamily: familyName) ?? []
    return members.compactMap { $0.first as? String }
}

#endif
struct FontFamily: Identifiable {
    var id = UUID()
    var familyName: String
    var fontNames: [String]
}


public struct FontList: View {
    @Binding private var selection: String

    public init(
        selection:Binding<String>
    ){
        _selection = selection
    }
    
    @State private var families : [FontFamily] = []
    @State private var searchText: String = ""

    private var filteredFamilies: [FontFamily] {
        if searchText.isEmpty {
            return families
        } else {
            return families.compactMap { family in
                let matchedFontNames = family.fontNames.filter { fontName in
                    fontName.localizedCaseInsensitiveContains(searchText)
                }
                if !matchedFontNames.isEmpty {
                    return FontFamily(familyName: family.familyName, fontNames: matchedFontNames)
                } else {
                    return nil
                }
            }
        }
    }

    public var body: some View {
        List {
            ForEach(filteredFamilies) { family in
                Section {
                    ForEach(family.fontNames, id: \.self) { fontName in
                        HStack {
                            Text(fontName)
                                .font(.custom(fontName, size: 16))
                            Spacer()
                            if selection == fontName {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selection = fontName
                        }
                    }
                } header: {
                    Text(family.familyName)
                }
            }
        }
        .animation(.smooth(duration:0.2),value:searchText)
        .listStyle(.plain)
        .searchable(text: $searchText)
        .autocorrectionDisabled()
        .task{
            var items: [FontFamily] = []
            for family in platformFamilyNames() {
                items.append(.init(familyName: family, fontNames: platformFontNames(forFamilyName: family)))
            }
            self.families = items
        }
    }
}
#if DEBUG
#Preview {
    @Previewable @State var selectedFontName:String = ""
    NavigationStack {
        FontList(selection: $selectedFontName)
    }
}
#endif
