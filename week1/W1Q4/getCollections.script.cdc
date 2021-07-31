import Artist from 0x01


pub fun main(){

  let accounts = [
    getAccount(0x01),
    getAccount(0x02),
    getAccount(0x03),
    getAccount(0x04),
    getAccount(0x05)

  
  ]
  
  for acc in accounts{
    var collectionRef = acc.getCapability<&Artist.Collection>(/public/ArtistCollection).borrow()

    if collectionRef == nil {
      log("Account ".concat(acc.address.toString().concat(" does not have a collection of pictures")))
      
    }
    else{

      if collectionRef!.getCanvases().length == 0 {
        log("Account ".concat(acc.address.toString().concat(" does not have a collection of pictures")))
      }
      for canvas in collectionRef!.getCanvases(){
        log("Account ".concat(acc.address.toString()).concat(" has the picture"))
        for row in Artist.deserialise(pixelsAsString: canvas.pixels, breakPoint: canvas.width) {
          log(row)

        }
        

      }
    }

  }
  

}
