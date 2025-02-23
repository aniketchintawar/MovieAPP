//
//  CategoryTabView.swift
//  MovieApp
//
//  Created by Aniket Chintawar on 22/02/25.
//

import SwiftUI

struct CategoryTabView: View {
    @Binding var selectedCategory: String
    let categories: [String]
    let onCategorySelected: (String) -> Void  // Callback function
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(categories, id: \.self) { category in
                        VStack {
                            Text(category)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .frame(width: categories.count <= 2 ? (geometry.size.width / CGFloat(categories.count)) - 20 : nil)
                                .onTapGesture {
                                    selectedCategory = category
                                    onCategorySelected(category)  // API call when category changes
                                }
                            
                            if selectedCategory == category {
                                Divider()
                                    .frame(height: 2)
                                    .background(Color.white)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(height: 50)
    }
}



