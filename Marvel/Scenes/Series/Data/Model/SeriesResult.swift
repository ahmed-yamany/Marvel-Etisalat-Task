//
//  SeriesResult.swift
//  Marvel
//
//  Created by Ahmed Yamany on 18/07/2024.
//

import Foundation

struct SeriesResult: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let urls: [URLElement]?
    let startYear, endYear: Int?
    let rating: Rating?
    let type: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let creators: Creators?
    let characters: Characters?
    let stories: Stories?
    let comics, events: Characters?
    let next: SeriesPagination?
    let previous: SeriesPagination?
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [SeriesPagination]?
    let returned: Int?
}

// MARK: - Next
struct SeriesPagination: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorsItem]?
    let returned: Int?
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String?
    let name, role: String?
}

enum Rating: String, Codable {
    case empty = ""
    case marvelPsr = "Marvel Psr"
    case ratedT = "Rated T"
    case ratingRatedT = "Rated T+"
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: StoriesType?
}

enum StoriesType: String, Codable {
    case cover
    case interiorStory
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: ThumbnailExtension?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum ThumbnailExtension: String, Codable {
    case jpg
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType?
    let url: String?
}

enum URLType: String, Codable {
    case detail
}
