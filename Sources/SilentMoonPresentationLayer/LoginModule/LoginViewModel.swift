
import Foundation
import SilentMoonDomain
 
enum LoginViewModelState {
    case idle
    case loading
    case success
    case invalidInput(String)
    case requestFailed(DomainError)
}
 
@MainActor
public final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    private(set) var state: LoginViewModelState = .idle {
        didSet { onStateChange?() }
    }
    var onStateChange: (() -> Void)?
    
   public var onEmailNotVerified: ((_ email: String) -> Void)?
    
   public weak var navigation : LoginNavigation?
    
    private let usecases: LogInUseCase
    
    public init(usecases: LogInUseCase ) {
        self.usecases = usecases
    }
    
    
    func login() {
        if let message = FormValidator.validate([
            (email, [EmailRule()]),
            (password, [MinLengthRule(minLength: 8, fieldName: "Şifrə")])
        ]) {
            state = .invalidInput(message)
            return
        }
        state = .loading
        
        Task {
            let result = await usecases.login(email: self.email, password: self.password)
            
            handleLogin(result: result)
        }
    }
    
    func signUpTapped() {
        navigation?.showSignUp()
    }
    private func handleLogin(result: Result<AuthResponseEntity, Error>) {
        switch result {
        case .success:
            self.state = .success
            self.navigation?.finishAuth()
        case .failure(let error):
            let domainError = self.asDomainError(error)
            if domainError.code == "EMAIL_NOT_VERIFIED" {
                self.onEmailNotVerified?(self.email)
            } else {
                self.state = .requestFailed(domainError)
                
            }
        }
    }
    
    private func asDomainError(_ error: Error) -> DomainError {
        (error as? DomainError) ?? .unexpected
    }
}
 
