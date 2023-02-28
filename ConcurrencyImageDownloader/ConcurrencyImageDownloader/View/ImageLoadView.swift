//
//  ImageLoadView.swift
//  ConcurrencyImageDownloader
//
//  Created by Moon Yeji on 2023/02/28.
//

import UIKit

class ImageLoadView: UIView {
    
    private let viewModel: ImageLoadViewModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .systemGray
        progressView.progressTintColor = .systemYellow
        return progressView
    }()
    
    private let loadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load", for: .normal)
        button.backgroundColor = Design.loadButtonColor
        button.addTarget(
            self,
            action: #selector(loadButtonDidTapped),
            for: .touchDown)
        button.layer.cornerRadius = 8
        return button
    }()
    
    init(viewModel: ImageLoadViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        imageView.image = viewModel.defaultImage
        viewModel.updateHandler = { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    @objc
    func loadButtonDidTapped() {
        imageView.image = viewModel.defaultImage
        progressView.observedProgress = viewModel.startLoadImage()
    }
    
    private func configureLayout() {
        let layoutGuide = UILayoutGuide()
        self.addLayoutGuide(layoutGuide)
        self.addSubview(imageView)
        self.addSubview(progressView)
        self.addSubview(loadButton)
        
        NSLayoutConstraint.activate([
            layoutGuide.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: Design.padding),
            layoutGuide.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Design.padding),
            layoutGuide.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -Design.padding),
            layoutGuide.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -Design.padding),
            imageView.leadingAnchor.constraint(
                equalTo: layoutGuide.leadingAnchor),
            imageView.centerYAnchor.constraint(
                equalTo: layoutGuide.centerYAnchor),
            imageView.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: Design.imageViewWidthMultiplier),
            imageView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: Design.imageViewHeightMultiplier),
            progressView.centerYAnchor.constraint(
                equalTo: layoutGuide.centerYAnchor),
            progressView.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: Design.margin),
            progressView.trailingAnchor.constraint(
                equalTo: loadButton.leadingAnchor,
                constant: -Design.margin),
            loadButton.widthAnchor.constraint(
                equalToConstant: Design.loadButtonWidth),
            loadButton.heightAnchor.constraint(
                equalToConstant: Design.loadButtonHeight),
            loadButton.centerYAnchor.constraint(
                equalTo: layoutGuide.centerYAnchor),
            loadButton.trailingAnchor.constraint(
                equalTo: layoutGuide.trailingAnchor)
        ])
        
    }
    
}

private enum Design {
    
    static let loadButtonColor: UIColor = .systemYellow
    
    static let imageViewWidthMultiplier: CGFloat = 0.3
    static let imageViewHeightMultiplier: CGFloat = 1.0
    static let loadButtonWidth: CGFloat = 80
    static let loadButtonHeight: CGFloat = 40
    
    static let padding: CGFloat = 10
    static let margin: CGFloat = 7
    
}
