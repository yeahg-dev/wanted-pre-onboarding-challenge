//
//  ImageDownloader.swift
//  ConcurrencyImageDownloader
//
//  Created by Moon Yeji on 2023/02/28.
//

import UIKit

class ImageDownloader: NSObject {
    
    let imageURL: URL
    var delegate: ImageDownloaderDelegate?
    
    private var downloadTask: URLSessionDownloadTask?
    
    lazy private var session = URLSession(
        configuration: .default,
        delegate: self,
        delegateQueue: nil)
    
    init(url: URL) {
        self.imageURL = url
        super.init()
    }
    
    func startDownload() -> Progress? {
        let downloadTask = session.downloadTask(with: imageURL)
        downloadTask.resume()
        self.downloadTask = downloadTask
        return downloadTask.progress
    }
    
}

extension ImageDownloader: URLSessionDownloadDelegate, URLSessionDelegate {
    
    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didFinishDownloadingTo location: URL)
    {
        guard let httpResponse = downloadTask.response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Type[\(self)] status code 200 아님")
            return
        }

        guard let data = try? Data(contentsOf: location) else {
            print("Type[\(self)] data를 읽을 수 없음")
            return
        }
        
        guard let image = UIImage(data: data) else {
            print("Type[\(self)] UIImage 초기화 실패")
            return
        }
        delegate?.downloadTaskCompleted(result: image)
    }
    
}
