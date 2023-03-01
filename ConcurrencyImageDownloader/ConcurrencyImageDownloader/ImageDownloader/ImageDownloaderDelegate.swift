//
//  ImageDownloaderDelegate.swift
//  ConcurrencyImageDownloader
//
//  Created by Moon Yeji on 2023/02/28.
//

import UIKit

protocol ImageDownloaderDelegate {
    
    func downloadTaskCompleted(result: UIImage?)
    
}
