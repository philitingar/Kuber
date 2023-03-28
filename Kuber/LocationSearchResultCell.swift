//
//  LocationSearchResultCell.swift
//  Kuber
//
//  Created by Timi on 17/2/23.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title: String
    let subTitle: String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .bold()
                    .foregroundColor(.black)
                
                Text(subTitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell(title: "Starbucks", subTitle: "123 MAin St")
    }
}
