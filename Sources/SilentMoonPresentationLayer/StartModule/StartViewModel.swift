//
//  StartViewModel.swift
//  PresentationLayer
//
//  Created by Kerimov Qehreman on 06.09.26.
//

import Foundation
@MainActor
 public final class StartViewModel {
     public weak var navigation : StartNavigation?
    
    func singUpTap() {
        navigation?.showSignUp()
    }
    func logInTapped() {
        navigation?.showLogin()
    }
}
