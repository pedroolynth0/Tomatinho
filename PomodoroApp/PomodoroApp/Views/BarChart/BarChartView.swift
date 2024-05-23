import SwiftUI
import Charts


struct BarChartView: View {
    @Binding var studyDataPoints: [StudyDataPoint]
    
    var body: some View {
        VStack(alignment: .center) {
            Chart {
                ForEach(studyDataPoints) { d in
                    BarMark(
                        x: .value("Day", d.day),
                        y: .value("Hours", d.hours)
                    )
                    .foregroundStyle(color(for: d.type))
                    .cornerRadius(5)
                }
            }
            .frame(width: 350, height: 320)
            .chartYAxis {
                AxisMarks(preset: .aligned, position: .leading)
            }
        .padding()
        }
    }
}

extension BarChartView {
    
    func color(for type: String) -> Color {
        switch type {
        case "Focus":
            return Color(UIColor.playButtonColor.asColor)
        case "Break":
            return Color(UIColor.playButtonColor.asColor)
        case "Accidental":
            return  Color(UIColor.playButtonColor.asColor)
        default:
            return Color.gray // Default color
        }
    }
}

struct previews_Previews: PreviewProvider {
    static var previews: some View {
        @State var dataPoints: [StudyDataPoint] = []
        BarChartView(studyDataPoints: $dataPoints)
    }
}
