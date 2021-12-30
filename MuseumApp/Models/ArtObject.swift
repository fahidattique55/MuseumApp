//
//  ArtObject.swift
//  MuseumApp
//
//  Created by fahid on 28/12/2021.
//

import Foundation

struct ArtObject: Codable {
    var objectID: Int?
    var isHighlight: Bool?
    var accessionNumber: String?
    var accessionYear: String?
    var isPublicDomain: Bool?
    var primaryImage: String?
    var primaryImageSmall: String?
    var additionalImages: [String]?
    var department: String?
    var objectName: String?
    var title: String?
    var culture: String?
    var period: String?
    var dynasty: String?
    var reign: String?
    var portfolio: String?
    var artistRole: String?
    var artistPrefix: String?
    var artistDisplayName: String?
    var artistDisplayBio: String?
    var artistSuffix: String?
    var artistAlphaSort: String?
    var artistNationality: String?
    var artistBeginDate: String?
    var artistEndDate: String?
    var artistGender: String?
    var artistWikidata_URL: String?
    var artistULAN_URL: String?
    var objectDate: String?
    var objectBeginDate: Int?
    var objectEndDate: Int?
    var medium: String?
    var dimensions: String?
    var creditLine: String?
    var geographyType: String?
    var city: String?
    var state: String?
    var county: String?
    var country: String?
    var region: String?
    var subregion: String?
    var locale: String?
    var locus: String?
    var excavation: String?
    var river: String?
    var classification: String?
    var rightsAndReproduction: String?
    var linkResource: String?
    var metadataDate: String?
    var repository: String?
    var objectURL: String?
    var objectWikidata_URL: String?
    var isTimelineWork: Bool?
    var GalleryNumber: String?
    var constituents: [Constituent]?
    var measurements: [Measurement]?
    var tags: [Tag]?
}
