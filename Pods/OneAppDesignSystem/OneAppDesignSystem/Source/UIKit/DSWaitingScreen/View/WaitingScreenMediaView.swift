//
//  WaitingScreenMediaView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/2/2567 BE.
//

import UIKit
import Lottie

final class WaitingScreenMediaView: UIView {

    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()

    public var mediaType: DSWaitingScreenViewModel.ScreenMediaType! {
        didSet {
            updateLayout()
        }
    }
}

// MARK: - Private
private extension WaitingScreenMediaView {
    func updateLayout() {
        self.removeSubviews()
        switch mediaType {
        case .image(let image):
            setupSubView(imageView)
            imageView.image = image
        case .lottie(let filename, let bundle):
            let animationView = AnimationView(name: filename, bundle: bundle)
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.backgroundBehavior = .pauseAndRestore
            setupSubView(animationView)
            animationView.play()

        case .url(let url, let placeholder, let cacheable):
            setupSubView(imageView)
            imageView.setImage(with: url, placeHolder: placeholder, cacheable: cacheable)
        case .none:
            break
        }
    }

    func setupSubView(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leftAnchor.constraint(equalTo: self.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.rightAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
