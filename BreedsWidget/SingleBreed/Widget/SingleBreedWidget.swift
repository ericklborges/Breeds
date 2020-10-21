//
//  SingleBreedWidget.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/10/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import SwiftUI
import WidgetKit

@main
struct SingleBreedWidget: Widget {
    let kind: String = "SingleBreedWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SingleBreedProvider()) { entry in
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
            .widgetURL(Deeplink.detail(breedImageId: entry.id).url)
    }
}

struct BreedsWidget_Previews: PreviewProvider {
    static var previews: some View {
        let entry = SingleBreedEntry(
            date: Date(),
            id: "id",
            name: "Preview Dog",
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
