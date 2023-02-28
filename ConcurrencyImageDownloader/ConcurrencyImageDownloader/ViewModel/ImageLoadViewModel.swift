//
//  ImageLoadViewModel.swift
//  ConcurrencyImageDownloader
//
//  Created by Moon Yeji on 2023/02/28.
//

import UIKit

class ImageLoadViewModel {
    
    let updateHandler: ((UIImage?) -> Void)
    
    private let imageURL: URL
    private let defaultImage = UIImage(systemName: "photo.fill")
    
    private lazy var downloader: ImageDownloader = {
        let downloader = ImageDownloader(url: imageURL)
        downloader.delegate = self
        return downloader
    }()
    
    init(
        updateHandler: @escaping (UIImage?) -> Void,
        imageURL: URL)
    {
        self.updateHandler = updateHandler
        self.imageURL = imageURL
    }
    
    func startLoadImage() -> Progress? {
        return downloader.startDownload()
    }
    
}

extension ImageLoadViewModel: ImageDownloaderDelegate {
    
    func downloadTaskCompleted(result: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.updateHandler(result)
        }
    }
    
}
