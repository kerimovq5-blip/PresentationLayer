//
//  GetStartedViewModel.swift
//  PresentationLayer
//
//  Created by Kerimov Qehreman on 06.09.26.
//

import Foundation
@MainActor
public final class GetStartedViewModel {
    public  weak var navigation : GetStartedNavigation?
    
    public init () {
        
    }
    func logOutTapped() {
        navigation?.backToMain()
    }
    func getStartedTapped() {
        navigation?.showTopics()
    }
}
