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
}

struct SingleBreedProvider: TimelineProvider {
    typealias Entry = SingleBreedEntry
    
    func placeholder(in context: Context) -> SingleBreedEntry {
        let entry = SingleBreedEntry(date: Date())
        return entry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SingleBreedEntry) -> Void) {
        let entry = SingleBreedEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SingleBreedEntry>) -> Void) {
        let entry = SingleBreedEntry(date: Date())
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}
