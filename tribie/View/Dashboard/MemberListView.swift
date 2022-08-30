//
//  MemberView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct MemberListView: View {
    
    @ObservedObject var memberSpendingViewModel: MemberSpendingListViewModel = MemberSpendingListViewModel()
    
    var body: some View {
        VStack {
            if(memberSpendingViewModel.state == AppState.Loading) {
                AppBody1(text: "Loading")
            }
            if(memberSpendingViewModel.state == AppState.Exist) {
                ForEach(memberSpendingViewModel.tripMemberList) {
                    tripMember in HStack{}
                }
            }
            if(memberSpendingViewModel.state == AppState.Empty) {
                AppBody1(text: "Empty")
            }
            if(memberSpendingViewModel.state == AppState.Error) {
                AppBody1(text: "Error")
            }
        }.onAppear {
            memberSpendingViewModel.fetchData()
        }
    }
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView().preferredColorScheme(scheme)
    }
}
