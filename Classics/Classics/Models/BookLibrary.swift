//
//  BookLibrary.swift
//  Classics
//
//  Created by New User on 18/10/20.
//

import Foundation

struct Book : Codable, Identifiable{
    let id = UUID()
    let author : String?
    let country : String
    let image : String
    let language : String
    let link : String
    let pages : Int
    let title : String
    let year : Int
    var currentlyReading : Bool
    var noteList : [Note]
    var progress : Int
    
    enum CodingKeys : String, CodingKey {
        case author
        case country
        case image
        case language
        case link
        case pages
        case title
        case year
        case currentlyReading
        case noteList
        case progress
        
//        enum NoteListKey : String, CodingKey{
//            case notes
//        }
    }
    
    // Create custom decoder to add currentlyReading attribute and progress attribute to the model
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let author = try container.decodeIfPresent(String.self, forKey: .author){
            self.author = author
        }else{
            self.author = nil
        }
        country = try container.decode(String.self, forKey: .country)
        image = try container.decode(String.self, forKey: .image)
        language = try container.decode(String.self, forKey: .language)
        link = try container.decode(String.self, forKey: .link)
        pages = try container.decode(Int.self, forKey: .pages)
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(Int.self, forKey: .year)
        if let currentlyReading = try container.decodeIfPresent(Bool.self, forKey: .currentlyReading){
            self.currentlyReading = currentlyReading
        }else{
            self.currentlyReading = false
        }
        if let progress = try container.decodeIfPresent(Int.self, forKey: .progress){
            self.progress = progress
        }else{
            self.progress = 0
        }
        
        if let noteList = try container.decodeIfPresent([Note].self, forKey: .noteList){
            self.noteList = noteList
        }else{
            self.noteList = []
        }
        
//        let noteListContainer = try? container.nestedContainer(keyedBy: CodingKeys.NoteListKey.self, forKey: .noteList)
//        if noteListContainer != nil {
//            if let notes = try noteListContainer!.decodeIfPresent([Note].self, forKey: .notes){
//                self.noteList = notes
//            }else{
//                self.noteList = []
//            }
//        }else{
//            self.noteList = []
//        }
    }
    
    mutating func addNote(noteBody : String){
        let note = Note(time: self.getCurrentTimeStamp(), progress: self.progress, modified: false, noteBody: noteBody)
        self.noteList.append(note)
    }
    
    func getCurrentTimeStamp() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.string(from: Date())
    }
    
    mutating func deleteNote(indexSet: IndexSet){
        indexSet.forEach { (i) in
            self.noteList.remove(at: self.noteList.count - i)
        }
    }
}

typealias AllBooks = [Book]

class BookLibrary : ObservableObject{
    
    @Published var allBooks : AllBooks
    
    let destinationURL : URL
    
    init() {
        
        let filename = "books"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        
        
        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            allBooks = try decoder.decode(AllBooks.self, from: data)
        } catch  {
           print("Error info: \(error)")
            allBooks = []
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data  = try encoder.encode(allBooks)
            try data.write(to: self.destinationURL)
        } catch  {
            print("Error writing: \(error)")
        }
    }
    
    func bookTitle(using titleFor: (Book) -> String) -> [String] {
        let titles = Set(allBooks.map(titleFor))
        return titles.sorted()
    }
    
    func getBookPlace(book: Book) -> Int{
        return allBooks.firstIndex(where: {$0.id == book.id})!
    }
    
    func addToReadingList(book: Book){
        allBooks[self.getBookPlace(book: book)].currentlyReading = true
    }

    func bookIndices(for property: (Book) -> Bool) -> [Int] {
        let filteredBooks = allBooks.filter(property)
        let indices = filteredBooks.map {s in allBooks.firstIndex(where: {$0.title == s.title})!}
        return indices
    }
    
}
