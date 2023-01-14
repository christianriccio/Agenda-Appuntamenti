//
//  AppointmentsViewModel.swift
//  Agenda Appuntamenti
//
//  Created by Christian Riccio on 13/01/23.
//

import Foundation
import Combine
import FirebaseFirestore
import SwiftUI

class AppointmentsViewModel: ObservableObject {
  @Published var appointments = [Appointment]()

  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?

  deinit {
    unsubscribe()
  }

  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }

  func subscribe() {
    if listenerRegistration == nil {
        listenerRegistration = db.collection("Appuntamenti").order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }

        self.appointments = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Appointment.self)
        }
            print("Numero Appuntamenti:\( self.appointments.count)")
//            let numeroAppuntamenti = self.appointments.count
      }
    }
  }
    func retrieveAppuntamento(idAppuntamento:String) {
        let db = Firestore.firestore()
        
        let docRef = db.collection("Appuntamenti").document("\(idAppuntamento)")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                try?  self.appointments.append(document.data(as: Appointment.self))

            } else {
                print("Document does not exist")
            }
        }
    }
    func subscribeCount(count:Int) {
      if listenerRegistration == nil {
          listenerRegistration = db.collection("Appuntamenti").order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }

          self.appointments = documents.compactMap { queryDocumentSnapshot in
            try? queryDocumentSnapshot.data(as: Appointment.self)
          }
              print("Numero Appuntamenti:\( self.appointments.count)")
        }
      }
    }
    
    
    
  func removeAppointment(atOffsets indexSet: IndexSet) {
    let appointments = indexSet.lazy.map { self.appointments[$0] }
    appointments.forEach { appointment in
      if let documentId = appointment.id {
        db.collection("Appuntamenti").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }


}

