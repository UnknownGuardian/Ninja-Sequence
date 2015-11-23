package  
{
	import com.greensock.TweenLite;
	import net.flashpunk.Engine;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Assets 
	{
		[Embed(source = "assets/tiles/tiles_ss.png")]public static const LEVEL_TILESET:Class;
		
		[Embed(source="assets/Music/day.mp3")]private static const DAY_V2:Class;
		public static var DayMusic:Sfx = new Sfx(DAY_V2, null, "music");
		[Embed(source = "assets/Music/Music_for_Sequence_level_select_day.mp3")]public static const LEVEL_SELECT_DAY:Class;
		public static var MainMenuMusic:Sfx = new Sfx(LEVEL_SELECT_DAY, null, "music");
		[Embed(source = "assets/Music/Music_for_Sequence_level_select_night.mp3")]public static const LEVEL_SELECT_NIGHT:Class;
		public static var LevelSelectMusic:Sfx = new Sfx(LEVEL_SELECT_NIGHT, null, "music");
		[Embed(source = "assets/Music/Music_for_Sequence_night_v2.mp3")]public static const NIGHT_V2:Class;
		public static var NightMusic:Sfx = new Sfx(NIGHT_V2, null, "music");
		[Embed(source = "assets/Music/Music_for_Sequence_victory.mp3")]public static const VICTORY:Class;
		public static var VictorySound:Sfx = new Sfx(VICTORY, null, "music");
		[Embed(source = "assets/sfx/key_unlock.mp3")]public static const KEY_UNLOCK:Class;
		public static var KeySound:Sfx = new Sfx(KEY_UNLOCK, null, "sfx");
		[Embed(source = "assets/sfx/on_hit.mp3")]public static const HIT:Class;
		public static var HitSound:Sfx = new Sfx(HIT, null, "sfx");
		[Embed(source = "assets/sfx/ring_taken.mp3")]public static const RING:Class;
		public static var RingSound:Sfx = new Sfx(RING, null, "sfx");
		[Embed(source = "assets/sfx/sensei.mp3")]public static const SENSEI:Class;
		public static var SenseiSound:Sfx = new Sfx(SENSEI, null, "sfx");
		
		public static function playSfx(s:Sfx):void
		{
			//if (!Preferences.sfxMuted)
			//{
				s.play(s.volume);
			//}
		}
		public static function playMusic(s:Sfx):void
		{
			//if (!Preferences.musicMuted)
			//{
				s.play(s.volume);
			//}
		}
		public static function loopMusic(s:Sfx):void
		{
			//trace(Preferences.musicMuted);
			//if (!Preferences.musicMuted)
			{
				trace(s.volume);
				s.loop(s.volume);
				//trace("sss");
			}
		}
		
		
		
		//music only functions
		public static function fadeIn(s:Sfx, t:Number):void
		{
			if (Preferences.musicMuted) return;
			s.volume = 0;
			TweenLite.to(s, t, { volume:1, overwrite:true} );
		}
		public static function fadeOut(s:Sfx, t:Number):void
		
		{
			//if (Preferences.musicMuted) return;
			TweenLite.to(s, t, { volume:0, onComplete:function():void { s.volume = 1; s.stop() }, overwrite:true } );
		}
		
		
		
		
		
		public static function muteMusic():void
		{
			Sfx.setVolume("music", 0);
			DayMusic.volume = NightMusic.volume = MainMenuMusic.volume = LevelSelectMusic.volume = 0;
		}
		public static function unmuteMusic():void
		{
			Sfx.setVolume("music", 1);
			DayMusic.volume = NightMusic.volume = MainMenuMusic.volume = LevelSelectMusic.volume = 1;
		}
		public static function muteSfx():void
		{
			Sfx.setVolume("sfx", 0);
			VictorySound.volume = KeySound.volume = HitSound.volume = RingSound.volume = SenseiSound.volume = 0;
		}
		public static function unmuteSfx():void
		{
			Sfx.setVolume("sfx", 1);
			VictorySound.volume = KeySound.volume = HitSound.volume = RingSound.volume = SenseiSound.volume = 1;
		}
		
		public static function checkIfAllLevelsBeatFully():Boolean
		{
			var maxLevelUnlocked:int = Data.readInt("MaxLevelUnlocked", 1);
			trace(maxLevelUnlocked + "check");
			if (maxLevelUnlocked < 20) return false;
			for (var i:int = 1; i < maxLevelUnlocked; i++)
			{
				var amount:int = Data.readInt("L" + i, 0);
				if (amount < 3) return false;
			}
			return true;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		public static var MainEngine:Engine;
		public static var WorldMainMenu:MainMenu;
		public static var WorldGameWorld:GameWorld;
		public static var WorldLevelSelect:LevelSelectMenu;
		
		public static var clouds:Vector.<Cloud> = new Vector.<Cloud>();
		public static var sun:Sun = new Sun();
		public static var bg:FarBackground = new FarBackground(true, false);
		
		public static var LevelToBeLoaded:int = 1;
		public static const LEVEL_1:String = "7dbBCoAgDADQH5JoJFH/5sdHt04RqYH00JOH5xxjLkqJNcVe5tRpTWQyuVaO5W43u+PBUTN7Ro9Ld6/Bd49g1/UVrZbccBkryWRyRzmfn1i3mFvK+epugwT9lTxG2UUeMOisc5DNjPJMJpPJZDKZbGKUZzKZTCaTyeSfTIwH";
		public static const LEVEL_2:String = "7dZRCoAgEAXAC0m0ZXQ5D98B+kjMpGLQX8d1RXxRyrKnWMqcHhoTmUy+I8faMpv3uiqUzWbXLhzwPCvOxPYRvUAWM8lk8iA5cmc6dy46u8IPy1k3hsmxdafjNDRaZiSTyWQymUwmS4z6TCaTyWQymfy3xHgA";
		public static const LEVEL_3:String = "7dY7DoAgDADQCxlj4yfxbhzezcFFQUlEX8oCwytpCmmkFEsXaxq6StGTyeR7coyFqzDZ+W3Z7dkXN2/V9/2xtf9Zm7znX5jHN0yuFEZOMpnckDxlnqvzf+SYchrikUvHXIWOPXQH2cxIJpPJZDKZTDYxqjOZTCaTyWTydybGDQ==";
		public static const LEVEL_4:String = "7dZNCsMgEAbQC4WSaW2gd/Pw3ZUujJTo9I/HuHHzBj+Dmaj1fFu2ui5JdSKPynFprMkNdjb/bDdj7ayxVofOxGa/yZ7wyHQ7dMEJ+MpuXWUOP/7H672tUxoYMH5GNnySE+Qo4niq702j+KDJH5aLNBLluKbQ8ShBmxnlTCaTyWQymUw2MZLJZDKZTCaTX58Y7w==";
		public static const LEVEL_5:String = "7dZLCoAwDAXAC4kYrbfr4d268YO1FXVId4VJSCm8yDnmbkx56CpV316O6fq51O3MuGz2F+z9L3NTh+Obv+r1d7/B0On0e5JHcZ83prLiyrZBLpeTbZDJ5Efl1Gjm5AUrybG92pgrTB2r8oYyI5lMJpPJZDJZYiSTyWQymUwmt0iMCw==";
		public static const LEVEL_6:String = "7dZBCoAgEIXhC0nMI4sO5+HbBS2ixBlk4mdcufiUcYSn1nQU7c1KUC3IPbLW9+VySsc2tqN981Lj36bS4/rpdEuLu/XlcTp8TrDI61v0zFvgj8WeZZNfBooEiuwgV7qRVq50Y6pch2XxhMhzZW0htK6i0WRGZGRkZGRkZGRkEiMyMjIyMjIyMvI/EuMJ";
		public static const LEVEL_7:String = "7dZRCoAgEEXRDUlMKLQ5F18UlEJ9BPOkiYtC1scRX2Yz15ot5WpJ1KZvyHNuL/vg6DLevqyfy2+7/xziJTw+Qg+vy3dlS8Xy+2822tEzXLf7wBz9aw6VblrcsMcFLt6KF+yp3x07ngXUq/b7anWLd2sieelvS4g84siFNHiD5IyMjCyW+XdTMyIjIyMjIyMjI1MxIiMjIyMjIyMjj6kYVw==";
		public static const LEVEL_8:String = "7dYxDoAgDIXhCxFjgYHDcXhHdRBRWgHzRxej+WoeVCs5++R8yKszOpaapyRUnQplHt64t6tesc3fy2jn/wVusW960u1raWtfL6a+rtqlHWvMsgYVKeh8Jk/K8Roe/tV/XK1GqekmszVnG7vhbDA5k8b4shjJkszodUp51M0RaZWuciQNMzmSxo9koVWYGckZGRkZGRkZGZmJkTSQkZGRkZGRkZFLE+MG";
		public static const LEVEL_9:String = "7dZbCoAgEAXQDUUoWatz8W0gLLCpjIN+yvGBjjfXuqxTTjVNQW0mk9+U8xLeG1P37aNhd89yyU5o9MO3L/LVRNaAdi3o2Az9p/rpB/JR/vHvXDwlk78TqXtKUwmj02ty3g6GlFsXXQY6jvFk75scIRenITOSyWQymUwmkyVGMplMJpPJZPKQiXEH";
		public static const LEVEL_10:String = "7dZBCoAgEIXhC0U0aaB38/DVJoQKGnGM8kdXLb4ZnhojKYkbXJoGozVef9+KFu+iak+axf6uLTOhYGM/tE/PhVBu/ir5JhhsW1s3/5TOQ3ZzXYWVPtjzK7L45k37LoNGRn5f9l2n4bkbyF3IspjQcqwfBs3MiIyMjIyMjIyMzMSI3EAWMaLjjlt1HThD5Aay7nUoaO3rUHUdGia9JZTvunzMC3GvkZFrzI4r";
		public static const LEVEL_11:String = "7ZZRDsIwDEMvNCFMK0Tv1sOD0CbRMTqmxiqhVr728+o6zhrkjDTFfJ5IdepLDquyJH/+GpGMi2s7HvIdoh01cSh02ChWF3nkZ3BfL2Ce6tnewJuY0ODIcvEiBG/2NKYv7JnTgt65ASN+luSqcJboxvCVQ7/Sb/oUBEND6lvTl+S/3SJ9khHd2hHVQpFFJpBBJON6fHi7i1Y4xiBHufGLZO2MIossssgiiyyyyCJrYxSZTIZfO5JDsrMWCu1qxBMx07eZASs0sHGClR9VlUb5AIgBgYE3XVIN/sAUxlv/q+H1GTi+P94B";
		public static const LEVEL_12:String = "7Zn9CsIwDMRfaASzVKjvtodXEaeydk0/0tVx5B9x9bfr5RoK8rK4aXbLZTIqOo4sjwp9HllzaBcjk6W5G+9Ofcg8Dx07yYhhC7Lkm07aQLQllzSuyuhaskTskGo7pJnReb9VrD5k2kWjsT4QFTu1u+B79GgJaUp5uvOc4omonKrUYuZLaIdd8/F686ZrW2Gp2ULFJ83wvMj+d0OSE3XKmyPIv+XghhHZwQ2QQQYZ5Ewyu5PaEdsXX01E81rd7MCdEWSQQQYZZJBBBhlk3BhBNiUzG6FvT7iVao8eFnVOhS7rnFK1xzns8T8yV4aGlOH44uljQzuqfIzni4RHRbWYIP6PM6IIQmoJFY+P9BIqnx8eMyTjBnkH";
		public static const LEVEL_13:String = "7dmBDoIgEAbgF3LN60jw3Xj4ispI8EDl1sp/uGVzfJzHoWyS92w6Yt93Su0EGfI3ZNtxs2Y/ZF4Ylc73Iz4Pf6NTqR8nYwhd5DbrmMV1kv7r8uaUrwlaLoU2CYmgCrNhhUzVPlsKeV9vcbJanUDWll+PTVZ7KVi8IvVkbCYhQ/4beRBls1MmtZjXyqU7IfOkyS3aQ5qvRlFryman3KvEjFVYli/IBmTsGZFnyJAhQ4YMGTJk7BiRZ8iQI5kouTQ+LhS/6VEBH0uKC+39GwdApcDdxht3BykQYXqkmauwo+lJpLGmcuTAXQ6i+eTdRp6ObSl3eI4cWg6FU7sUkOkD7SGv";
		public static const LEVEL_14:String = "7diBDoIgFAXQH3KOG7Ds3/j4GDZ6NS1j76W4O5yZG2f0ugITKcUhJjcYtXEv2a80DXnpLi4/0cuDUaLdSelKKtuF8za2PzC9/nzIa5VRO/2M5M7XejJL4ArXYDu7ojjLem+bN5uLvSFmzfajY/7wEilfyk21uftFd+0P5pef79/WNnXaYnHvS56jIdLRw27nkHJiNc4jI5yqHIHhkHNeNKJRGgtNuS85sBqj0STK1FHmnpEyZcqUKVOmTJkyd4w7yTfK87sqmNAAK92VnP8weejysi/UIzLV9tRgVe+pi4wAf4qfTIuODd1hT+IMu4rAbvVCn0vuh6mEe5Cj7CLv";
		public static const LEVEL_15:String = "7dYBDoMgDAXQCxGzDnDubhx+xuEGzkFRatD8VCNGfMFSCeTcoMi6mxKKDjLkq8q6MGrIdPfHym2ZHz+Px6jVI2jXkMP7/8/yctg/9fY2WbO+OjmjB8pzz3H6mVMVdi6032VWQc93P9DmJzxLf35Flp3Q195aFhC/uHkyc5nq8rmUkzV/SWpAXnrnkTcGNpGQIUMWkfvxNP4atmvIc8TtVrJBpokp7AVlc7ox18+zxcIhJLN+6OayQVaIpikaSQf2jJAhQ4YMGTJkyJCxY4QMGXIihil+28jzFeRnsUzidL7GqoyayB/7s00oPsiQvxvHFw==";
		public static const LEVEL_16:String = "7ZmLEoIgEEV/yGHY1gr/zY8vKfEFurwMbIfKUem4e/eCWND3iA2oXjaZmljuw21vN45tbweXcJ0WZyhCTP/d7fPyoyMxImoRAtDUyyVC4wEZLf5D3WLZ7m/hscoUtI7003lGQnMwUO05aK0D+tdD+NQJjbUlzd/Cy2Bo9BkTM1cgirKfAC6SScse2nNzBJNHHS+2dGiNVksFlHFhj8km8ZpglgEfOIUlIkeY7/ygTbDplU7hjtXtwtwq4p0ts0ldFLkvKeb2ujqfSL6zGmG+YtddgvzQrTY14J4FDaZVJkfLjq6czBXkNSPrzGQmM5nJTGYyk5nMK8Z8MXfDg+PqOfK7gZ8IYgnI8gczNTZqR+EfpHQGmsUikObnCFXciIGtrAGFdrAhkFT0HPJORWczbnerW+jc19kd4IdW+dA1OiTE4oXIofR7+qxoRj1HaBOsav7J0qtx3PE60nsd+QI="
		public static const LEVEL_17:String = "7ZqBjsIgDIZfaCFWpsfebQ9/bhOF0kI7cXqXhuh04MfPT9tjycE8n2E4j/NpeFNznyHDefBJQzduX3rJbqPE6BvqTmtAa92OY6qkckPdjuWTQ6ibjjeE2Nz4ppjkoFjcZBeKkgg8lZHILSDeF2v395fAcd9EZz96KpepiGjGj4KeX6V0Qfj5OJdHCYbdf8r0olxVJz9BTxiy7K94WMfvbbkstfcxaKpKSHhhMp/lgkE79CvLo39bmelHRtL5CtMvcHpa8giJLDAOP2SUxeom5kfpmftvh66X2mxuGPm7yKO58QfJF3PDyIeTR3ODaNe16WijgHxF136aFyJcEBrGTn7A2iw67MxoZCMb2chGNrKRjWxkOzF+Fzkszyvbw8pEdj66+6teJgSe7/DY5Akr1ccvrTKBQvj68zsDhFOQeKAMSDpDbRF67WGgXEJK8Ra7Uh3w+4DWRpsxJRRHS5QuaKJczJUTmz0NOsOU/4RCOhvjBfKu8kM6QWgkC5p2yi7Zd4l8cn9D8flRIQKl0TGhDcoiUM1SECQoE9+bYDpunAzQmBBV0ZbrsMcOfkuDIKZD3YvQsaTX/2K4ho2KaCktdc1x++W/VLaqhejjB4pJm7B22sSnzV8=";
		public static const LEVEL_18:String = "7dbLCoAgEIXhF5JovES9mw/fTiIMx1sL+TkuAuVrkIgjMVox4uNuJmX7Vxbbu6rfpx0YGxsbGxsbG7vYWdzjjBtRVt5xH8/9ha5JXqaEIq8i+4Yd7hl5pCye68gkDJI9nx3ycvKRMuWXFKYMLSlqmc6IjIyMjIyMjIxMY+yWT2XqZdENdkFDQ0NDQ0P305JfhRO0Sm2rvAE=";
		public static const LEVEL_19:String = "7dZbDoIwFEXRCRHTQ4rA3Bi8xg+EhD6sLY+yc/0QC4tD5UI1Ta0a2ck0heqxt6z2+3EdG7OP9wwxAbGxi9kX7UzHpnskNbcbv0Ty/l0lktM72EfYwVftP+/jiPzhy4ux+9XPfQ7beGlzcnldkXJFa03kOmSbMMI8I+eUZZmOjeoyyZbbDvkQ+bmoIg+OrkBoLeoEE82aERkZGRkZGRkZmRVjBnn4VNqoX1Y41gh9Z3qffpG2vqbbcl24cs7I+OufUH9ss3gUDfQj9NzUgb4O7+G/tZUculL6fovJFw==";
		public static const LEVEL_20:String = "7ZnxEoIgDMZfiOucksC7+fCpWNpJMdEp1HfzD038Nbdvu1HUdXWlatNVSshuv0Smejj8ueltvjNfLddspsedS2Qjj9eQp3TNoojKI0Uia3yiTAzjlUxm5NWrhgPwR4VTZiORU0i4XFhRujbYZyby0KCcl8syqsZHthntfWxoXpY+OGTcozBYJpBbRaO1EmQznRyPfppEoD1Vi5ErkEFeaNjruA18ll/j0Cc3Oy1GvmPHCDLIV/xOofNxGjMjyCCDDDLIIIMMMsiYGA8i07ebLkOnLeNpi1LZ//cHRQVBH1alue34usxkj0wqFgAm23G/EbIup330yvCHWDVuW8R23I5WUhpduD5sCS1VKImYbPZNkA8=";
		public static const LEVEL_99:String = "7ZgLkoMgDIYv1GFE0ZS7efi1C+uDh0AIqF0mrWMVPn5CEpjyee77F+dz9ypkrAaZ959PWv/zDhoO6xNYbFhs6aZu1UvQ178Gv9SQFguOsW2k43BIuKVZP7DgzskFvR+zPCzXJf7hItAnCo1XDrjPewH8+tB4C3u1EQvq1W4OcEwUdevhJyeUabCiHYMT0oEK6Ud3hGG5Q7uLhXITdjanynHu3xrnhGKc7vQyrr+bMth715b9ya3oUXiWu2NCDYy+ENg4iRKHpGB72FBgtzfJ7gyJX1eju+UUs4HZWtuQeqAIzXLYBfC2D4DDp2CFoN0HViokhWTxs9vDz5s0Ji7SPB5+TcW8cW+yqKy5dtSNVTRPLo8lkbkIpcdD07uRceTRE2gilJwMF8BLCI6hzGfY7OgQoqeIKlTKHVcFh/CSBaHmSVtOvfN5Q+D3f58mll+dS6/gWC/q2pmxkRu5kRu5kRu5kRu5kb/4xCjVvyN3EM3x6DeBaM4rLqK8VXjIC8mSIvzU2jGCQLgsEfl/r6WyCHnL6kdvWtyezyu3zj7UIVXrdB0yfkpVREty8vvrlhB/evwB";
		
		public function Assets() 
		{
			
		}
	}

}