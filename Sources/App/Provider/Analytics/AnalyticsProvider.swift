import Firebase

public class AnalyticsProvider: Provider {

    // MARK: Public Instance Methods

    public func sendEvent(name: String,
                          parameters: [String: Any]) {
        Firebase.Analytics.logEvent(name,
                                    parameters: parameters)
    }

    public func trackActionFailed(_ action: String,
                                  name: String,
                                  reason: String) {
        sendEvent(name: "action_failed",
                  parameters: ["action": action,
                               "category": "action",
                               "name": name,
                               "reason": reason])
    }

    public func trackActionRequested(_ action: String,
                                     name: String) {
        sendEvent(name: "action_requested",
                  parameters: ["action": action,
                               "category": "action",
                               "name": name])
    }

    public func trackActionSucceeded(_ action: String,
                                     name: String) {
        sendEvent(name: "action_succeeded",
                  parameters: ["action": action,
                               "category": "action",
                               "name": name])
    }

    public func trackUIButtonTapped(_ control: String,
                                    screen: String) {
        sendEvent(name: "button_tapped",
                  parameters: ["button": control,
                               "category": "UI",
                               "screen": screen])
    }

    // MARK: Overridden Provider Initializers

    override internal init(delegate: ProviderDelegate) {
        _ = FirebaseServices.shared     // just need the side effect

        super.init(delegate: delegate)
    }
}
