//
//  FormTripView.swift
//  tribie
//
//  Created by I Gede Bagus Wirawan on 09/09/22.
//

import SwiftUI

struct TripFormView: View {
    
    //for Modal Environment
    @Environment(\.presentationMode) var presentationMode
    
    //variable for modal
    @State private var showAddMemberModalView: Bool = false
    
    //Variable
    @State var groupTripName: String = ""
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                VStack {
                    //Content
                        Group {
                            VStack(alignment:.leading){
                                Spacer()
                                HStack{
                                    AppBody1(text: "Group Trip Member", color: Color.primaryColor, textAlign: .trailing)
                                    Spacer()
                                }
                            }
                            
                            AppTextField( placeholder: "Input Name",field: $groupTripName)
                        }
                        .padding(.horizontal)
                        
                        Group {
                            VStack(alignment:.leading){
                                HStack{
                                    AppBody1(text: "Members", color: Color.primaryColor, textAlign: .trailing)
                                    Spacer()
                                }
                            }
                            
                            AppCaption1(text: "Go add some members! You’ll need at least 2 members to create a new group.", color: Color.footnoteColor)
                        }
                        .padding()
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
                .navigationTitle("Group Trip").foregroundColor(.primaryColor)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    //for leading navigation bar items
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            //action
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            AppBody1(text: "Done", color: Color.signifierColor, fontWeight: .bold)
                        })
                    }
                    //for trailing navigation bar items
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                            AppImageButton(height: 20, width: 20, image: AppImage(height: 20, width: 20, url: "person.fill.badge.plus", source: AppImageSource.SystemName, color: Color.signifierColor, component: {}), onClick: {
                                self.showAddMemberModalView.toggle()
                            })
                        .sheet(isPresented: $showAddMemberModalView) {
                            AddMemberView()
                        } //for new modal
                    }
                } //toolbar
            }
            .background(Color.tertiaryColor)
            
        } //Navigation View
        
    }
    
}

struct FormTripView_Previews: PreviewProvider {
    static var previews: some View {
        TripFormView()
            
    }
}
