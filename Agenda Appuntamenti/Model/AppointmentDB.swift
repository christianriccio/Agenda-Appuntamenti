//
//  AppointmentDB.swift
//  Agenda Appuntamenti
//
//  Created by Christian Riccio on 13/01/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Appointment: Identifiable, Codable {
    @DocumentID var id: String?
    var nomeCliente: String
    var trattamento: String
    var date: Date
    var finito: Bool
    var prezzo: String
}
