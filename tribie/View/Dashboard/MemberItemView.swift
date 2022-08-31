//
//  MemberItemListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct User: Hashable, Codable, Identifiable {
    var id: String?
    var name: String?
    var appleId: String?
    var email: String?
    var createdAt: Date?
    var updatedAt: Date?
}

struct Trip: Hashable, Codable, Identifiable {
    var id: String?
    var description: String?
    var createdAt: Date?
    var updatedAt: Date?
}

struct TripMember: Hashable, Codable, Identifiable {
    var id: String?
    var tripId: String?
    var userId: String?
    var name: String?
    var createdAt: Date?
    var updatedAt: Date?
}

struct Transaction: Hashable, Codable, Identifiable {
    var id: String?
    var tripId: String?
    var userPaidId: String?
    var title: String?
    var description: String?
    var createdAt: Date?
    var updatedAt: Date?
}

struct TransactionItem: Hashable, Codable, Identifiable {
    var id: String?
    var title: String?
    var description: String?
    var price: Int?
    var quantity: Int?
    var createdAt: Date?
    var updatedAt: Date?
}

struct TransactionExpenses: Hashable, Codable, Identifiable {
    var id: String?
    var itemId: String?
    var tripMemberId: String?
    var transactionId: String?
    var quantity: Int?
    var createdAt: Date?
    var updatedAt: Date?
}

struct TransactionSettlement: Hashable, Codable, Identifiable {
    var id: String?
    var itemId: String?
    var tripMemberId: String?
    var tripMemberDestinationId: String?
    var transactionId: String?
    var nominal: Int?
    var createdAt: Date?
    var updatedAt: Date?
}

struct MemberItemListView: View {
    
    @ObservedObject var memberItemListViewModel : MemberItemListViewModel = MemberItemListViewModel()
    
    @State var tripMemberList : [TripMember]  = [
        TripMember(id: "0", tripId: "", userId: "", name: "Kaka"),
        TripMember(id: "1", tripId: "", userId: "", name: "Arnold"),
        TripMember(id: "2", tripId: "", userId: "", name: "Gusde"),
    ]
    
    @State var transactionExpenseList : [TransactionExpenses]  = [
        TransactionExpenses(id: "0", itemId: "0", tripMemberId: "0", quantity: 1),
        TransactionExpenses(id: "1", itemId: "1", tripMemberId: "1", quantity: 3),
        TransactionExpenses(id: "2", itemId: "2", tripMemberId: "2", quantity: 2),
    ]
    
    var body: some View {
        VStack() {
            AppBody1(text: "Select Member")
            ScrollView(.horizontal) {
                HStack {
                    ForEach(memberItemListViewModel.tripMemberList){
                        tripMember in VStack {
                            MemberAvatarButton(image: AppCircleImage(size: 40.0, component: {}), selected: memberItemListViewModel.selectedUserId == tripMember.id)
                            AppBody1(text: tripMember.name ?? "-")
                        }
                    }
                }
            }.padding()
            AppFootnote(text: "What & how many items did member 1 order?")
            ForEach(memberItemListViewModel.transactionItemList){
                transactionItem in HStack {
                    MemberItemCard(name: transactionItem.title ?? "-", quantity: transactionItem.quantity!, onIncrement: {}, onDecrement: {})
                }
            }
            Spacer()
        }
    }
}

struct MemberItemListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberItemListView().preferredColorScheme(scheme)
    }
}
