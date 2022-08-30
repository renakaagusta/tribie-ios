//
//  MemberView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct member: Identifiable {
    var id: Int
    var name: String
    var spent: Int
}


struct MemberListView: View {
    
    @ObservedObject var memberViewModel: MemberListViewModel = MemberListViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                AppHeader(text: "Members")
                
                //Loading State Condition
                if (memberViewModel.state == AppState.Loading){
                    AppBody1(text: "Loading...")
                }
                
                //Empty State Condition
                if (memberViewModel.state == AppState.Empty){
                    AppBody1(text: "Empty")
                }
                //Error State Condition
                if (memberViewModel.state == AppState.Error){
                    AppBody1(text: "Error bang")
                }
                //Exist State Condition
                if (memberViewModel.state == AppState.Exist){

                    List {
                        ForEach(memberViewModel.tripMemberList) { tripMember in
                            MemberSpendingCard(image: AppCircleImage(size: 40.0, component: {}), userName: tripMember.name ?? "", amount: memberViewModel.getMemberExpenses(memberId: String(tripMember.id ?? "")) )

                        } //ForEach
                    }
                }
                
                Spacer()
            }
            .onAppear {
                memberViewModel.fetchData()
            } //VStack
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                AppImageButton(label: "Export", height: 30, width: 30, image: AppImage(height: 24, width: 19, url: "square.and.arrow.up.circle", source: AppImageSource.SystemName, color: Color.primary, component: {}))
            )
        } //NavigationView
        
    }
    
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView().preferredColorScheme(scheme)
    }
}
                                
