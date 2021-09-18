import Foundation

public class Theme {

    // MARK: Public Nested Types

    public enum Name: String {
        case daytime = "DaytimeTheme"
        case evening = "EveningTheme"
        case sunrise = "SunriseTheme"
        case sunset  = "SunsetTheme"
    }

    // MARK: Public Type Properties

    public static let daytime = Theme(.daytime)
    public static let evening = Theme(.evening)
    public static let sunrise = Theme(.sunrise)
    public static let sunset = Theme(.sunset)

    // MARK: Public Instance Properties

    public let colors: ColorFactory
    public let fonts: FontFactory
    public let name: Name

    // MARK: Private Nested Types

    private struct RawNames: Decodable {
        let color: String?
        let font: String?
    }

    // MARK: Private Type Methods

    private static func extractColorElementMap(_ rawMap: [String: RawNames]) -> [DisplayElement: String] {
        var tmpMap: [DisplayElement: String] = [:]

        for (key, value) in rawMap {
            guard let element = DisplayElement(rawValue: key),
                  let colorName = value.color
            else { continue }

            tmpMap[element] = colorName
        }

        return tmpMap
    }

    private static func extractFontElementMap(_ rawMap: [String: RawNames]) -> [DisplayElement: String] {
        var tmpMap: [DisplayElement: String] = [:]

        for (key, value) in rawMap {
            guard let element = DisplayElement(rawValue: key),
                  let fontName = value.font
            else { continue }

            tmpMap[element] = fontName
        }

        return tmpMap
    }

    private static func loadRawMap(_ name: Name) -> [String: RawNames] {
        guard let url = Bundle.main.url(forResource: name.rawValue,
                                        withExtension: "plist"),
              let data = try? Data(contentsOf: url)
        else { return [:] }

        let decoder = PropertyListDecoder()

        guard let rawMap = try? decoder.decode([String: RawNames].self,
                                               from: data)
        else { return [:] }

        return rawMap
    }

    // MARK: Private Initializers

    private init(_ name: Name) {
        let rawMap = Theme.loadRawMap(name)

        self.colors = ColorFactory(Theme.extractColorElementMap(rawMap))
        self.fonts = FontFactory(Theme.extractFontElementMap(rawMap))
        self.name = name
    }
}
