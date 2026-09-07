import Foundation
import SilentMoonDomain
 
@MainActor
enum SearchViewModelState {
    case idle
    case loading
    case loaded
    case empty
    case requestFailed(DomainError)
}
 
@MainActor
public final class SearchViewModel {
 
    private(set) var state: SearchViewModelState = .idle {
        didSet { onStateChange?() }
    }
 
    private(set) var results: [CourseSummaryEntity] = [] {
        didSet { onResultsChange?() }
    }
 
    var onStateChange: (() -> Void)?
    public  var onResultsChange: (() -> Void)?
 
    private let usecases: SearchUseCases
    private var currentRequestID = 0
    private var searchDebounceTimer: Timer?
 
    public  init(usecases: SearchUseCases) {
        self.usecases = usecases
    }
 
    func search(query: String) {
        searchDebounceTimer?.invalidate()
 
        guard query.trimmingCharacters(in: .whitespaces).count >= 2 else {
            currentRequestID += 1
            results = []
            state = .idle
            return
        }
 
        searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.performSearch(query: query)
            }
        }
    }
 
    private func performSearch(query: String) {
        currentRequestID += 1
        let requestID = currentRequestID
        state = .loading
 
        Task {
            let result = await usecases.search(
                query: query,
                type: nil,
                page: 1,
                limit: 20
            )
 
            guard requestID == self.currentRequestID else { return }
 
            switch result {
            case .success(let response):
                self.results = response.data
                self.state = response.data.isEmpty ? .empty : .loaded
            case .failure(let error):
                self.results = []
                self.state = .requestFailed(self.asDomainError(error))
            }
        }
    }
    
    private func asDomainError(_ error: Error) -> DomainError {
        (error as? DomainError) ?? .unexpected
    }
}
