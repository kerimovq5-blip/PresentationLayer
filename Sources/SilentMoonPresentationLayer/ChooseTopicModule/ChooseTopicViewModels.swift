import Foundation
import SilentMoonDomain
 
@MainActor
enum ChooseTopicViewModelState {
    case idle
    case loading
    case success
    case invalidInput(String)
    case requestFailed(DomainError)
}
 
@MainActor
public final class ChooseTopicViewModel {
    
    private(set) var state: ChooseTopicViewModelState = .idle {
        didSet {
            onStateChange?()
        }
    }
    
    var onStateChange: (() -> Void)?
    
    public  weak var navigation: ChooseTopicNavigation?
    
    private let usecases: TopicsUseCases
    
   public init(usecases: TopicsUseCases) {
        self.usecases = usecases
    }
    
    func choose(topicIds: [Int]) {
        
        guard !topicIds.isEmpty else {
            state = .invalidInput(AppStrings.emptyTopicSelectionError.letters)
            return
        }
        state = .loading
        Task {
            let result = await usecases.updateTopics(topicIds: topicIds)
            handleChooseTopic(result: result)
        }
    }
    
    private func handleChooseTopic(result: Result<[ChooseTopicEntity], any Error>) {
        switch result {
        case .success:
            self.state = .success
            self.navigation?.showReminder()
        case .failure(let error):
            let appError = self.asDomainError(error)
            self.state = .requestFailed(appError)
        }
    }
    
    private func asDomainError(_ error: Error) -> DomainError {
        (error as? DomainError) ?? .unexpected
    }
}
 
