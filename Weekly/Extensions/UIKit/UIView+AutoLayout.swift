//
//  UIView+AutoLayout.swift
//  NewsFeed
//
//  Created by Mark Randall on 6/23/21.
//

import UIKit

extension UIView {
    
    @discardableResult
    static func createConstraints(
        visualFormatting: [String],
        views: [String: UIView],
        activateCreatedConstraints: Bool = true
    ) -> [NSLayoutConstraint] {

        views.values.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = visualFormatting.flatMap {
            NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: views)
        }

        if activateCreatedConstraints {
            constraints.forEach { $0.isActive = true }
        }

        return constraints
    }
    
    @discardableResult
    func pinToSuperview(withEdgeInsets edgeInsets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        guard let superview = superview else { return [] }

        return apply(constraints: [
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: edgeInsets.left),
            superview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: edgeInsets.right),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: edgeInsets.top),
            superview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInsets.bottom)
        ])
    }
    
    @discardableResult
    func pinToCenter(of view: UIView) -> [NSLayoutConstraint] {
        return apply(constraints: [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func apply(constraints: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
