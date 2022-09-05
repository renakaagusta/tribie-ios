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
                if (memberViewModel.state == AppState.Loading){
                    AppLoading()
                }
                if (memberViewModel.state == AppState.Empty){
                    AppBody1(text: "Empty")
                }
                if (memberViewModel.state == AppState.Error){
                    AppBody1(text: "Error bang")
                }
                if (memberViewModel.state == AppState.Exist){
                    if(memberViewModel.transactionExpensesList != nil && memberViewModel.tripMemberList != nil) {
                        List {
                            ForEach(memberViewModel.tripMemberList!) { tripMember in
                                MemberSpendingCard(image: AppCircleImage(size: 40.0, component: {}), userName: tripMember.name ?? "", amount: memberViewModel.getMemberExpenses(memberId: String(tripMember.id ?? "")) )

                            }
                        }
                    }
                }
                Spacer()
            }
            .onAppear {
                memberViewModel.fetchData()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                AppImageButton(height: 30, width: 30, image: AppImage(height: 24, width: 19, url: "square.and.arrow.up.circle", source: AppImageSource.SystemName, color: Color.primary, component: {}))
            )
        }
    }
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView().preferredColorScheme(scheme)
    }
}
