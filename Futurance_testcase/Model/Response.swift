//
//  CoinData.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
//

import Foundation
//Decodable parametresini ekleyerek hem decoding işlemini yaparak aldığımız json veriyi kullanabiliyoruz.
struct Response: Codable {
    let symbol : String  //buraya çözülecek bir değişken yazdık. hangisini çözeceksek eğer onu yazıyoruz.
    let lastPrice: String
    let highPrice : String
    let lowPrice : String
    let priceChangePercent : String
}





//burda bize döndürülen api bir liste formatında olduğu için biz de weather'ı bir liste için tanımladık.


//Api'nin urlsine girdiğimde bakınca main adlı değişkenin içinde 4 tane daha değişken vardı. Bu nedenle Main değişkenin içine girmeden o temperature değerini almamızın imkanı yok. Onu alabilmek için yeni bir veritipi belirledik ve bu veri tipine de Decodable yani çözülebilirlik verdik. Bu sayede de artık veriyi çekebilecek hale geldik.

