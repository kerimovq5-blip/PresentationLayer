//
//  GetStartedViewModel.swift
//  PresentationLayer
//
//  Created by Kerimov Qehreman on 06.09.26.
//

import Foundation
@MainActor
final class GetStartedViewModel {
    weak var navigation : GetStartedNavigation?
    
    func logOutTapped() {
        navigation?.backToMain()
    }
    func getStartedTapped() {
        navigation?.showTopics()
    }
}
