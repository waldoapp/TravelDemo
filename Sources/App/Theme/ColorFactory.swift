import UIKit

public class ColorFactory {

    // MARK: Public Initializers

    public init(_ elementMap: [DisplayElement: String]) {
        self.elementMap = elementMap
    }

    // MARK: Public Subscripts

    public subscript(_ element: DisplayElement) -> UIColor? {
        ColorFactory.colorMap[elementMap[element] ?? ""]
    }

    // MARK: Private Nested Types

    private struct RawColor: Decodable {
        let alpha: CGFloat
        let hex: String
    }

    // MARK: Private Type Properties

    private static let colorMap: [String: UIColor] = loadColorMap()

    // MARK: Private Type Methods

    private static func loadColorMap() -> [String: UIColor] {
        guard let url = Bundle.main.url(forResource: "StandardColors",
                                        withExtension: "plist"),
              let data = try? Data(contentsOf: url)
        else { return [:] }

        let decoder = PropertyListDecoder()

        guard let rawColors = try? decoder.decode([String: RawColor].self,
                                                  from: data)
        else { return [:] }

        return rawColors.mapValues { UIColor(hex: $0.hex,
                                             alpha: $0.alpha)
        }
    }

    // MARK: Private Instance Properties

    private let elementMap: [DisplayElement: String]
}
