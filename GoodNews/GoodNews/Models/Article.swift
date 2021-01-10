//
//  Article.swift
//  GoodNews
//
//  Created by Kas Song on 1/10/21.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
}
