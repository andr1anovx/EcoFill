import SwiftUI

struct StationListCell: View {
    
    @EnvironmentObject var stationVM: StationViewModel
    let station: Station
    
    private var isPresentedRoute: Bool {
        stationVM.selectedStation == station
        && stationVM.isRouteShown
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(station.street)
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.primaryReversed)
                Row(data: station.schedule,
                    image: "clock",
                    imageColor: .accent)
            }
            
            Spacer()
            
            if !isPresentedRoute {
                Btn(title: "Route", image: "route", color: .accent) {
                    stationVM.isDetailsShown = false
                    stationVM.selectedStation = station
                    stationVM.isRouteShown = true
                }
            } else {
                Btn(title: "Hide", image: "xmark", color: .primaryRed) {
                    stationVM.isDetailsShown = false
                    stationVM.selectedStation = nil
                    stationVM.isRouteShown = false
                }
            }
        }
    }
}
