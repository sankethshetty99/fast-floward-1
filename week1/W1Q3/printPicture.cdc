import Artist from 0x01

transaction() {


let picture: @Artist.Picture
let collectionRef: &Artist.Collection


prepare(account: AuthAccount){


let printerRef = getAccount(0x01).getCapability<&Artist.Printer>(/public/ArtistPicturePrinter).borrow() ?? panic("could'nt borrow")

let canvas = Artist.Canvas(width:5, height:5, pixels: "*   * * *   *   * * *   *")

self.picture <- printerRef.print(canvas: canvas)!

self.collectionRef = account.getCapability<&Artist.Collection>(/public/ArtistCollection).borrow() ?? panic("could'nt borrow")

}


execute{

    self.collectionRef.deposit(<-self.picture)

}

}