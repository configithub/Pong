package
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;

	public class PongGame extends MovieClip {
		public var gameTimer:Timer;
		
		public var ball:Ball;
		
		public var player_paddle:Paddle;
		public var cpu_paddle:Paddle;
		public var cpu_paddle_speed_y:int;
		public var cpu_paddle_default_speed:int;
		
		public var paddle_margin:int = 20;
		
		public var player_scorefield:TextField;
		public var player_score:int;
		
		public var cpu_scorefield:TextField;
		public var cpu_score:int;
		
		public function PongGame() {
			ball = new Ball();
			addChild(ball);
			
			player_scorefield = new TextField();
			player_scorefield.x = paddle_margin;
			player_scorefield.y = 20;
			player_scorefield.textColor = 0xFF0000;
			player_scorefield.text = "0"; 
			addChild(player_scorefield);
			
			cpu_scorefield = new TextField();
			cpu_scorefield.x = stage.stageWidth - paddle_margin;
			cpu_scorefield.y = 20;
			cpu_scorefield.textColor = 0xFF0000;
			cpu_scorefield.text = "0";
			addChild(cpu_scorefield);
			
			player_paddle = new Paddle();
			player_paddle.x = paddle_margin;
			player_paddle.y = stage.stageHeight / 2;
			addChild(player_paddle);
			
			cpu_paddle = new Paddle();
			cpu_paddle.x = stage.stageWidth - paddle_margin;
			cpu_paddle.y = stage.stageHeight / 2;
			cpu_paddle_default_speed = 6;
			cpu_paddle_speed_y = cpu_paddle_default_speed;
			addChild(cpu_paddle);
			
			gameTimer = new Timer(25);
			gameTimer.addEventListener(TimerEvent.TIMER, loop );
			gameTimer.start();
	
		}
		
		public function ball_player_collision() {
			if((ball.x - ball.width /2 < player_paddle.x + player_paddle.width /2
				&& ball.ball_speed_x < 0)) {
				ball.ball_speed_x *= -1;
			}
			ball.ball_speed_y += int(ball.accel_factor * (ball.y - player_paddle.y)/10);
		}
		
		public function ball_cpu_collision() {
			if((ball.x + ball.width / 2 > cpu_paddle.x - cpu_paddle.width /2
				&& ball.ball_speed_x > 0) ) {
				ball.ball_speed_x *= -1;
			}
			ball.ball_speed_y += int(ball.accel_factor * (ball.y - cpu_paddle.y)/10);
		}
		
		public function player_paddle_loop() {
			player_paddle.y = mouseY;
		}
		
		public function cpu_paddle_loop() {
			if( Math.abs(ball.ball_speed_y) <= Math.abs(cpu_paddle_speed_y) ) {
				cpu_paddle_speed_y = Math.abs(ball.ball_speed_y) ;
			}else{
				cpu_paddle_speed_y = cpu_paddle_default_speed;
			}
			if( ball.y <= cpu_paddle.y) {
				cpu_paddle.y -= cpu_paddle_speed_y;
			}else{
				cpu_paddle.y += cpu_paddle_speed_y;
			}
		}
		
		public function loop( e:TimerEvent ) {
			var ball_score:int;
			ball_score = ball.loop();
			if(ball_score == 1){
				cpu_score++;
				cpu_scorefield.text = cpu_score.toString();
			}else if(ball_score == -1) {
				player_score++;
				player_scorefield.text = player_score.toString();
			};
			player_paddle_loop();
			cpu_paddle_loop();
			
			if(ball.hitTestObject(player_paddle)) {
				ball_player_collision();
			}else if(ball.hitTestObject(cpu_paddle)) {
				ball_cpu_collision();
			}
			
		}
	}
}