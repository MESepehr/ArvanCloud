package src.pages
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class Precenter extends Sprite
    {
        private var w:Number,h:Number,frameCol:uint;
        public function Precenter(W:Number,H:Number,frameColor:uint=0xEFF0F4)
        {
            super();
            w = W;
            h = H;
            frameCol = frameColor ;
        }

        public function setUp(precent:Number=0):void
        {
            precent = Math.max(0,Math.min(1,precent));

            this.graphics.clear();
            this.graphics.lineStyle(1,frameCol,1);
            this.graphics.drawRect(0,0,w,h);
            this.graphics.lineStyle(-1,0,0);
            this.graphics.beginFill(
                Math.floor(0xff*(precent))*0x010000+
                Math.floor(0xff*(1-precent))*0x0100+
                0x00,0.5
            );
            this.graphics.drawRect(0,0,w*precent,h);
        }
    }
}