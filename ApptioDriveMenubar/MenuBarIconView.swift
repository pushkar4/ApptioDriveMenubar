//
//  MenuBarIconView.swift
//  ApptioDriveMenubar
//
//  Created by Pushkar Sharma on 12/11/22.
//

import SwiftUI

struct MenuBarIconView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                .fill(.black)
                .frame(width: 60, height: 19)
                .opacity(0.7)
                .padding(2)
            
            HStack(spacing: 2) {
                Image(systemName: "circle.fill")
                    .imageScale(.small)
                    .foregroundColor(.green)
                    .opacity(0.9)
                
                Text("Apptio")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .opacity(0.8)
            }
        }
    }
}

struct MenuBarIconView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarIconView()
    }
}
