public struct StoryboardName: RawRepresentable {
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init?(rawValue: String) {
        self.rawValue = rawValue
    }

    public let rawValue: String
}
