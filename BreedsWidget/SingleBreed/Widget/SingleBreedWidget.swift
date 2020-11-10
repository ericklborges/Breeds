//
//  SingleBreedWidget.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/11/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import SwiftUI
import WidgetKit

@main
struct SingleBreedWidget: Widget {

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "SingleBreedWidget", provider: SingleBreedProvider()) { entry in
            SingleBreedEntryView(entry: entry)
        }
    }
}

struct SingleBreedEntryView: View {
    var entry: SingleBreedProvider.Entry
    
    var body: some View {
        SingleBreedView(breedName: entry.name, breedImage: entry.image)
    }
}