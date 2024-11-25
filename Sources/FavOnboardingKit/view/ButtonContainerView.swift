//
//  ButtonContainerView.swift
//  FavOnboardingKit
//
//  Created by Mina Yousry on 20/11/2024.
//
import UIKit
import SnapKit

class ButtonContainerView: UIView {
    
    var nextButtonDidTapped: (()->Void)?
    var getStartedButtonDidTapped: (()->Void)?
    
    let viewTintColor: UIColor
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = viewTintColor.cgColor
        button.layer.cornerRadius = 12
        button.setTitleColor(viewTintColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("GetStarted", for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = viewTintColor
        button.layer.cornerRadius = 12
        button.layer.shadowColor = viewTintColor.cgColor
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nextButton, getStartedButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }()
    
    init(viewTintColor: UIColor) {
        self.viewTintColor = viewTintColor
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 24, left: 24, bottom: 36, right: 24))
        }
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(getStartedButton.snp.width).multipliedBy(0.5)
        }
    }
    
    @objc private func nextButtonTapped() {
        nextButtonDidTapped?()
    }
    
    @objc private func getStartedButtonTapped() {
        nextButtonDidTapped?()
    }
}
