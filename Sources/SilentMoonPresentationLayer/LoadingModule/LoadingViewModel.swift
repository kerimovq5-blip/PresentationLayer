
import Foundation
import SilentMoonDomain

enum LoadingViewModelState {
   case idle
   case loading
   case loaded
   case requestFailed(DomainError)
}

@MainActor
public final class LoadingViewModel {

   private(set) var state: LoadingViewModelState = .idle {
       didSet { onStateChange?() }
   }

   var onStateChange: (() -> Void)?
  public var onError: ((DomainError) -> Bool)?

   private let action: () async -> Result<Void, Error>
   private var loadTask: Task<Void, Never>?

   public init(action: @escaping () async -> Result<Void, Error>) {
       self.action = action
   }

   func load() {
       loadTask?.cancel()
       state = .loading
       loadTask = Task {
           let result = await self.action()
           guard !Task.isCancelled else { return }
           handleLoad(result: result)
       }
   }
   private func handleLoad(result: Result<Void, Error>) {
       switch result {
       case .success:
           self.state = .loaded
       case .failure(let error):
           let appError = self.asDomainError(error)
           if self.onError?(appError) == true {
               self.state = .idle
           } else {
               self.state = .requestFailed(appError)
           }
       }
   }

   private func asDomainError(_ error: Error) -> DomainError {
       (error as? DomainError) ?? .unexpected
   }
}
