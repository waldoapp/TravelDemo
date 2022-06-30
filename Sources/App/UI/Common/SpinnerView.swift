import UIKit

public class SpinnerView: UIView {

    // MARK: Public Nested Types

    public enum LabelPosition {
        case none
        case top
        case left
        case bottom
        case right
    }

    // MARK: Public Instance Properties

    public var backgroundAlpha: CGFloat {
        get { backgroundView.alpha }
        set { backgroundView.alpha = newValue }
    }

    public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    public var indicatorColor: UIColor {
        get { indicatorView.color }
        set { indicatorView.color = newValue }
    }

    public var indicatorStyle: UIActivityIndicatorView.Style {
        get { indicatorView.style }
        set { indicatorView.style = newValue; setNeedsLayout() }
    }

    public var isAnimating: Bool {
        indicatorView.isAnimating
    }

    public var labelFont: UIFont {
        get { label.font }
        set { label.font = newValue; setNeedsLayout() }
    }

    public var labelGap: CGFloat {
        didSet { setNeedsLayout() }
    }

    public var labelPosition: LabelPosition {
        didSet { setNeedsLayout() }
    }

    public var labelText: String? {
        get { label.text }
        set { label.text = newValue; setNeedsLayout() }
    }

    public var labelTextColor: UIColor {
        get { label.textColor }
        set { label.textColor = newValue }
    }

    public var padding: CGFloat {
        didSet { setNeedsLayout() }
    }

    // MARK: Public Instance Methods

    public func startAnimating() {
        isHidden = false

        indicatorView.startAnimating()
    }

    public func stopAnimating() {
        indicatorView.stopAnimating()

        isHidden = true
    }

    // MARK: Private Instance Properties

    private let defaultBackgroundAlpha = CGFloat(0.6)
    private let defaultCornerRadius = CGFloat(6)
    private let defaultLabelGap = CGFloat(0)
    private let defaultPadding = CGFloat(20)

    private let backgroundView: UIView
    private let indicatorView: UIActivityIndicatorView
    private let label: UILabel

    private var hasLabel: Bool {
        guard let text = label.text
        else { return false }

        return !text.isEmpty
            && labelPosition != .none
    }

    // MARK: Private Instance Methods

    private func _sharedConfiguration() {
        backgroundColor = .clear
        clipsToBounds = true
        isHidden = true
        isUserInteractionEnabled = false   // for now ...

        layer.cornerRadius = defaultCornerRadius
        layer.masksToBounds = true

        backgroundView.alpha = defaultBackgroundAlpha
        backgroundView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        backgroundView.backgroundColor = .black
        backgroundView.frame = bounds.standardized
        backgroundView.isUserInteractionEnabled = false

        addSubview(backgroundView)

        indicatorView.autoresizingMask = []
        indicatorView.hidesWhenStopped = false
        indicatorView.isUserInteractionEnabled = false

        addSubview(indicatorView)

        label.autoresizingMask = []
        label.backgroundColor = .clear
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.textColor = .white
        label.isUserInteractionEnabled = false

        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2

        addSubview(label)

        setNeedsLayout()
    }

    // MARK: Overridden UIView Initializers

    override public init(frame: CGRect) {
        self.backgroundView = UIView(frame: .zero)
        self.indicatorView = UIActivityIndicatorView(style: .large)
        self.label = UILabel(frame: .zero)
        self.labelGap = defaultLabelGap
        self.labelPosition = .bottom
        self.padding = defaultPadding

        super.init(frame: frame)

        _sharedConfiguration()
    }

    // MARK: Overridden UIView Methods

    override public func layoutSubviews() {
        super.layoutSubviews()

        let bSize = bounds.size

        var ivFrame: CGRect = .zero
        var lFrame: CGRect = .zero

        ivFrame.size = indicatorView.sizeThatFits(bSize)
        ivFrame.origin.x = floor((bSize.width - ivFrame.width) / 2)
        ivFrame.origin.y = floor((bSize.height - ivFrame.height) / 2)

        if hasLabel {
            lFrame.size = label.sizeThatFits(bSize)
            lFrame.origin.x = floor((bSize.width - lFrame.width) / 2)
            lFrame.origin.y = floor((bSize.height - lFrame.height) / 2)

            switch labelPosition {
            case .bottom:
                ivFrame.origin.y = floor((bSize.height - (ivFrame.height + labelGap + lFrame.height)) / 2)

                lFrame.origin.y = ivFrame.maxY + labelGap

            case .left:
                lFrame.origin.x = floor((bSize.width - (lFrame.width + labelGap + ivFrame.width)) / 2)

                ivFrame.origin.x = lFrame.maxX + labelGap

            case .right:
                ivFrame.origin.x = floor((bSize.width - (ivFrame.width + labelGap + lFrame.width)) / 2)

                lFrame.origin.x = ivFrame.maxX + labelGap

            case .top:
                lFrame.origin.y = floor((bSize.height - (lFrame.height + labelGap + ivFrame.height)) / 2)

                ivFrame.origin.y = lFrame.maxY + labelGap

            default :
                break
            }
        }

        indicatorView.frame = ivFrame
        label.frame = lFrame
    }

    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        let ivSize = indicatorView.sizeThatFits(size)
        let tmpPadding = padding * 2

        if hasLabel {
            let lSize = label.sizeThatFits(size)

            switch labelPosition {
            case .bottom,
                 .top:
                return CGSize(width: max(ivSize.width, lSize.width) + tmpPadding,
                              height: ivSize.height + labelGap + lSize.height + tmpPadding)

            case .left,
                 .right:
                return CGSize(width: ivSize.width + labelGap + lSize.width + tmpPadding,
                              height: max(ivSize.height, lSize.height) + tmpPadding)

            default:
                return size
            }
        } else {
            return CGSize(width: ivSize.width + tmpPadding,
                          height: ivSize.height + tmpPadding)
        }
    }

    // MARK: Overridden NSCoding Initializers

    public required init?(coder: NSCoder) {
        self.backgroundView = UIView(frame: .zero)
        self.indicatorView = UIActivityIndicatorView(style: .large)
        self.label = UILabel(frame: .zero)
        self.labelGap = defaultLabelGap
        self.labelPosition = .bottom
        self.padding = defaultPadding

        super.init(coder: coder)

        _sharedConfiguration()
    }
}
