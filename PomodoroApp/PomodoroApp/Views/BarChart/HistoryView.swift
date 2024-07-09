//
//  HistoryView.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 23/05/24.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading) {
                TitleView(title: "Histórico")
                    .padding(.top, 29)
                
                HStack(spacing: 0) {
                    filterButton("Diário", isSelected: viewModel.daily, action: {viewModel.daily = true; viewModel.updateChart()})
                        .padding(.leading, 33)
                    filterButton("Semanal", isSelected: !viewModel.daily,action: {viewModel.daily = false; viewModel.updateChart()})
                        .padding(.leading, 18)
                }
            }
            ScrollView {
                HStack {
                    chartTitle
                    Spacer()
                }
                grid
                    .frame(width: 400)
                
                BarChartView(studyDataPoints: $viewModel.formatedTimers)
                Spacer()
            }
        }
    }
    
    func filterButton(_ title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        HStack {
            Button(action: action) {
                Text(title)
                    .foregroundStyle(Color(UIColor.mainColor.asColor))
                    .font(.custom("ZillaSlab-Bold", size: 18))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 16 )
                    .background(isSelected ? Color(UIColor.connectColor.asColor) : Color(UIColor.whiteButton.asColor))
                    .cornerRadius(50)
                    .overlay(
                         RoundedRectangle(cornerRadius: 50)
                            .stroke(Color(UIColor.mainColor.asColor), lineWidth: isSelected ? 1 : 0)
                     )
            }
            
            .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 1)
        }
    }
    var chartTitle: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Tempo de Foco Diário")
                .font(.custom("ZillaSlab-Medium", size: 20))
                .foregroundStyle(Color(UIColor.mainColor.asColor))
            Text(viewModel.weekRangeText())
                .font(.custom("ZillaSlab-Medium", size: 16))
                .foregroundStyle(Color(UIColor.gray))
        }
        .padding(.leading, 33)
    }
    
    var grid: some View {
        HStack {
            HStack(spacing: 20) {
                // Pausa
                VStack(alignment: .center , spacing: 12) {
                    Text(viewModel.breakTime)
                        .font(.custom("ZillaSlab-Medium", size: 16))
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                    Text("Pausa")
                        .font(.custom("ZillaSlab-Medium", size: 16))
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                }
                
                Divider()
                    .frame(height: 60)
                
                // Foco
                VStack(alignment: .center) {
                    Text("Foco")
                        .font(.custom("ZillaSlab-Medium", size: 20))
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                    Text(viewModel.focusTime)
                        .font(.custom("ZillaSlab-Medium", size: 40))
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                }
                
                Divider()
                    .frame(height: 60)
                
                // Total
                VStack(alignment: .center, spacing: 12) {
                    Text(viewModel.totalTime)
                        .font(.custom("ZillaSlab-Medium", size: 16))
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                    Text("Total")
                        .font(.custom("ZillaSlab-Medium", size: 16))
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                    
                }
            }
            
            .frame(width: 350,height: 75)
            .padding()
            .background(Color(UIColor.connectColor.asColor))
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.4), radius: 3, x: 0, y: 2)
            .padding()
        }
    }
}

#Preview {
    HistoryView()
}
