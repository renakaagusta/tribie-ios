//
//  SplitBillViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import Combine
import RxSwift

class TripFormViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var trip: Trip?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    @Published var selectedTripMemberList: [TripMember] = []
    
    public func fetchTrip(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID) async {
        repository.getTripData(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.trip = response ?? Trip()
                self.state = AppState.Exist
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func addTrip() async {
        self.state = AppState.Loading
        repository.addTrip(trip: trip!)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.trip = response ?? Trip()
                self.state = AppState.Finish
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func updateTrip(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID) async {
        state = AppState.Loading
        repository.updateTrip(id: tripId, trip: trip!)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.trip = response ?? Trip()
                self.state = AppState.Finish
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchData() async {
        self.state = AppState.Loading
        await fetchTrip()
    }
}
