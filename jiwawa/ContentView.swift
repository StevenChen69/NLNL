//
//  ContentView.swift
//  NLNL
//
//  Created by steven on 2023/1/6.
//

import SwiftUI
import UIKit
import SafariServices

struct ContentView: View {
    init(){
            UITableView.appearance().backgroundColor = .clear
            UISegmentedControl.appearance().setTitleTextAttributes(
                [
                    .font: UIFont.systemFont(ofSize: 18),
                ], for: .normal)
        }
    @State private var ShowImage = false
    @State private var ChooseIndex: Int = 1
    @State private var date = Date()
    @State private var ShowAlert = false
    @State private var Showing = false
    @State private var bgColor = Color.black
    @State private var scale: Double = 0
    @State private var dog = 0.0
    @State private var time  = ""
    @State var urlString = "https://www.youtube.com/watch?v=wFlhf4_bGYc"
    @State var urlString1 = "https://www.twitch.tv/never_loses/about"
    @State private var show = false
    
    let songs = ["名偵探柯能","藍色眼睛","那女孩對我說","陽光宅男","專屬天使"]
    
    var body: some View {
        
        VStack {
          Text("醜狗NL")
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(Color.white)
          if ShowImage{
              Button(action: {ShowAlert = true}){
                  Image("\(ChooseIndex+1)")
                      .resizable()
                      .frame(width: 400, height: 380)
                      .scaledToFit()
                      .cornerRadius(8.0)
              }.alert(isPresented: $ShowAlert) { () -> Alert in
                  let answer = ["本名叫什麼啦？", "OK 永Ban", "素質真差", "屁眼派對！"].randomElement()!
                  return Alert(title: Text(answer))
              }
          }
          Form{
            Toggle("顯示圖片", isOn: $ShowImage.animation())
              DatePicker("今日日期", selection: $date, displayedComponents: .date)
//                    Text("選擇你的醜狗").offset(x: -3, y: 6)
              LoveChoice(ChooseIndex: $ChooseIndex)
              RandomChoice(ChooseIndex: $ChooseIndex)
              HStack{
                  Stepper("想買幾個班長抱枕呢", value: $dog, step: 1)
                  Text("\(Int(dog))個")
           }
              HStack{
                  Text("班長會開台到幾點呢？(24Hr)")
                  TextField("預測時間", text: $time)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                      .keyboardType(.numberPad)
                  Button(action:{
                    ShowAlert = true
                  }){
                    Text("Go")
                      .background(Color.white)
                      .cornerRadius(5.0)
                  }.alert(isPresented: $ShowAlert) { () -> Alert in
                    let answer = ["看來今天是不會開了QQ", "你好天真XD"].randomElement()!
                    return Alert(title: Text(answer))
                }
              }

              DisclosureGroup("NL妹妹的歌手夢") {
                  VStack(alignment: .leading) {
                      ForEach(songs.indices) {  (index) in
                        
                        Button(action:{
                            ShowAlert = true
                        }){
                            Text(songs[index])
                        }.alert(isPresented: $ShowAlert) { () -> Alert in
                            let answer = ["「有考慮當歌手嗎？我當然有考慮當歌手啊那是我的夢想耶，我跟你說當歌手比當職業選手...我當...我當歌手 是...最想當。」"].randomElement()!
                            return Alert(title: Text(answer))
                         }
                      }
                 }
              }
              Button(action: {
                  self.urlString = "https://www.youtube.com/watch?v=wFlhf4_bGYc"
                  self.show.toggle()
              }){
                 HStack{
                    Text("班長の問候")
                    Text("CLICK!")
                      .fontWeight(.heavy)
                      .foregroundColor(bgColor)
                      .frame(width: 250, height: 35, alignment: .trailing)
                   }
              }.sheet(isPresented: $show) {
                  SafariView(url:URL(string: self.urlString)!)
              }
            
              ColorPicker("設定文字顏色", selection: $bgColor)
              VStack{
                Text("一起來控制班長旋轉吧！")
                  .padding()
                Slider(value: $scale, in: 0...360, step: 1)
                
                 Image("fatNL").resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .rotationEffect(.degrees(scale))
             }
          }.frame(maxWidth: .infinity, maxHeight: .infinity)
          .foregroundColor(bgColor)
            
          Spacer()
            
            ZStack{
                Button(action: {
                    self.urlString1 = "https://www.twitch.tv/never_loses/about"
                    self.Showing.toggle()
                }){
                    Text("想要跟熊班長共享歡樂時光(鬼混)嗎？")
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                        .frame(width: 400, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(/*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/)
                        .offset(x: 15,y: -19)
                    Image(systemName: "arrow.forward.circle")
                        .offset(x: -20, y: -19)
                        
                }.sheet(isPresented: $Showing) {
                    SafariView(url:URL(string: self.urlString1)!)
                }
            }
      } .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("galaxy")/*@END_MENU_TOKEN@*/)
    
  }
    
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}

struct LoveChoice: View {
  @Binding var ChooseIndex : Int
  
  var body: some View {
      Picker(selection: $ChooseIndex, label: Text("選擇你的心儀對象")){
          ForEach(0 ..< 13){ item in
              Text("\(item+1)")
          }
      }
      .pickerStyle(MenuPickerStyle())
  }
}



struct RandomChoice: View {
  @Binding var ChooseIndex : Int
  
  var body: some View {
      Button("隨機對象"){
          ChooseIndex = Int.random(in: 0...12)
      }
  }
}

struct SafariView: UIViewControllerRepresentable {
  let url: URL
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
      return SFSafariViewController(url: url)
  }
  
  func updateUIViewController(_ uiViewController: SFSafariViewController,
      context: UIViewControllerRepresentableContext<SafariView>) {

  }
  
}

