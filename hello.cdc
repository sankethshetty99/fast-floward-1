

pub struct Canvas{
    pub let width: UInt8;
    pub let height: UInt8;

    init(width:UInt8, height:UInt8){
        self.width = width;
        self.height = height;
    }

}

pub fun display(canvas: Canvas){
    log(canvas.width)
    log(canvas.height)
}

pub fun main(){

    let canvas = Canvas(width:5, height:5)

    display(canvas: canvas)
    

}

 