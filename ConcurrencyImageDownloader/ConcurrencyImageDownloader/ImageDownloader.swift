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
        
        do {
            let documentsURL = try
            FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
            let savedURL = documentsURL.appendingPathComponent(
                location.lastPathComponent)
            
            let data = try Data(contentsOf: savedURL)
            
            guard let image = UIImage(data: data) else {
                print("Type[\(self)] UIImage 초기화 실패")
                return
            }
            delegate?.downloadTaskCompleted(result: image)
        } catch {
            print("Type[\(self)] File System에서 url을 읽어오지 못하거나 Data 초기화 실패")
        }
    }
    
    
}
