//
//  GroupTripView.swift
//  tribie
//
//  Created by I Gede Bagus Wirawan on 09/09/22.
//

import SwiftUI

struct GroupTripView: View {
    
    //for Modal Environment
    @Environment(\.presentationMode) var presentationMode
    
    //variable for modal
    @State private var showAddMemberModalView: Bool = false
    
    //Variable
    @State var groupTripName: String = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                //Content
                ScrollView {
                    Group {
                        AppBody1(text: "Group Trip Member", color: Color.secondaryColor, textAlign: .trailing)
                        
                        AppTextField( placeholder: "Input Name",field: $groupTripName)
                    }
                    .padding()
                    
                    Group {
                        AppBody1(text: "Members", color: Color.secondaryColor, textAlign: .trailing)
                        
                        AppCaption1(text: "Go add some members! You’ll need at least 2 members to create a new group.", color: Color.secondaryColor)
                    }
                    .padding()
                }
//                Form {
//                    Section(header: Text("Group Trip Name")) {
//                        TextField("Input Name", text: $groupTripName)
//                    }
//
//                    Section(header: Text("Members")) {
//                        AppBody1(text: "check")
//                    }
//                }
                
                //End Content
            } //VStack
            .navigationTitle("Group Trip")
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
                //for trailing navigation bar items
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //action
                        self.showAddMemberModalView.toggle()
                        //self.showAddMemberModalView = true
                    }, label: {
                        AppImageButton(height: 100, width: 100, image: AppImage(height: 100, width: 100, url: "person.fill.badge.plus", source: AppImageSource.SystemName, color: Color.primaryColor, component: {}), onClick: {})
                    })
                    .sheet(isPresented: $showAddMemberModalView) {
                        AddMemberView()
                    } //for new modal
                }
            } //toolbar
            
        } //Navigation View
        
    }
    
}

struct GroupTripView_Previews: PreviewProvider {
    static var previews: some View {
        GroupTripView()
    }
}
