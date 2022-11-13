//
//  PopupStatusView.swift
//  ApptioDriveMenubar
//
//  Created by Pushkar Sharma on 12/11/22.
//

import SwiftUI

struct PopupStatusView: View {
    
    var fileItems = FileItem.all()
    @Environment(\.openURL) var openURL
    @State var degress = 0.0
    
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(width: 300, height: 375)
            
            VStack {
                Group {
                    Text("").font(.caption)
                    HStack {
                        Image("apptio-logo")
                            .resizable()
                            .frame(width: 100, height: 27)
                    }
                }

                Text("").font(.caption)
                
                HStack {
                    Text("").font(.caption)
                    Text("").font(.caption)
                    Image("userpic")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                                        
                    VStack(alignment: .leading) {
                        Text("Pushkar Sharma").font(.headline)
                        Text("Apptio.com (apptio.com:it)")
                        Text("Using 1.4GB of 15GB")
                    }
                    Spacer()
                }.frame(alignment: .topLeading)
                
                Group {
                    Text("").font(.caption)
                    Divider()
                    Spacer()

                }
                
                List(self.fileItems, id: \.name) { item in
                    HStack {
                        if item.status == "uploading" {
                            Circle()
                                .trim(from: 0.0, to: 0.6)
                                .stroke(.blue, lineWidth: 3.5)
                                .frame(width: 16, height: 16)
                                .rotationEffect(Angle(degrees: degress))
                                .onAppear(perform: {self.start()})
                                .padding(3)
                            
                        } else {
                            Image("tick")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(1)
                        }
                        Text(item.name)
                    }
                }

                Spacer()
                Text("").font(.caption)
                HStack {
                    Spacer()
                    Button("Browse in Apptio") {
                        openURL(URL(string: "https://www.apptio.com")!)
                    }.buttonStyle(.borderedProminent)
                    Button("Quit") {
                        NSApp.terminate(self)
                    }.buttonStyle(.borderedProminent)
                    Spacer()
                }
                Text("").font(.caption)
            }
        }
//        .onReceive(timer, perform: { _ in
//            print("updating")
//            fileItems = FileItem.all()
//        })
    }
    
    func start() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation {
                self.degress += 10.0
            }
            if self.degress == 360.0 {
                self.degress = 0.0
            }
        }
    }
}

struct PopupStatusView_Previews: PreviewProvider {
    static var previews: some View {
        PopupStatusView()
    }
}
