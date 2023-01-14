//
//  Incompleti.swift
//  Agenda Appuntamenti
//
//  Created by Christian Riccio on 14/01/23.
//

import SwiftUI

struct Incompleti: View {
    @State private var selectedTab: Int = 0
    @ObservedObject var viewModel = AppointmentsViewModel()
    @State var showModal = false
    @State var dates = Date()
    @ObservedObject var viewModelAppointment = AppointmentViewModel()
    var body: some View {
       
        NavigationView {
            VStack {

                CalendarView(dates:$dates)
                    
                List {
                    ForEach(viewModel.appointments.filter { appointment in
                        
                        
                        Calendar.current.isDate(appointment.date, equalTo: dates, toGranularity: .day)
                    }) { appointment in
                        if(!appointment.finito){
                            VStack(alignment: .leading){
                                Text("Nome cliente: \(appointment.nomeCliente)")
                                Text("Trattamento: \(appointment.trattamento)")
                                Text("Orario: \(appointment.date.formatted(date: .omitted, time: .standard))")
                            }.swipeActions(edge:.trailing){
                                Button{
                                    viewModelAppointment.appointment = appointment
                                    viewModelAppointment.appointment.finito = true
                                    viewModelAppointment.handleDoneTapped()
                                    
                                }label: {
                                    
                                    Image(systemName: "checkmark.seal.fill")
                                    
                                }.tint(Color.green)
                                
                            }
                        }
                    }
                }
            }
            .onAppear(){self.viewModel.subscribe()}
//            .navigationBarTitle("Appuntamenti")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Image(systemName: "person.fill.xmark")
                                Text("Appuntamenti").font(.headline)
                            }
                        }
                    }
            .navigationBarItems(trailing:
                                    Button(action: {
                showModal.toggle()
            }) {
                Image(systemName: "plus")
            }.sheet(isPresented: $showModal) {
                ModalIntervento(dates:$dates)
                    
            }
            )
        }
    
    }
}

struct CalendarView: View {
    @Environment(\.calendar) var calendar
    @Environment(\.timeZone) var timeZone
    
    var bounds: PartialRangeFrom<Date> {
        let start = calendar.date(
            from: DateComponents(
                timeZone: timeZone,
                year: 2022,
                month: 6,
                day: 20)
        )!
        
        return start...

    }
    
    @Binding var dates:Date

    var body: some View {
        DatePicker("", selection: $dates, in: bounds)
            .datePickerStyle(.graphical)
            .environment(\.locale, Locale.init(identifier: "it"))
    }
}


struct Incompleti_Previews: PreviewProvider {
    static var previews: some View {
        Incompleti()
    }
}
