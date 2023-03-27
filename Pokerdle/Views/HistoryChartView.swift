//
//  HistoryChartView.swift
//  Pokert
//
//  Created by Sebastian Morado on 8/30/22.
//

import SwiftUI

struct HistoryChartView: View {
    var lastFiveRounds : [Int]
    var body: some View {
        VStack {
            GroupBox {
                VStack(alignment: .center, spacing: 10) {
                    ForEach((0..<lastFiveRounds.count).reversed(), id: \.self) { i in
                        HistoryChartRowView(winnings: lastFiveRounds[i])
                    }
                }
            } label: {
                GroupBoxLabelView(title: "Recent Results", image: "calendar")
            }
            .padding(.horizontal)
        }
    }
}

struct HistoryChartView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryChartView(lastFiveRounds: [60, 0, -90, 30, -110])
            .previewLayout(.sizeThatFits)
    }
}
