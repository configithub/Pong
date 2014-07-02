package 
{
	import flash.display.MovieClip;
	import flashx.textLayout.formats.Float;

	public class Ball extends MovieClip 
	{
		public var ball_speed_x:int;
		public var ball_speed_y:int;
		
		public var accel_factor:Number;
		
		public function Ball() {
			ball_speed_x = 10;
			ball_speed_y = 6;
			x = 200;
			y = 150;
			accel_factor = 0.5;
	    }
		
		public function loop():int {
			x += ball_speed_x;
			y += ball_speed_y;
			
			if( x + width / 2 > stage.stageWidth) {
				ball_speed_x *= -1;
				return -1;
			}
			else if(x < width / 2 ) {
				ball_speed_x *= -1;
				return 1; 
			}
			if( y + height / 2 > stage.stageHeight || y < height / 2 ) {
				ball_speed_y *= -1;
			}
			return 0;
		}
		
 
	}
}