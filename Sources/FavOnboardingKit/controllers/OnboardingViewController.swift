//
//  OnboardingViewController.swift
//  FavOnboardingKit
//
//  Created by Mina Yousry on 14/11/2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    private let slides: [Slide]
    private let tintColor: UIColor
    
    private lazy var transitionView: TransitionView = {
        let view = TransitionView(slides: slides, barColor: tintColor)
        return view
    }()
    
    private lazy var buttonContainerView: ButtonContainerView = {
        let view = ButtonContainerView(viewTintColor: tintColor)
        view.nextButtonDidTapped = {
            
        }
        view.getStartedButtonDidTapped = {
            
        }
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [transitionView, buttonContainerView])
        view.axis = .vertical
        return view
    }()
    
    init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionView.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.edges.equalTo(self.view)
        }
        buttonContainerView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
}
