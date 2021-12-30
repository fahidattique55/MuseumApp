//
//  Measurement.swift
//  MuseumApp
//
//  Created by fahid on 28/12/2021.
//

import Foundation

struct Measurement: Codable {
    var elementName: String?
    var elementDescription: String?
    var elementMeasurements: ElementMeasurement?
}

struct ElementMeasurement: Codable {
    var Height: Double?
    var Width: Double?
}


