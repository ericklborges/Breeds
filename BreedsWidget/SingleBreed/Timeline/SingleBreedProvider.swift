//
//  SingleBreedProvider.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/10/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import SwiftUI
import WidgetKit
import class Kingfisher.KingfisherManager

struct SingleBreedEntry: TimelineEntry {
    let date: Date
    let id: String
    let name: String
    let image: UIImage
}

struct SingleBreedProvider: TimelineProvider {
    typealias Entry = SingleBreedEntry
    
    private let api = BreedImagesAPI()
    private let imageDownloadGroup = DispatchGroup()
    
    private let entryDuration: Int = 5
    private let pageItemsLimit: Int = 53
    private var page: Int {
        return .random(in: 0...2)
    }
    
    func placeholder(in context: Context) -> SingleBreedEntry {
        return SingleBreedEntry(date: Date(), id: "id", name: "placeholder", image: UIImage())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SingleBreedEntry) -> Void) {
        let snaoshotImage = UIImage(named: "caramelo_dog")!
        let snapshotEntry = SingleBreedEntry(date: Date(), id: "id", name: "Caramelo Dog", image: snaoshotImage)
        completion(snapshotEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SingleBreedEntry>) -> Void) {
        fetchEntries { entries in
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

// MARK: - Networking

extension SingleBreedProvider {
    
    private func fetchEntries(completion: @escaping ([SingleBreedEntry]) -> Void) {
        var entries: [SingleBreedEntry] = []
        
        fetchBreedImages { breedImages in
            
            breedImages.enumerated().forEach { i, breedImage in
                guard
                    let date = Calendar.current.date(byAdding: .second, value: entryDuration*i, to: Date()),
                    let breedName = breedImage.breeds.first?.name,
                    let imageUrl = URL(string: breedImage.url)
                else { return }
                
                imageDownloadGroup.enter()
                downloadImage(from: imageUrl) { downloadedImage in
                    let entry = SingleBreedEntry(date: date, id: breedImage.id, name: breedName, image: downloadedImage)
                    entries.append(entry)
                    imageDownloadGroup.leave()
                }
            }
            
            imageDownloadGroup.notify(queue: .main) {
                completion(entries)
            }
        }
    }
    
    private func fetchBreedImages(completion: @escaping ([BreedImage]) -> Void) {
        api.fetchImages(limit: pageItemsLimit, page: page) { result in
            switch result {
            case let .success(breedImages):
                let suffled = breedImages.shuffled()
                let firstTenSuffled = Array(suffled[0...10])
                completion(firstTenSuffled)
            case let .failure(error):
                print("Error: failed to request breed images \(error)")
            }
        }
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage) -> Void) {
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case let .success(imageResult):
                let downloadedImage = imageResult.image
                completion(downloadedImage)
            case let .failure(error):
                print("Error: failed to download the image \(error)")
            }
        }
    }
}
