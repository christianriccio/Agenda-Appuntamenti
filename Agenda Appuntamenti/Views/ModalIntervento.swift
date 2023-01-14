//
//  ModalIntervento.swift
//  Agenda Appuntamenti
//
//  Created by Christian Riccio on 13/01/23.
//

import SwiftUI

struct ModalIntervento: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var dates:Date
    @ObservedObject var viewModel = AppointmentViewModel()
     var body: some View {
       NavigationView {
           VStack(alignment: .leading){
               HStack{    Text("Nome Cliente:").padding(.horizontal)
                   TextField("",text:$viewModel.appointment.nomeCliente)
               }
               
               HStack{    Text("Trattamento:").padding(.horizontal)
                   TextField("",text:$viewModel.appointment.trattamento)
               }
               HStack{
//                   Text("Data:")
                 //  DatePicker("",text:$viewModel.appointment.date)
                   DatePicker("Data:", selection: $dates)
                       .datePickerStyle(.compact)
                       .padding(.all)
               
               }
               Spacer()
           }
         .toolbar {
           ToolbarItem(placement: .primaryAction) {
               Button("Salva") {
                   viewModel.appointment.date = dates
                   viewModel.handleDoneTapped()
                   dismiss()
               }
           }
           ToolbarItem(placement: .cancellationAction) {
               Button("Annulla", role: .cancel) {
                   dismiss()
               }
           }
         }
       }
     }

     private func dismiss() {
       presentationMode.wrappedValue.dismiss()
     }
}

//struct ModalIntervento_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalIntervento()
//    }
//}
