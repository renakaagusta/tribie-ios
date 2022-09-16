//
//  SplitBillView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct SplitBillView: View {
    
    @State var tripId: String?
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
                                Spacer().frame(height: 50)
                                AppBody1(text: "Grand Total", color: Color.primaryColor, fontWeight: .regular).frame(width: UIScreen.width, alignment: .center)
                                Spacer().frame(height: 10)
                                
                                if(splitBillViewModel.formState != SplitbillState.InputTransaction) {
                                    AppHeader(text: "Rp \(String(splitBillViewModel.getGrandTotal()))", color: Color.primaryColor).frame(width: UIScreen.width, alignment: .center)
                                }
                                
                                if(splitBillViewModel.formState == SplitbillState.InputTransaction) {
                                    AppNumberField(placeholder: "Total Amount", field: Binding(get: {Double(splitBillViewModel.transaction?.grandTotal ?? 0)}, set: {splitBillViewModel.transaction?.grandTotal = Int($0)})).frame(width: UIScreen.width - 40).padding()
                                }
                                AppCard(width: UIScreen.width - 40, height: 38, cornerRadius: 10, backgroundColor: Color.cardColor, component: {
                                        VStack {
                                            AppTextField(placeholder: "Transaction Name", field: Binding(get: {splitBillViewModel.transaction!.title!}, set: {splitBillViewModel.transaction!.title = $0})).frame(width: UIScreen.width - 40, height: 50)
                                        }.padding()
                                }).padding()
                                Spacer().frame(height: 10)
                                AppBody1(text: "Paid by", color: Color.primaryColor, fontWeight: .regular).frame(width: UIScreen.width, alignment: .center)
                                if(splitBillViewModel.formState != SplitbillState.InputTransaction) {
                                    Button(
                                        action: {
    //                                        showSelectUserPay = !showSelectUserPay
                                        },
                                        label: {
                                            MemberCard(image: AppCircleImage(size: 40.0, component: {}), userName: splitBillViewModel.getUserPaid().name ?? "-", backgroundColor: Color.clear)
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
                                                    AppBody1(text: tripMember.name ?? "-", color: Color.primaryColor)
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
                                        .foregroundColor(Color.signifierColor)
                                        .padding()
                                    AppElevatedButton(label: "Done", onClick: {
                                            showSelectUserPay = false
                                        })
                                }
                            }
                            if(splitBillViewModel.formState == SplitbillState.InputTransaction) {
                                AppElevatedButton(label: "Split Bill", width: UIScreen.width - 50, color: Color.black, backgroundColor: Color.signifierColor,onClick: {
                                    splitBillViewModel.submitTransaction()
                                }).padding(10)
                            }
                            if(showSelectUserPay == false && splitBillViewModel.formState != SplitbillState.InputTransaction) {
                                VStack {
                                    Spacer().frame(height: 10)
    //                                AppFootnote(text: "Split Method", textAlign: TextAlignment.leading).padding()
                                    if(splitBillViewModel.transactionItemList != nil && splitBillViewModel.transaction!.method == "Item") {
                                        ForEach(Array(splitBillViewModel.transactionItemList!.enumerated()
                                                     ), id: \.0) { (index, transactionItem) in
                                            VStack {
                                                HStack {
                                                    AppTextField(placeholder: "Item Name", field: Binding(get: {splitBillViewModel.transactionItemList![index].title ?? "-"}, set: {splitBillViewModel.transactionItemList![index].title = $0})).frame(width: 120)
                                                    Spacer()
                                                    HStack{
                                                        if(splitBillViewModel.transaction?.status == "Items" || splitBillViewModel.transaction?.status == "Created") {
                                                            AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "minus"), color: Color.signifierColor, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                                                                splitBillViewModel.handleDecrementQuantity(index: index)
                                                            })
                                                        }
                                                        AppNumberField(placeholder: "Quantity", field: Binding(get: {splitBillViewModel.transactionItemList![index].quantity ?? 0}, set: {splitBillViewModel.transactionItemList![index].quantity! = $0})).frame(width: 40)
                                                        if(splitBillViewModel.transaction?.status == "Items" || splitBillViewModel.transaction?.status == "Created") {
                                                            AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "plus"), color: Color.signifierColor, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                                                                splitBillViewModel.handleIncrementQuantity(index: index)
                                                            })
                                                        }
                                                    }
                                                    Spacer()
                                                    AppNumberField(placeholder: "Price", field: Binding(get: {splitBillViewModel.expensesByItemList[index] ?? 0}, set: {splitBillViewModel.expensesByItemList[index] = $0}))
                                                }.padding().cornerRadius(10)
                                            }
                                        }
                                        if(splitBillViewModel.transaction?.status == "Items" || splitBillViewModel.transaction?.status == "Created") {
                                            AppCircleButton(
                                                size: 20,
                                                icon: Image(systemName: "plus"),
                                                color: Color.black,
                                                backgroundColor: Color.signifierColor,
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
                                        AppBody1(text: "Subtotal", color: Color.primaryColor)
                                        Spacer()
                                        if(splitBillViewModel.transaction?.status == "Done" || splitBillViewModel.transaction?.status == "Expenses") {
                                            AppBody1(text: "Rp \(splitBillViewModel.transaction!.subTotal!)", color: Color.primaryColor)
                                        } else {
                                            AppBody1(text: "Rp \(Binding(get: {splitBillViewModel.getSubTotal()}, set: {_ in true}).wrappedValue)", color: Color.primaryColor)
                                        }
                                    }
                                    Spacer().frame(height: 10)
                                    HStack{
                                        AppBody1(text: "Grand total", color: Color.primaryColor)
                                        Spacer()
                                        if(splitBillViewModel.transaction?.status == "Done" || splitBillViewModel.transaction?.status == "Expenses") {
                                            AppBody1(text: "Rp \(splitBillViewModel.transaction!.grandTotal!)", color: Color.primaryColor)
                                        } else {
                                            AppBody1(text: "Rp \(Binding(get: {splitBillViewModel.getGrandTotal()}, set: {_ in true}).wrappedValue)", color: Color.primaryColor)
                                        }
                                    }
                                    Spacer().frame(height: 10)
                                    HStack{
                                        AppBody1(text: "Service Charge/ Tax", color: Color.primaryColor)
                                        Spacer()
                                        if(splitBillViewModel.transaction?.status == "Done" || splitBillViewModel.transaction?.status == "Expenses") {
                                            AppBody1(text: "Rp \(splitBillViewModel.transaction!.serviceCharge!)", color: Color.primaryColor)
                                        } else {
                                            AppBody1(text: "Rp \(Binding(get: {splitBillViewModel.getServiceCharge()}, set: {_ in true}).wrappedValue)", color: Color.primaryColor)
                                        }
                                    }
                                    Spacer().frame(height: 10)
                                    if(splitBillViewModel.transaction != nil) {
                                        NavigationLink(destination: SettlementListView(tripId: splitBillViewModel.transaction!.tripId!, showFinish: true), isActive:Binding(get: {splitBillViewModel.moveToSettlementListView}, set: { _ in true})) {
                                                if(splitBillViewModel.transaction!.status == "Expenses") {
                                                    AppElevatedButton(label: "Done", width: UIScreen.width - 50, color: Color.black, backgroundColor: Color.signifierColor,
                                                                  onClick: {
                                                splitBillViewModel.calculateSplitBill()
                                                splitBillViewModel.updateTransaction()
                                            })
                                            }
                                            }
    //                                    if(splitBillViewModel.formState == SplitbillState.Calculate && (splitBillViewModel.transaction!.status == "Calculated" || splitBillViewModel.transaction!.status == "Item")) {
    //                                        NavigationLink(destination: MemberItemListView(tripId: tripId, transactionId: transactionId!), isActive: $splitBillViewModel.moveToMemberItemView ) {
    //                                            AppElevatedButton(label: "Recalculate", onClick: {
    //                                                splitBillViewModel.removeAllTransactionSettlement()
    //                                                splitBillViewModel.submitTransactionItem()
    //                                                splitBillViewModel.updateTransaction()
    //                                            })
    //                                        }
    //                                    }
                                        if(splitBillViewModel.transaction!.status == "Items" || splitBillViewModel.transaction!.status == "Created") {
                                            NavigationLink(destination: MemberItemListView(tripId: tripId!, transactionId: splitBillViewModel.transaction!.id!), isActive: $splitBillViewModel.moveToMemberItemView ) {
                                                AppElevatedButton(label: "Done", width: UIScreen.width - 50, color: Color.black, backgroundColor: Color.signifierColor, onClick: {
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
        .navigationTitle("Transactions")
//        .toolbar {
//            //for leading navigation bar items
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    //action
//                    presentationMode.wrappedValue.dismiss()
//                }, label: {
//                    AppBody1(text: "Cancel", color: Color.primaryColor, fontWeight: .bold)
//                })
//            }
//        } //toolbar
        .frame(height: UIScreen.height)
        .background(Color.tertiaryColor).onAppear {
            splitBillViewModel.fetchData(tripId: tripId!, transactionId: transactionId, formState: formState)
        }
    }
}

struct SplitBillView_Previews: PreviewProvider {
    static var previews: some View {
        SplitBillView().preferredColorScheme(.dark).background(.white).preferredColorScheme(scheme)
    }
}
