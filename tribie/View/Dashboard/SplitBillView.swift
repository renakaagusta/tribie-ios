//
//  SplitBillView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct SplitBillView: View {
    
    @ObservedObject var splitBillViewModel : SplitBillListViewModel = SplitBillListViewModel()
    
    var body: some View {
        VStack {
            if (splitBillViewModel.state == AppState.Loading) {
                Text("Loading")
            }
            if(splitBillViewModel.state == AppState.Exist) {
                VStack {
                    VStack(alignment: .leading) {
                        AppCard(width: .infinity, height: 40, backgroundColor: Color.white, component: {
                            AppTitle1(text: splitBillViewModel.transaction!.title!).padding()
                        })
                        Spacer().frame(height: 40)
                        AppBody1(text: "Total Amount").frame(width: UIScreen.width, alignment: .center)
                        Spacer().frame(height: 10)
                        AppHeader(text: "Rp \(String(splitBillViewModel.grandTotal))").frame(width: UIScreen.width, alignment: .center)
                        Spacer().frame(height: 10)
                        AppFootnote(text: "Who Paid", textAlign: TextAlignment.leading).padding()
                        MemberCard(image: AppCircleImage(size: 40.0, component: {}), userName: splitBillViewModel.userPaid?.name ?? "-", backgroundColor: Color.white).padding()
                        Spacer().frame(height: 10)
                        AppFootnote(text: "Split Method", textAlign: TextAlignment.leading).padding()
                    }.padding()
                    ForEach(splitBillViewModel.transactionItemList) { transactionItem in
                        ItemCard(fieldName: .constant(transactionItem.title ?? ""), fieldQuantity: .constant(String(0)), price: 1000, onChangeName: {
                            newName in print(newName)
                        }, onChangeQuantity: {
                            newQuantity in print(String(newQuantity))
                        }, onIncrement: {}, onDecrement: {})
                    }
                    Spacer().frame(height: 10)
                    VStack {
                        HStack{
                            AppBody1(text: "Subtotal")
                            Spacer()
                            AppBody1(text: "Rp \(splitBillViewModel.subTotal)")
                        }
                        Spacer().frame(height: 10)
                        HStack{
                            AppBody1(text: "Grand total")
                            Spacer()
                            AppBody1(text: "Rp \(splitBillViewModel.subTotal)")
                        }
                        Spacer().frame(height: 10)
                        HStack{
                            AppBody1(text: "Service Charge / Tax")
                            Spacer()
                            AppBody1(text: "Rp \(splitBillViewModel.subTotal)")
                        }
                        Spacer().frame(height: 10)
                    }.padding()
                    Spacer()
                }
            }
            if(splitBillViewModel.state == AppState.Error) {
                Text("Error")
            }
            if(splitBillViewModel.state == AppState.Disconnect) {
                Text("Disconnect")
            }
        }.onAppear {
            splitBillViewModel.fetchData()
        }
    }
}

struct SplitBillView_Previews: PreviewProvider {
    static var previews: some View {
        SplitBillView().background(.white).preferredColorScheme(scheme)
    }
}
