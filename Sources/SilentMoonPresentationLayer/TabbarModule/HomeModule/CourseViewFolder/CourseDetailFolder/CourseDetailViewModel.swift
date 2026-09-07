
import Foundation
import SilentMoonDomain
 
@MainActor
enum CourseDetailViewModelState {
    case idle
    case loading
    case loaded
    case requestFailed(DomainError)
}
 
@MainActor
public final class CourseDetailViewModel {
    
    private(set) var state: CourseDetailViewModelState = .idle {
        didSet {
            onStateChange?()
        }
    }
    
    private(set) var selectedCourseDetail: CourseEntity?
    var onStateChange: (() -> Void)?
    
    private let repository: SilentMoonRepository
    
    public init(repository: SilentMoonRepository) {
        self.repository = repository
    }
    
    public func fetchCourseDetail(id: Int) {
        state = .loading
        
        Task { [weak self] in
            guard let self else { return }
            
            let result = await self.repository.getCourseDetail(id: id)
            
            switch result {
            case .success(let courseDetail):
                self.selectedCourseDetail = courseDetail
                self.state = .loaded
            case .failure(let error):
                let appError = self.asDomainError(error)
                self.state = .requestFailed(appError)
            }
        }
    }
    
    private func asDomainError(_ error: Error) -> DomainError {
        (error as? DomainError) ?? .unexpected
    }
}
