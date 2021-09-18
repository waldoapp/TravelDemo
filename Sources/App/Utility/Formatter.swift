import CoreLocation
import UIKit

public enum Formatter {

    // MARK: Public Type Methods

    public static func formatDecimal(_ value: Double,
                                     minimumFractionDigits: Int = 0,
                                     maximumFractionDigits: Int = 3) -> String {
        formatDecimal(NSNumber(value: value),
                      minimumFractionDigits: minimumFractionDigits,
                      maximumFractionDigits: maximumFractionDigits)
    }

    public static func formatDecimal(_ value: NSNumber,
                                     minimumFractionDigits: Int = 0,
                                     maximumFractionDigits: Int = 3) -> String {
        decimalFormatter.maximumFractionDigits = maximumFractionDigits
        decimalFormatter.minimumFractionDigits = minimumFractionDigits

        return decimalFormatter.string(from: value) ?? "\(value)"
    }

    public static func formatInteger(_ value: Int) -> String {
        formatInteger(NSNumber(value: value))
    }

    public static func formatInteger(_ value: NSNumber) -> String {
        integerFormatter.string(from: value) ?? "\(value)"
    }

    public static func formatLocationCoordinate2D(_ value: CLLocationCoordinate2D) -> String {
        guard CLLocationCoordinate2DIsValid(value)
        else { return "Invalid" }

        let lng = _formatLocationDegrees(value.longitude,
                                         directions: (pos: "E", neg: "W"))
        let lat = _formatLocationDegrees(value.latitude,
                                         directions: (pos: "N", neg: "S"))

        return "\(lat) \(lng)"
    }

    // MARK: Private Type Properties

    private static var decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true

        return formatter
    }()

    private static var integerFormatter: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.locale = .current
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true

        return formatter
    }()

    // MARK: Private Type Methods

    private static func _formatLocationDegrees(_ value: CLLocationDegrees,
                                               directions: (pos: String, neg: String)) -> String {
        let rawDegrees = value.degrees
        let degrees = formatInteger(abs(rawDegrees))
        let minutes = formatInteger(value.minutes)
        let seconds = formatDecimal(value.seconds,
                                    maximumFractionDigits: 1)
        let direction = rawDegrees > 0
            ? directions.pos
            : rawDegrees < 0
            ? directions.neg
            : ""

        return "\(degrees)°\(minutes)′\(seconds)″\(direction)"
    }
}
