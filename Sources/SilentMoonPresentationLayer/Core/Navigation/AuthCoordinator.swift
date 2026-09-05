import UIKit
import SilentMoonDomain
import SilentMoonNetwork
public final class AuthCoordinator: Coordinator, ContentNavigating {

    public var navigationController: UINavigationController
    public var onFlowFinished: (() -> Void)?
    
    private let repository: SilentMoonRepository

    public  init(
        navigationController: UINavigationController,
        repository: SilentMoonRepository
    ) {
        self.navigationController = navigationController
        self.repository = repository
    }

    public func start() {
        let controller = ViewController()
        controller.coordinator = self
        navigationController.setViewControllers([controller], animated: false)
    }

    public  func showLogin() {
        let viewModel = LoginViewModel(usecases: LogInUseCaseImpl(repository: repository))
        let controller = LogInViewController(viewModel: viewModel)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public func showSignUp() {
        let viewModel = SignUpViewModel(usecases: AuthUseCasesImpl(repository: repository))
        let controller = SignUpViewController(viewModel: viewModel)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public  func getStarted(name: String) {
        let controller = GetStartedController()
        controller.userName = name
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public func showOtpVerification(email: String, name: String = "") {
        let viewModel = OtpViewModel(usecases: AuthUseCasesImpl(repository: repository))
        let controller = OtpViewController(viewModel: viewModel)
        controller.email = email
        controller.userName = name
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public func showTopics() {
        let viewModel = ChooseTopicViewModel(
            usecases: TopicsUseCasesImpl(repository: repository)
        )
        let controller = ChooseTopicViewController(viewModel: viewModel)
        controller.coordinator = self
        
        navigationController.pushViewController(
            controller,
            animated: true
        )
    }
    public   func showReminder() {
        let stateModel = ReminderViewModels(
            usecases: ReminderUseCasesImpl(repository: repository)
        )
          let controller = ReminderViewController(stateModel: stateModel)
          controller.coordinator = self
          navigationController.pushViewController(controller, animated: true)
      }

    public  func showMorning() {
        let controller = CoursesDetailViewController()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public  func backToMain() {
        navigationController.popToRootViewController(animated: true)
    }

    public func finishAuth() {
        onFlowFinished?()
    }

    public func showMusicPage(item: String) {
        let controller = MusicPageController()
        controller.titleLabel = item
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public  func showMusicPage2(item: String) {
        let controller = MusicSleepPageController()
        controller.titleLabel = item
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public func showMusicList() {
        let controller = MusicListViewController()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public  func showSearchPage() {
        let viewModel = SearchViewModel(usecases: SearchUseCaseImpl(repository: repository))
        let controller = SearchPageController(viewModel: viewModel)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public  func playOptionPage() {
        let controller = PlayOptionViewController()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }

    public func dismissMusicPage() {
        navigationController.popViewController(animated: true)
    }

    public  func showSleepyStory() {
        let controller = SleepyStoryController()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}
