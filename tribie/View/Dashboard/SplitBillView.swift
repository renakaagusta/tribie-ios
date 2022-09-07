//
//  SplitBillView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct SplitBillView: View {
    
    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @State var transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID
    @StateObject var splitBillViewModel : SplitBillListViewModel = SplitBillListViewModel()
    
    var body: some View {
        VStack {
            if (splitBillViewModel.state == AppState.Loading) {
                AppLoading()
            }
            if(splitBillViewModel.state == AppState.Exist) {
                if(splitBillViewModel.transactionItemList != nil && splitBillViewModel.tripMemberList != nil && splitBillViewModel.transaction != nil) {
                    
                    ScrollView {
                        VStack {
                            VStack(alignment: .leading) {
                                Spacer().frame(height: 40)
                                AppBody1(text: "Grand Total").frame(width: UIScreen.width, alignment: .center)
                                
                                //AppDivider(height: 10, width: 150, color: Color.secondaryColor)
                                
                                Spacer().frame(height: 10)
                                AppHeader(text: "Rp\(String(splitBillViewModel.getGrandTotal()))", color: Color.primaryColor).frame(width: UIScreen.width, alignment: .center)
                                Spacer().frame(height: 10)
                                AppCard(width: .infinity, height: 40, backgroundColor: Color.white, component: {
                                    AppTitle1(text: splitBillViewModel.transaction!.title!, fontSize: 18).padding()
                                })
                                AppFootnote(text: "Who Paid", textAlign: TextAlignment.leading).padding()
                                MemberCard(image: AppCircleImage(size: 40.0, component: {}), userName: splitBillViewModel.getUserPaid().name ?? "-", backgroundColor: Color.white).padding().frame(width: UIScreen.width)
                                Spacer().frame(height: 10)
                                AppFootnote(text: "Split Method", textAlign: TextAlignment.leading).padding()
//                                AppCaption1(text: "Each members will pay according to what they buy.")
                            }.padding()
                                if(splitBillViewModel.transactionItemList != nil) {
                                    ForEach(Array(splitBillViewModel.transactionItemList!.enumerated()
                                                 ), id: \.1) { (index, transactionItem) in
                                        VStack {
                                            HStack {
                                                AppTextField(placeholder: "Item Name",field: Binding(get: {splitBillViewModel.transactionItemList![index].title!}, set: {splitBillViewModel.transactionItemList![index].title = $0})).frame(width: 120)
                                                Spacer()
                                                HStack{
                                                    AppOutlinedCircleButton(size: 20.0, icon: Image(systemName: "minus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                                                        splitBillViewModel.handleDecrementQuantity(index: index)
                                                    })
                                                    
                                                    AppCard(width:25, height: 25, cornerRadius: 5, borderColor: Color.gray, component: {
                                                        AppNumberField(placeholder: "Quantity", field: Binding(get: {splitBillViewModel.transactionItemList![index].quantity ?? 0}, set: {splitBillViewModel.transactionItemList![index].quantity = $0})).frame(width: 40)
                                                            .foregroundColor(Color.primaryColor)
                                                    })
                                                    
                                                    AppOutlinedCircleButton(size: 20.0, icon: Image(systemName: "plus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                                                        splitBillViewModel.handleIncrementQuantity(index: index)
                                                    })
                                                }
                                                Spacer()
                                                AppNumberField(placeholder: "Price", field: Binding(get: {splitBillViewModel.transactionItemList![index].price ?? 0}, set: {splitBillViewModel.transactionItemList![index].price = $0}))
                                            }.padding().cornerRadius(10)
                                        }
                                    }
                                    AppCircleButton(
                                        size: 17.5,
                                        icon: Image(systemName: "plus"),
                                        color: Color.white,
                                        source: AppCircleButtonContentSource.Icon,
                                        onClick: {
                                            splitBillViewModel.addItem()
                                        }
                                    )
                                }
                            Spacer().frame(height: 10)
                            VStack {
                                HStack{
                                    AppBody1(text: "Subtotal")
                                    Spacer()
                                    AppCard(width: .infinity, height: .infinity, cornerRadius: 10, backgroundColor: Color.white, component: {
                                        AppBody1(text: "Rp\(splitBillViewModel.getSubTotal())").padding()
                                    })
                                }
                                Spacer().frame(height: 10)
                                HStack{
                                    AppCaption1(text: "Service Charge / Tax")
                                    Spacer()
                                    AppBody1(text: "Rp\(splitBillViewModel.getServiceCharge())")
                                }
                                Spacer().frame(height: 10)
                                HStack{
                                    AppBody1(text: "Grand Total")
                                    Spacer()
                                    AppBody1(text: "Rp\(splitBillViewModel.getGrandTotal())", color: Color.primaryColor, fontWeight: .bold)
                                }
                                Spacer().frame(height: 10)
                                NavigationLink(destination: MemberItemListView(tripId: tripId, transactionId: transactionId)) {
                                    AppElevatedLink(label: "Next")
                                }
                            }.padding()
                            Spacer()
                            }
                    } //Scrollview
                    
                    }
                }
            if(splitBillViewModel.state == AppState.Error) {
                AppTitle1(text: "Error")
            }
            if(splitBillViewModel.state == AppState.Disconnect) {
                AppTitle1(text: "Disconnect")
            }
        }.background(Color.tertiaryColor).onAppear {
            splitBillViewModel.fetchData(tripId: tripId, transactionId: transactionId)
        }
    }
}

struct SplitBillView_Previews: PreviewProvider {
    static var previews: some View {
        SplitBillView().background(.white).preferredColorScheme(scheme)
    }
}
