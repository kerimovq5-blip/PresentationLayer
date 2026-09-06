//
//  StartViewModel.swift
//  PresentationLayer
//
//  Created by Kerimov Qehreman on 06.09.26.
//

import Foundation
@MainActor
 final class StartViewModel {
    weak var navigation : StartNavigation?
    
    func singUpTap() {
        navigation?.showSignUp()
    }
    func logInTapped() {
        navigation?.showLogin()
    }
}
