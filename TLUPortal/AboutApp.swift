//
//  AboutApp.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 9/4/23.
//

import SwiftUI

func GetAppIcon() -> UIImage {
   var appIcon: UIImage! {
     guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String:Any],
     let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String:Any],
     let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
     let lastIcon = iconFiles.last else { return nil }
     return UIImage(named: lastIcon)
   }
  return appIcon
}

struct AboutApp: View {
    // Custom navigation bar
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var versionString: String = AppVersionProvider.appVersion()
    let appIcon: UIImage = GetAppIcon()
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
            }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(uiImage: appIcon)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
            }
        }
    }
}

struct AboutApp_Previews: PreviewProvider {
    static var previews: some View {
        AboutApp()
    }
}
