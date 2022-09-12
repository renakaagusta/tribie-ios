//
//  AddMemberView.swift
//  tribie
//
//  Created by I Gede Bagus Wirawan on 12/09/22.
//

import SwiftUI

struct AddMemberView: View {
    
    //for Modal Environment
    @Environment(\.presentationMode) var presentationMode
    
    //variable for modal
    @State var searchMember: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Text("\(searchMember)")
                    .searchable(text: $searchMember)
                
                AppCaption1(text: "Find members using Apple ID")
                
                Spacer()
                
            } //VStack
            .navigationTitle("Add Members")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //for leading navigation bar items
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        //action
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        AppBody1(text: "Done", color: Color.primaryColor, fontWeight: .bold)
                    })
                }
            } //toolbar
        } //Navigation View
        
    }
    
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}
