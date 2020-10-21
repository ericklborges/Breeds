//
//  SingleBreedView.swift
//  Breeds
//
//  Created by erick.lozano.borges on 20/09/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import SwiftUI
import WidgetKit

struct SingleBreedView: View {
    let breedName: String
    let breedImage: UIImage
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image(uiImage: breedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            VStack(alignment: .leading) {
                Spacer()
                HStack() {
                    Text(breedName)
                        .font(.headline)
                        .padding([.top, .bottom], 8)
                        .padding([.leading, .trailing], 16)
                        .foregroundColor(Color(TextColor.primary))
                    Spacer()
                }
                .background(Color(BackgroundColor.overlay))
            }
        }
    }
}

struct BreedCell_Previews: PreviewProvider {
    static var previews: some View {
        SingleBreedView(breedName: "Caramelo Dog", breedImage: UIImage(named: "caramelo_dog")!)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
