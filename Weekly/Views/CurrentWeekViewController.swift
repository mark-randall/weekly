//
//  CurrentWeekViewController.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//

import UIKit
import ReactiveSwift

final class CurrentWeekViewController: UIViewController {

    // MARK: - State
    
    private let viewModel: CurrentWeekViewModel
    
    private var disposeBag = CompositeDisposable()
    
    // MARK: - Subviews
    
    private lazy var testButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 44, height: 44))
        button.setTitle("Test", for: .normal)
        button.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
        return button

    }()
    
    // MARK: - Init
    
    init(viewModel: CurrentWeekViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        
        viewModel.state.producer.start(on: UIScheduler()).startWithValues { action in
            print(action)
        }
    }
    
    func addSubviews() {
        view.addSubview(testButton)
    }
    
    // MARK: - Actions
    
    @objc private func testButtonTapped() {
        viewModel.apply(.buttonTapped)
    }
}
