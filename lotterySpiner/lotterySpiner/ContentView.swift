//
//  ContentView.swift
//  lotterySpiner
//
//  Created by Macbook Pro on 09/03/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple","star","cherry"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgorounds=Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    @State private var betAmount = 5
    
    
    
    var body: some View {
        
        ZStack{
            
            // background
            
            Rectangle().foregroundColor(Color(red:200/255,green:143/255,blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle().foregroundColor(Color(red:228/255,green:195/255,blue: 76/255)).rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            Spacer()
            VStack {
                
                //MARK: - Title
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Slots")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(2)
                
                Spacer()
                
                Text("credits: "+String(credits))
                    .padding(.all,10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                
                Spacer()
                
                //MARK: - cardsBindedView
                VStack{
                    
                    HStack{
                        Spacer()
                        CardsView(symbol: $symbols[numbers[0]],background: $backgorounds[0])
                        
                        CardsView(symbol: $symbols[numbers[1]],background: $backgorounds[1])
                        
                        CardsView(symbol: $symbols[numbers[2]],background: $backgorounds[2])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CardsView(symbol: $symbols[numbers[3]],background: $backgorounds[3])
                        
                        CardsView(symbol: $symbols[numbers[4]],background: $backgorounds[4])
                        
                        CardsView(symbol: $symbols[numbers[5]],background: $backgorounds[5])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CardsView(symbol: $symbols[numbers[6]],background: $backgorounds[6])
                        
                        CardsView(symbol: $symbols[numbers[7]],background: $backgorounds[7])
                        
                        CardsView(symbol: $symbols[numbers[8]],background: $backgorounds[8])
                        Spacer()
                    }
                    
                    
                }
                Spacer()
                
                //MARK: - spinButton
                HStack(spacing: 20)
                {
                    // single spin buton
                    VStack{
                        Button(action: {
                            self.processResults(false)
                            
                        }, label: {
                            Text("Spin").foregroundColor(.white)
                                .padding(.all,10)
                                .padding([.leading,.trailing],30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        })
                        
                        Text("\(betAmount) credits").font(.footnote).padding(5)
                    }
                    
                    // max spin button
                    VStack{
                        Button(action: {
                            self.processResults(true)
                            
                        }, label: {
                            Text("Max Spin").foregroundColor(.white)
                                .padding(.all,10)
                                .padding([.leading,.trailing],30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        })
                        
                        Text("\(betAmount*5) credits").font(.footnote).padding(5)
                    }
                    
                }
                Spacer()
            }
            
            
            
            
            
            // Zstack
        }
        
    }
    
    //MARK: - Results
    func processResults(_ isMax:Bool=false){
        
        var isMatch=0
        // set white backgrounds
        
        //self.backgorounds[0]=Color.white
        //self.backgorounds[1]=Color.white
        //self.backgorounds[2]=Color.white
        self.backgorounds=self.backgorounds.map({ _ in
            Color.white
        })
        
        
        
        // for single spin
        if !isMax{
            
            //pick random indices to change images
            self.numbers[3]=Int.random(in: 0...self.symbols.count-1)
            
            self.numbers[4]=Int.random(in: 0...self.symbols.count-1)
            
            self.numbers[5]=Int.random(in: 0...self.symbols.count-1)
            
            
            // check winings
            
            if self.numbers[3]==self.numbers[4] && self.numbers[4]==self.numbers[5]{
                
                // add bonus
                credits += betAmount*10
                
                //  change backgtound  color
                self.backgorounds[3]=Color.green
                self.backgorounds[4]=Color.green
                self.backgorounds[5]=Color.green
                
            }
            else{
                credits -= betAmount
            }
        }
        
        // for max spins
        else{
            
            // ramdomizing images
            self.numbers=self.numbers.map({ _ in
                Int.random(in: 0...self.symbols.count-1)
            })
            
            //MARK: - MatchCheck
            // check for top row
            if self.numbers[0]==self.numbers[1] && self.numbers[1]==self.numbers[2]{
                
                isMatch+=1
                
                //  change backgtound  color
                self.backgorounds[0]=Color.blue
                self.backgorounds[1]=Color.blue
                self.backgorounds[2]=Color.blue
                
            }
            
            // check for middle row
            if self.numbers[3]==self.numbers[4] && self.numbers[4]==self.numbers[5]{
                
                isMatch+=1
                
                //  change backgtound  color
                self.backgorounds[3]=Color.green
                self.backgorounds[4]=Color.green
                self.backgorounds[5]=Color.green
                
            }
            
            // check for bottom row
            if self.numbers[6]==self.numbers[7] && self.numbers[7]==self.numbers[8]{
                
                isMatch+=1
                
                //  change backgtound  color
                self.backgorounds[6]=Color.red
                self.backgorounds[7]=Color.red
                self.backgorounds[8]=Color.red
                
            }
            
            
            // for left diagnal
            if self.numbers[0]==self.numbers[4] && self.numbers[4]==self.numbers[8]{
                
                isMatch+=1
                
                //  change backgtound  color
                self.backgorounds[0]=Color.purple
                self.backgorounds[4]=Color.purple
                self.backgorounds[8]=Color.purple
                
            }
            
            
            // for right diagnal
            if self.numbers[2]==self.numbers[4] && self.numbers[4]==self.numbers[6]{
                
                isMatch+=1
                
                //  change backgtound  color
                self.backgorounds[2]=Color.purple
                self.backgorounds[4]=Color.purple
                self.backgorounds[6]=Color.purple
                
            }
            
            if isMatch>0{
                // atleast 1 win, max spin
                self.credits+=isMatch*betAmount*10
            }
            else{
                //0 win,  max spin
                self.credits-=betAmount*5
            }
        }
        
    }
    
    
}

#Preview {
    ContentView()
}
