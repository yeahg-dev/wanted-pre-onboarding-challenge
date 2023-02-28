//
//  ViewController.swift
//  ConcurrencyImageDownloader
//
//  Created by Moon Yeji on 2023/02/28.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageLoadView1 = ImageLoadView(
        viewModel: ImageLoadViewModel(imageURL: CuteAnimalURL.cuteCat))
    private let imageLoadView2 = ImageLoadView(
        viewModel: ImageLoadViewModel(imageURL: CuteAnimalURL.focusingCat))
    private let imageLoadView3 = ImageLoadView(
        viewModel: ImageLoadViewModel(imageURL: CuteAnimalURL.happyDog))
    private let imageLoadView4 = ImageLoadView(
        viewModel: ImageLoadViewModel(imageURL: CuteAnimalURL.restingCat))
    private let imageLoadView5 = ImageLoadView(
        viewModel: ImageLoadViewModel(imageURL: CuteAnimalURL.thumbsUpCat))
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [imageLoadView1, imageLoadView2, imageLoadView3,
                               imageLoadView4, imageLoadView5])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let loadAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load All Images", for: .normal)
        button.backgroundColor = Design.loadAllButtonColor
        button.addTarget(
            self,
            action: #selector(loadAllButtonDidTapped),
            for: .touchDown)
        button.layer.cornerRadius = 7
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
    }
    
    private func configureLayout() {
        view.addSubview(stackView)
        view.addSubview(loadAllButton)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Design.paddingLeading),
            stackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Design.paddingTop),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Design.paddingTrailing),
            stackView.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: Design.stackViewHeightMultiplier),
            loadAllButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            loadAllButton.widthAnchor.constraint(equalToConstant: Design.loadAllButtonWidth),
            loadAllButton.heightAnchor.constraint(
                equalToConstant: Design.loadAllButtonHeight),
            loadAllButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -Design.paddingBottom)
        ])
    }
    
    @objc
    private func loadAllButtonDidTapped() {
        guard let imageLoadViews = stackView.arrangedSubviews as? [ImageLoadView] else {
        return
        }
        imageLoadViews.forEach { view in
            view.loadButtonDidTapped()
        }
    }
    
}

private enum Design {
    
    static let loadAllButtonColor: UIColor = .systemYellow
    
    static let loadAllButtonHeight: CGFloat = 60
    static let loadAllButtonWidth: CGFloat = 230
    static let stackViewHeightMultiplier: CGFloat = 0.7
    
    static let paddingLeading: CGFloat = 20
    static let paddingTrailing: CGFloat = 20
    static let paddingTop: CGFloat = 80
    static let paddingBottom: CGFloat = 40
    
}
