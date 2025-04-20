//
//  ImageCacheTests.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import XCTest
@testable import Presentation

final class ImageCacheTests: XCTestCase {
    
    var cache: ImageCache!
    var sampleURL: URL!
    var sampleImage: UIImage!
    
    override func setUp() {
        super.setUp()
        cache = ImageCache()
        sampleURL = URL(string: "https://avatars.githubusercontent.com/u/109?v=4")!
        sampleImage = UIImage(systemName: "star")!
    }
    
    override func tearDown() {
        cache = nil
        sampleURL = nil
        sampleImage = nil
        super.tearDown()
    }
    
    func test_insertAndRetrieveImage_success() {
        cache.insertImage(sampleImage, for: sampleURL, withExpiry: 60)
        let cachedImage = cache.image(for: sampleURL)
        
        XCTAssertNotNil(cachedImage)
        XCTAssertEqual(cachedImage?.pngData(), sampleImage.pngData())
    }
    
    func test_expiredImage_shouldReturnNil() {
        cache.insertImage(sampleImage, for: sampleURL, withExpiry: -1) // Expired
        let cachedImage = cache.image(for: sampleURL)
        
        XCTAssertNil(cachedImage)
    }
    
    func test_imageIsNilIfNotCached() {
        let uncachedURL = URL(string: "https://avatars.githubusercontent.com/u/109?v=5")!
        let cachedImage = cache.image(for: uncachedURL)
        
        XCTAssertNil(cachedImage)
    }
}
