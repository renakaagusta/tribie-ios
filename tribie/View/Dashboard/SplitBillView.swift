//
//  SplitBillView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct SplitBillView: View {
    
    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @State var transactionId: String? 
    @StateObject var splitBillViewModel : SplitBillListViewModel = SplitBillListViewModel()
    @State var showSelectUserPay = false
    @State var selectedUserPayIndex: Int = 0
    @State var formState: SplitbillState = SplitbillState.InputTransaction
    
    var body: some View {
        VStack {
            if (splitBillViewModel.state == AppState.Loading) {
                AppLoading()
            }
            if(splitBillViewModel.state == AppState.Exist) {
                if(splitBillViewModel.transactionItemList != nil && splitBillViewModel.tripMemberList != nil && splitBillViewModel.transaction != nil) {
                    VStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            AppCard(width: UIScreen.width - 40, height: 60, backgroundColor: Color.white, component: {
                                    VStack {
                                        AppTextField(placeholder: "Transaction Name", field: Binding(get: {splitBillViewModel.transaction!.title!}, set: {splitBillViewModel.transaction!.title = $0})).frame(width: UIScreen.width - 40, height: 40)
                                    }.padding()
                            }).padding()
                            Spacer().frame(height: 40)
                            AppBody1(text: "Total Amount").frame(width: UIScreen.width, alignment: .center)
                            Spacer().frame(height: 10)
                            if(splitBillViewModel.formState == SplitbillState.InputTransaction) {
                                AppNumberField(placeholder: "Total Amount", field: Binding(get: {Double(splitBillViewModel.transaction?.grandTotal ?? 0)}, set: {splitBillViewModel.transaction?.grandTotal = Int($0)})).frame(width: UIScreen.width - 40).padding()
                            }
                            if(splitBillViewModel.formState != SplitbillState.InputTransaction) {
                                AppHeader(text: "Rp \(String(splitBillViewModel.getGrandTotal()))").frame(width: UIScreen.width, alignment: .center)
                            }
                            Spacer().frame(height: 10)
                            AppFootnote(text: "Who Paid", textAlign: TextAlignment.leading).padding()
                            if(splitBillViewModel.formState != SplitbillState.InputTransaction) {
                                Button(
                                    action: {
//                                        showSelectUserPay = !showSelectUserPay
                                    },
                                    label: {
                                        MemberCard(image: AppCircleImage(size: 40.0, component: {}), userName: splitBillViewModel.getUserPaid().name ?? "-", backgroundColor: Color.white).padding().frame(width: UIScreen.width)
                                    }
                                )
                            }
                            if(splitBillViewModel.formState == SplitbillState.InputTransaction) {
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(splitBillViewModel.tripMemberList!){
                                            tripMember in VStack {
                                                MemberAvatarButton(image: AppCircleImage(size: 40.0, component: {}), selected: Binding(get: {splitBillViewModel.selectedUserId == tripMember.id}, set: {_ in true}), onClick: {
                                                    splitBillViewModel.selectUser(tripMemberId: tripMember.id!)
                                                })
                                                AppBody1(text: tripMember.name ?? "-")
                                            }
                                        }
                                    }
                                }.padding()
                            }
                        }.padding()
                        if(showSelectUserPay == true) {
                            VStack {
                                Spacer()
                                Picker("Select user", selection: $selectedUserPayIndex) {
                                    ForEach(Array(splitBillViewModel.tripMemberList!.enumerated()
                                                 ), id: \.1) { (index, tripMember) in
                                        Text(splitBillViewModel.tripMemberList![index].name!).tag(index)
                                    }.onChange(of: selectedUserPayIndex, perform: { (value) in
                                        print(value)
                                        splitBillViewModel.selectUserPay(index: value)
                                    })
                            }.pickerStyle(WheelPickerStyle())
                                    .foregroundColor(.white)
                                    .padding()
                                AppElevatedButton(label: "Done", onClick: {
                                        showSelectUserPay = false
                                    })
                            }
                        }
                        if(splitBillViewModel.formState == SplitbillState.InputTransaction) {
                            AppElevatedButton(label: "Submit",
                                              width: UIScreen.width - 40,onClick: {
                                splitBillViewModel.submitTransaction()
                            })
                        }
                        if(showSelectUserPay == false && splitBillViewModel.formState != SplitbillState.InputTransaction) {
                            VStack {
                                Spacer().frame(height: 10)
                                AppFootnote(text: "Split Method", textAlign: TextAlignment.leading).padding()
                                if(splitBillViewModel.transactionItemList != nil && splitBillViewModel.transaction!.method == "Item") {
                                    ForEach(Array(splitBillViewModel.transactionItemList!.enumerated()
                                                 ), id: \.1) { (index, transactionItem) in
                                        VStack {
                                            HStack {
                                                AppTextField(placeholder: "Item Name", field: Binding(get: {splitBillViewModel.transactionItemList![index].title ?? "-"}, set: {splitBillViewModel.transactionItemList![index].title = $0})).frame(width: 120)
                                                Spacer()
                                                HStack{
                                                    if(splitBillViewModel.formState == SplitbillState.InputTransactionItem) {
                                                        AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "minus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                                                            splitBillViewModel.handleDecrementQuantity(index: index)
                                                        })
                                                    }
                                                    AppNumberField(placeholder: "Quantity", field: Binding(get: {splitBillViewModel.transactionItemList![index].quantity ?? 0}, set: {splitBillViewModel.transactionItemList![index].quantity = $0})).frame(width: 40)
                                                    if(splitBillViewModel.formState == SplitbillState.InputTransactionItem) {
                                                        AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "plus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                                                            splitBillViewModel.handleIncrementQuantity(index: index)
                                                        })
                                                    }
                                                }
                                                Spacer()
                                                AppNumberField(placeholder: "Price", field: Binding(get: {splitBillViewModel.transactionItemList![index].price ?? 0}, set: {splitBillViewModel.transactionItemList![index].price = $0}))
                                            }.padding().cornerRadius(10)
                                        }
                                    }
                                    if(splitBillViewModel.formState == SplitbillState.InputTransactionItem) {
                                        AppCircleButton(
                                            size: 20,
                                            icon: Image(systemName: "plus"),
                                            color: Color.white,
                                            source: AppCircleButtonContentSource.Icon,
                                            onClick: {
                                                splitBillViewModel.addItem()
                                            }
                                        )
                                    }
                                }
                                if(splitBillViewModel.transaction!.method == "Equally") {
                                    ForEach(Array(splitBillViewModel.tripMemberList!.enumerated()), id: \.1) { (index, tripMember) in
                                        Button(action: {
                                            
                                        }, label: {
                                            HStack{
                                                AppRadio()
                                                MemberCard(image: AppCircleImage(size: 40.0, component: {}), userName: tripMember.name!)
                                            }
                                        })
                                    }
                                }
                                if(splitBillViewModel.transaction!.method == "Manually") {
                                    ForEach(Array(splitBillViewModel.tripMemberList!.enumerated()), id: \.1) { (index, tripMember) in
                                        HStack{
                                            AppRadio()
                                            MemberCard(image: AppCircleImage(size: 40.0, component: {}), userName: tripMember.name!)
                                        }
                                    }
                                }
                            Spacer().frame(height: 10)
                            VStack {
                                HStack{
                                    AppBody1(text: "Subtotal")
                                    Spacer()
                                    AppBody1(text: "Rp \(Binding(get: {splitBillViewModel.getSubTotal()}, set: {_ in true}).wrappedValue)")
                                }
                                Spacer().frame(height: 10)
                                HStack{
                                    AppBody1(text: "Grand total")
                                    Spacer()
                                    AppBody1(text: "Rp \(Binding(get: {splitBillViewModel.getGrandTotal()}, set: {_ in true}).wrappedValue)")
                                }
                                Spacer().frame(height: 10)
                                HStack{
                                    AppBody1(text: "Service Charge / Tax")
                                    Spacer()
                                    AppBody1(text: "Rp \(Binding(get: {splitBillViewModel.getServiceCharge()}, set: {_ in true}).wrappedValue)")
                                }
                                Spacer().frame(height: 10)
                                if(splitBillViewModel.transaction != nil) {
                                    if(splitBillViewModel.formState == SplitbillState.Calculate && splitBillViewModel.transaction!.status == "Expenses") {
                                        NavigationLink(destination: SettlementListView(tripId: tripId, transactionId: transactionId!), isActive:Binding(get: {splitBillViewModel.moveToSettlementListView == true}, set: { _ in true}) ) {
                                            AppElevatedButton(label: "Done",
                                                              onClick: {
                                            splitBillViewModel.calculateSplitBill()
                                            splitBillViewModel.updateTransaction()
                                        })
                                        }
                                    }
                                    if(splitBillViewModel.formState == SplitbillState.Calculate && (splitBillViewModel.transaction!.status == "Calculated" || splitBillViewModel.transaction!.status == "Item")) {
                                        NavigationLink(destination: MemberItemListView(tripId: tripId, transactionId: transactionId!), isActive: $splitBillViewModel.moveToMemberItemView ) {
                                            AppElevatedButton(label: "Recalculate", onClick: {
                                                splitBillViewModel.removeAllTransactionSettlement()
                                                splitBillViewModel.submitTransactionItem()
                                                splitBillViewModel.updateTransaction()
                                            })
                                        }
                                    }
                                    if(splitBillViewModel.formState == SplitbillState.InputTransactionItem) {
                                        NavigationLink(destination: MemberItemListView(tripId: tripId, transactionId: splitBillViewModel.transaction!.id!), isActive: $splitBillViewModel.moveToMemberItemView ) {
                                            AppElevatedButton(label: "Next", onClick: {
                                                splitBillViewModel.submitTransactionItem()
                                                splitBillViewModel.updateTransaction()
                                            })
                                        }
                                    }
                                }
                            }.padding()
                            Spacer()
                            }
                        }
                        }
                    }
                }
            if(splitBillViewModel.state == AppState.Error) {
                AppTitle1(text: "Error")
            }
            if(splitBillViewModel.state == AppState.Disconnect) {
                AppTitle1(text: "Disconnect")
            }
        }
        .frame(height: UIScreen.height)
        .background(Color.tertiaryColor).onAppear {
            splitBillViewModel.fetchData(tripId: tripId, transactionId: transactionId, formState: formState)
        }
    }
}

struct SplitBillView_Previews: PreviewProvider {
    static var previews: some View {
        SplitBillView().background(.white).preferredColorScheme(scheme)
    }
}
