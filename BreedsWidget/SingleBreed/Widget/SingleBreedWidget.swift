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
        .configurationDisplayName("Random breed")
        .description("This widget provides a random breed that changes overtime.")
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}

struct SingleBreedEntryView: View {
    var entry: SingleBreedProvider.Entry
    
    var body: some View {
        SingleBreedView(breedName: entry.name, breedImage: entry.image)
    }
}

struct BreedsWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        let entry = SingleBreedEntry(
            date: Date(),
            name: "Cachorro Caramelo",
            image: UIImage(named: "caramelo_dog")!
        )
        
        Group {
            SingleBreedEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            SingleBreedEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
