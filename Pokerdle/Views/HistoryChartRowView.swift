//
//  HistoryChartRowView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/20/22.
//

import SwiftUI

struct HistoryChartRowView: View {
    @State var winnings : Int
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 5)
                    .fill(winnings > 0 ? Color.green : Color.red)
                    .frame(width: abs(CGFloat(winnings) * 1), height: 17)
                    
                
            }
            .overlay(
                Group {
                    if winnings < 0 {
                        Text(winnings > 0 ? "+\(winnings)" : "\(winnings)")
                            .font(.custom("HelveticaNeue-Bold", size: 12))
                            .foregroundColor(.red)
                            .offset(x: (CGFloat(winnings) - 5), y: 0)
                    }
                }
                
                ,alignment: .trailing
            )
            .opacity(winnings > 0 ? 0 : 1)
            if winnings == 0 {
                Text("+0")
                    .font(.custom("HelveticaNeueHeavy", size: 12))
                    .foregroundColor(.gray)
                    .frame(width: 20)
            }
            HStack(alignment: .center, spacing: 0) {
        
                RoundedRectangle(cornerRadius: 5)
                    .fill(winnings > 0 ? Color.green : Color.red)
                    .frame(width: abs(CGFloat(winnings) * 1), height: 17)
                    
                Spacer()
            }
            .overlay(
                Group {
                    if winnings > 0 {
                        Text(winnings > 0 ? "+\(winnings)" : "\(winnings)")
                            .font(.custom("HelveticaNeue-Bold", size: 12))
                            .foregroundColor(.green)
                            .offset(x: abs(CGFloat(winnings) + 5), y: 0)
                    }
                }
                
                ,alignment: .leading
            )
            .opacity(winnings < 0 ? 0 : 1)
        }
        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
    }
}

struct HistoryChartRowView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryChartRowView(winnings: 100)
            .previewLayout(.sizeThatFits)
    }
}
