pub contract Artist {
  
pub event PicturePrintSuccess(pixels: String)
pub event PicturePrintFailure(pixels: String)


pub struct Canvas{
    pub let width: UInt8;
    pub let height: UInt8;
    pub let pixels: String;

    init(width:UInt8, height:UInt8, pixels: String){
        self.width = width;
        self.height = height;
        self.pixels = pixels;
    }

}

pub resource Picture {
    pub let canvas:Canvas

    init(canvas: Canvas){
        self.canvas = canvas;
    }
}

pub resource Collection{

    pub let picCollection: @[Picture]
    init(){
      self.picCollection <- []
    }     
    pub fun deposit(_ picture: @Picture) {
        self.picCollection.append(<-picture)
    }

    pub fun getPixels(): [String] {
        var pixels:[String] = []
        var index = 0

        while index <  self.picCollection.length{
            pixels.append(self.picCollection[index].canvas.pixels)
            index=index+1
        }

        return pixels
    }

    destroy(){
      destroy self.picCollection
    }

    
}

pub fun createCollection(): @Collection {
    return <- create Collection()

}


pub fun serialise(pixelArray:[String]): String {
    var buffer = "";
    for line in pixelArray {
        buffer = buffer.concat(line)
    }
    return buffer;
}

pub fun deserialise(pixelsAsString: String, breakPoint: UInt8): [String] {
    var framedPixelArray: [String] = [];
    var i = 0;
    while(i < pixelsAsString.length){
        framedPixelArray.append(pixelsAsString.slice(from: i, upTo: i+Int(breakPoint)))
        i = i+Int(breakPoint);
    }
    
    return framedPixelArray;
}


pub resource Printer {

    pub let globalSet:{String:Bool}

    init(){
        self.globalSet = {}
    }

    pub fun print(canvas: Canvas): @Picture? {

        let isPresent = self.globalSet[canvas.pixels] ?? false
        if(isPresent){
            log("Canvas already present")
            emit PicturePrintFailure(pixels: canvas.pixels)
            return nil
        }
        else{
            self.globalSet[canvas.pixels] = true;
            let picture <-create Picture(canvas: canvas)
            emit PicturePrintSuccess(pixels: canvas.pixels)
            return <- picture   
        }
    }
}

init(){
   
    let printer <- create Printer()
    //let collection <- create Collection()

    self.account.save(<- printer, to: /storage/ArtistPicturePrinter)
    //self.account.save(<- collection, to: /storage/ArtistCollection)

    self.account.link<&Printer>(/public/ArtistPicturePrinter, target: /storage/ArtistPicturePrinter)
    //self.account.link<&Collection>(/public/ArtistCollection, target: /storage/ArtistCollection)
    
}

 
}

 
