//
//  Article.swift
//  NewsAppMVVM
//
//  Created by Kas Song on 1/16/21.
//

import Foundation

struct ArticleResponse {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
