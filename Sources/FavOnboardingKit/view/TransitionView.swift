//
//  TransitionView.swift
//  FavOnboardingKit
//
//  Created by Mina Yousry on 20/11/2024.
//

import UIKit


class TransitionView: UIView {
    
    private let slides: [Slide]
    private let barColor: UIColor
    private var timer: DispatchSourceTimer?
    private var index: Int = -1
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var barViews: [AnimatorBarView] = {
        var views: [AnimatorBarView] = []
        slides.forEach { _ in
            views.append(AnimatorBarView(barColor: barColor))
        }
        return views
    }()
    
    private lazy var barSrackView: UIStackView = {
        let stack = UIStackView()
        barViews.forEach { bar in
            stack.addArrangedSubview(bar)
        }
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var titleView: TitleView = {
        let view = TitleView()
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, titleView])
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    init(slides: [Slide], barColor: UIColor) {
        self.slides = slides
        self.barColor = barColor
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        buildTimerIfNeeded()
        timer?.resume()
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
    
    private func buildTimerIfNeeded() {
        guard timer == nil else { return }
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(wallDeadline: .now(), repeating: .seconds(3), leeway: .seconds(1))
        timer?.setEventHandler(handler: { [weak self] in
            DispatchQueue.main.async {
                self?.showNext()
            }
        })
    }
    
    private func showNext() {
        let nextImage: UIImage
        let nextTitle: String
        let nextAnimatorBarView: AnimatorBarView
        
        if slides.indices.contains(index + 1) {
            nextImage = slides[index + 1].image
            nextTitle = slides[index + 1].title
            nextAnimatorBarView = barViews[index + 1]
            index += 1
        } else {
            barViews.forEach { $0.reset() }
            nextImage = slides[0].image
            nextTitle = slides[0].title
            nextAnimatorBarView = barViews[0]
            index = 0
        }
        UIView.transition(with: imageView,
                          duration: 0.5,
                          options: [.transitionCrossDissolve]) {
            self.imageView.image = nextImage
            self.titleView.setTitle(text: nextTitle)
            nextAnimatorBarView.startAnimating()
        }
    }
    
    func layout() {
        addSubview(stackView)
        addSubview(barSrackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        barSrackView.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.top.equalTo(snp.topMargin)
            make.height.equalTo(4)
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(stackView.snp.height).multipliedBy(0.8)
        }
    }
}
