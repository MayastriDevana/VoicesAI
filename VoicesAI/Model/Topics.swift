//
//  Topics.swift
//  VoicesAI
//
//  Created by User on 24/04/24.
//

import Foundation

enum Topics: String, CaseIterable, Identifiable {
    case persahabatan = "Persahabatan"
    case romantis = "Romantis"
    case motivasi = "Motivasi"
    case horor = "Horror"
    var id: Topics { self }
}

enum Mood: String, CaseIterable, Identifiable{
    case bahagia = "Bahagia"
    case sedih = "Sedih"
    case marah = "Marah"
    case takut = "Takut"
    case terkejut = "Terkejut"
    case jijik = "Jijik"
    var id: Mood { self }
}
