//
//  SingleBreedProvider.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/11/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import SwiftUI
import WidgetKit

struct SingleBreedEntry: TimelineEntry {
    var date: Date
    var name: String
    var image: UIImage
}

struct SingleBreedProvider: TimelineProvider {
    typealias Entry = SingleBreedEntry
    
    func placeholder(in context: Context) -> SingleBreedEntry {
        let entry = SingleBreedEntry(date: Date(), name: String(), image: UIImage())
        return entry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SingleBreedEntry) -> Void) {
        let snapshotImage = UIImage(named: "caramelo_dog")!
        let entry = SingleBreedEntry(date: Date(), name: "Caramelo Dog", image: snapshotImage)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SingleBreedEntry>) -> Void) {
        var entries: [SingleBreedEntry] = []
        let names: [String] = ["Cachorro Caramelo", "Labradoodle", "Chihu3hu3", "Galgo Inglês", "Corgi", "Zwergspitz"]
        let carameloDogImage = UIImage(named: "caramelo_dog")!
        
        for (i, name) in names.enumerated() {
            let timeInterval = 5 * i
            let date = Calendar.current.date(byAdding: .second, value: timeInterval, to: Date())!
            let entry = SingleBreedEntry(date: date, name: name, image: carameloDogImage)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
