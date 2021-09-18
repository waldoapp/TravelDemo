import UIKit

public class FontFactory {

    // MARK: Public Initializers

    public init(_ elementMap: [DisplayElement: String]) {
        self.elementMap = elementMap
    }

    // MARK: Public Subscripts

    public subscript(_ element: DisplayElement) -> UIFont? {
        FontFactory.fontMap[elementMap[element] ?? ""]
    }

    // MARK: Private Nested Types

    private struct RawFont: Decodable {
        let name: String
        let size: CGFloat
    }

    // MARK: Private Type Properties

    private static let fontMap: [String: UIFont] = loadFontMap()

    // MARK: Private Type Methods

    private static func loadFontMap() -> [String: UIFont] {
        guard let url = Bundle.main.url(forResource: "StandardFonts",
                                        withExtension: "plist"),
              let data = try? Data(contentsOf: url)
        else { return [:] }

        let decoder = PropertyListDecoder()

        guard let rawFonts = try? decoder.decode([String: RawFont].self,
                                                 from: data)
        else { return [:] }

        return rawFonts.mapValues { UIFont(name: $0.name,
                                           size: $0.size) ?? UIFont.systemFont(ofSize: $0.size)
        }
    }

    // MARK: Private Instance Properties

    private let elementMap: [DisplayElement: String]
}
