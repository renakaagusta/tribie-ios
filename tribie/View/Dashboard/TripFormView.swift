//
//  TripFormView.swift
//  tribie
//
//  Created by renaka agusta on 05/09/22.
//

import SwiftUI

struct TripFormView: View {
    
    @ObservedObject var tripFormViewModel = TripFormViewModel()
    
    @State var tripName: String
    
    var body: some View {
        VStack {
            AppTextField(field: $tripName)
            if(tripFormViewModel.selectedTripMemberList.count > 0) {

            }
            AppElevatedButton(label: "Next")
        }
    }
}
