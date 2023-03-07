//
//  ImageLoadViewModel.swift
//  ConcurrencyImageDownloader
//
//  Created by Moon Yeji on 2023/02/28.
//

import UIKit

class ImageLoadViewModel {
    
    var updateHandler: ((UIImage?) -> Void)?
    let defaultImage = UIImage(systemName: "photo.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    
    private let imageURL: URL
    
    private lazy var downloader: ImageDownloader = {
        let downloader = ImageDownloader(url: imageURL)
        downloader.delegate = self
        return downloader
    }()
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    func startLoadImage() -> (URLSessionDownloadTask?, Progress?) {
        return downloader.startDownload()
    }
    
}

extension ImageLoadViewModel: ImageDownloaderDelegate {
    
    func downloadTaskCompleted(result: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.updateHandler?(result)
        }
    }
    
}
