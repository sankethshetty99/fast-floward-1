
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

pub fun createFrame(pixelArray: [String]): [String] {  
    var topFrame = "+";
    var bottomFrame= "+";
    var n = pixelArray[0].length;
    while(n>0){
        topFrame = topFrame.concat("-");
        bottomFrame = bottomFrame.concat("-");
        n = n-1;
        if(n==0){
            topFrame = topFrame.concat("+");
            bottomFrame = bottomFrame.concat("+");
        }
    }
    var framedPixelArray:[String] = [];
    framedPixelArray.append(topFrame)
    var m = 0;
    while(m < pixelArray.length){
        framedPixelArray.append("|".concat(pixelArray[m]).concat("|"))
        m = m+1;
    }
    framedPixelArray.append(bottomFrame)
    //log(framedPixelArray)
    
    return framedPixelArray;
}

pub resource Picture{
    pub let canvas:Canvas

    init(canvas: Canvas){
        self.canvas = canvas;
    }
}

pub fun display(canvas: Canvas){
    let framedPixelArray:[String] = deserialise(pixelsAsString: canvas.pixels, breakPoint: canvas.width)
    for line in framedPixelArray{
        log(line)
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

pub fun main(){

    let pixelArray = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"
    ]

    let framedPixelArray = createFrame(pixelArray: pixelArray)

    let canvas = Canvas(width:UInt8(framedPixelArray[0].length), height:UInt8(framedPixelArray.length), pixels: serialise(pixelArray: framedPixelArray))

    display(canvas: canvas)
    
}

 