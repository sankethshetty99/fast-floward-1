import Artist from "./contract.cdc"

// Print a Picture and store it in the authorizing account's Picture Collection.
transaction(width: UInt8, height: UInt8, pixels: String) {

let picture: @Artist.Picture?
let collectionRef: &Artist.Collection

prepare(account: AuthAccount){


let printerRef = getAccount(0x1cf0e2f2f715450).getCapability<&Artist.Printer>(/public/ArtistPicturePrinter).borrow() ?? panic("could'nt borrow")

let canvas = Artist.Canvas(width:width, height:height, pixels: pixels)

self.picture <- printerRef.print(canvas: canvas)

self.collectionRef = account.getCapability<&Artist.Collection>(/public/ArtistCollection).borrow() ?? panic("could'nt borrow")

}


execute{

    if self.picture!= nil{
        self.collectionRef.deposit(<-self.picture!)
    }
    else{
        destroy self.picture
    }
    

}



}