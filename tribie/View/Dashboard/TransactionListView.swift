//
//  TransactionListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI



struct TransactionListView: View {

    @ObservedObject var transactionViewModel: TransactionListViewModel = TransactionListViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                AppTitle1(text: "Transactions")

                //Loading State Condition
                if (transactionViewModel.state == AppState.Loading){
                    AppBody1(text: "Loading...")
                }
                
                //Empty State Condition
                if (transactionViewModel.state == AppState.Empty){
                    AppBody1(text: "Empty")
                }
                //Error State Condition
                if (transactionViewModel.state == AppState.Error){
                    AppBody1(text: "Error bang")
                }
                //Exist State Condition
                if (transactionViewModel.state == AppState.Exist){

                    ScrollView {
                        ForEach(transactionViewModel.transactionList) { transaction in
                            
                        }
                    }
                }
                
                Spacer()
                
            }
            .onAppear {
                transactionViewModel.fetchData()
            }
            .navigationTitle("Recent Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                AppImageButton(height: 30, width: 30, image: AppImage(height: 24, width: 19, url: "square.and.arrow.up.circle", source: AppImageSource.SystemName, color: Color.primary, component: {}))
            )
            .padding()
        }
        
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView().preferredColorScheme(scheme)
    }
}
