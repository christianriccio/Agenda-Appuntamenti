//
//  Completi.swift
//  Agenda Appuntamenti
//
//  Created by Christian Riccio on 14/01/23.
//

import SwiftUI

struct Completi: View {
    @ObservedObject var viewModel = AppointmentsViewModel()
    
    @ObservedObject var viewModelAppointment = AppointmentViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.appointments){appointment in
                    if ( appointment.finito ){
                        
                        VStack(alignment: .leading){
                            Text("Nome cliente: \(appointment.nomeCliente)")
                            Text("Trattamento: \(appointment.trattamento)")
                            Text("Trattamento: \(appointment.prezzo)")
                        }
                        .swipeActions(edge:.trailing){
                            Button{
                                viewModelAppointment.appointment = appointment
                                viewModelAppointment.handleDeleteTapped()
    
                            }label: {
    
                                Image(systemName: "trash.circle.fill")
    
                            }.tint(Color.red)
    
                        }
                        
                    }
                }
               
            }.onAppear(){self.viewModel.subscribe()}
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                                    ToolbarItem(placement: .principal) {
                                        HStack {
//                                            Image(systemName: "scissors")
                                            Text("Appuntamenti Completati").font(.headline)
                                        }
                                    }
                                }
            
            .scrollContentBackground(.hidden)
       
        }
                    }
    
    

                    }
                    
                    
                    
                    

struct Completi_Previews: PreviewProvider {
    static var previews: some View {
        Completi()
    }
}
