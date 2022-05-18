    //
    //  ContentView.swift
    //  Drawing App
    //
    //  Created by Nkosi Yafeu on 5/18/22.
    //

    import SwiftUI

    struct Line {
        var points: [CGPoint]
        var color: Color
    }

    struct ContentView: View {
        
        @State private var lines: [Line] = []
        @State private var selectedColor = Color.orange
        
        var body: some View {
            VStack {
                HStack {
                    ForEach([Color.green, .orange, .blue, .brown, .red, .black, .purple], id: \.self) { color
                        in
                        colorButton(color: color)
                    }
                    clearButton()
                }
                
                Canvas { ctx, size in
                    for line in lines {
                        var path = Path ()
                        path.addLines(line.points)
                        
                        ctx.stroke(path, with: .color(line.color), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        
                }
            }
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace:
                        .local)
                    .onChanged({ value  in
                        let position = value.location
                        
                        if value.translation == .zero {
                            lines.append(Line(points: [position],
                                            color: selectedColor))
                           } else {
                               guard let lastIdx =
                                        lines.indices.last else {
                                   return
                               }
                               lines[lastIdx].points.append(position)
                        }
                })
           )
        }
    }
   
    @ViewBuilder
        func clearButton(color: Color) -> some View {
        Button {
            selectedColor = color
        } label: {
            Image(systemName: "pencil.tip.crop.circle.badge.minus")
                .font(.largeTitle)
                .foregroundColor(.gray)
           
        }
    }

    @ViewBuilder
    func colorButton(color: Color) -> some View {
        Button {
            selectedColor = color
        } label: {
            Image(systemName: "circle.fill")
                .font(.largeTitle)
                .foregroundColor(color)
                .mask {
                    Image(systemName: "pencil.tip")
                        .font(.largeTitle)
            }
        }
      }

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

