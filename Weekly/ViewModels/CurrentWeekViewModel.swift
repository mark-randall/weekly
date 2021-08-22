//
//  CurrentWeekViewModel.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//

import Foundation
import ReactiveSwift

final class CurrentWeekViewModel {
    
    // MARK: - State
    
    struct State: Equatable {
        let title: String = "My week"
        var test: String = "before"
    }
    
    enum Action {
        case buttonTapped
    }
    
    enum ViewEffect {
        case presentError
    }
    
    private(set) var state = MutableProperty(StateUpdate(current: State()))
    
    let viewEffect = Signal<ViewEffect, Error>.pipe()
    
    // MARK: - Reducer
    
    func apply(_ action: Action) {
        var stateUpdate = StateUpdate(current: state.value.current, previous: state.value.current)
        reducer(update: &stateUpdate.current, with: action, animate: &stateUpdate.isAnimated, force: &stateUpdate.force)
        state.value = stateUpdate
    }
    
    private func reducer(update state: inout State, with action: Action, animate: inout Bool, force: inout Bool) {
        switch action {
        case .buttonTapped:
            state.test = "after"
        }
    }
}
