

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
    init(_ globalSet:{String:Bool}){
        self.globalSet = globalSet
    }

    pub fun print(canvas: Canvas): @Picture? {

        let isPresent = self.globalSet[canvas.pixels] ?? false
        if(isPresent){
            log("Canvas already present")
            return nil
        }
        else{
            self.globalSet[canvas.pixels] = true;
            let picture <-create Picture(canvas: canvas)
            return <- picture   
        }
    }
}

pub fun main(){

    let pixelArray1 = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"
    ]

    let pixelArray2 = [
        "*   *",
        " *** ",
        " *** ",
        " *** ",
        "*   *"
    ]

    let canvas1 = Canvas(width: 5, height: 5, pixels: serialise(pixelArray: pixelArray1))

    let canvas2 = Canvas(width: 5, height: 5, pixels: serialise(pixelArray: pixelArray2))

    let printer <- create Printer({})
    let picture1 <- printer.print(canvas: canvas1)
    let picture2 <- printer.print(canvas: canvas2)
    let picture3 <- printer.print(canvas: canvas2)
    

    destroy picture1;
    destroy picture2;
    destroy picture3;
    destroy printer
    
}

 