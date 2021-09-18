public enum ViewModelFactory {

    // MARK: Public Type Methods

    public static func onboarding(_ step: Int) -> OnboardingViewModel {
        OnboardingViewModel(step)
    }

    public static func profile() -> ProfileViewModel {
        ProfileViewModel()
    }

    public static func signIn(_ registered: Bool) -> SignInViewModel {
        SignInViewModel(registered)
    }

    public static func spotList() -> SpotListViewModel {
        SpotListViewModel()
    }

    public static func spot(/* _ spot: Spot */) -> SpotViewModel {
        SpotViewModel()
    }

    public static func welcome() -> WelcomeViewModel {
        WelcomeViewModel()
    }
}
