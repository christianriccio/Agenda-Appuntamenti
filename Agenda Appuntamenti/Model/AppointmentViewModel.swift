//
//  AppointmentViewModel.swift
//  Agenda Appuntamenti
//
//  Created by Christian Riccio on 13/01/23.
//

import Foundation
import Combine
import FirebaseFirestore

class AppointmentViewModel: ObservableObject{
    @Published var appointment: Appointment
    @Published var modified = false
    @Published var selectedDate = Date()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(appointment: Appointment = Appointment(nomeCliente:"", trattamento: "", date: Date(), finito: false, prezzo: "")){
        
        self.appointment = appointment
        
        self.$appointment
          .dropFirst()
          .sink { [weak self] appointment in
            self?.modified = true
          }
         .store(in: &self.cancellables)
        
    }
    
    private var db = Firestore.firestore()
    
    private func addAppointment(_ appointment: Appointment) {
      do {
        let _ = try db.collection("Appuntamenti").addDocument(from: appointment)
      }
      catch {
        print(error)
      }
    }
    
    private func updateAppointment(_ appointment: Appointment) {
      if let documentId = appointment.id {
        do {
          try db.collection("Appuntamenti").document(documentId).setData(from: appointment)
        }
        catch {
          print(error)
        }
      }
    }
    
    private func updateOrAddAppointment() {
      if let _ = appointment.id {
        self.updateAppointment(self.appointment)
      }
      else {
        addAppointment(appointment)
      }
    }
    
    private func removeAppointment() {
      if let documentId = appointment.id {
        db.collection("Appuntamenti").document(documentId).delete { error in
          if let error = error {
            print(error.localizedDescription)
          }
        }
      }
    }
    
    // UI handlers
    
    func handleDoneTapped() {
      self.updateOrAddAppointment()
    }
    
    func handleDeleteTapped() {
      self.removeAppointment()
    }
}

