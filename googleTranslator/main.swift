//
//  main.swift
//  googleTranslator
//
//  Created by Josef Grinspun on 14.10.19.
//  Copyright © 2019 Josef Grinspun. All rights reserved.
//

import Foundation

func parseAnswer(_ array: [Any]) -> String {
	
	guard
		let firstArray = array[0] as? [Any],
		let secondArray = firstArray[0] as? [Any],
		let answer = secondArray[0] as? String
	else {
		return "nothing found"
	}
	
	return answer
}

let fromLanguage = "de"
let toLanguague = "en"

let question = CommandLine.arguments[1]

var urlString = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=\(fromLanguage)&tl=\(toLanguague)&dt=t&q=\(question)"

let url = URL(string:  urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

let dispatchGroup = DispatchGroup()

dispatchGroup.enter()
URLSession.shared.dataTask(with: url) { (data, response, error) in
	
	guard
		let data = data,
		let array = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any]
	else {
		print("error fetching data")
		return
	}
	
	print(parseAnswer(array))
	dispatchGroup.leave()
}.resume()


dispatchGroup.wait()

 
