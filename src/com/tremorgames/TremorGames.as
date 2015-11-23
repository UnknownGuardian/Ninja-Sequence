package com.tremorgames  {
	
	import com.tremorgames.md5.MD5;
	import flash.net.*;
	import flash.external.ExternalInterface;
	import com.adobe.serialization.json.JSON;
	import flash.events.Event;
	
	public final class TremorGames  {
		
		
		private static var GameID:int;
		private static var WebsiteGameID:int;
		private static var Key:String;
		private static var LoggedIn:Boolean=false;
		private static var PlayerName:String="";
		public static var DefaultNetwokList:Array;
		private static var DomainName:String = "";
		private static var GameName:String = "";
		private static var GameInTremorNetwork:Boolean;
		private static var SponsorURL:String;
		private static var StatsLoaded:Boolean = false; // Stats loaded from server
		private static var StatsData:Object;  //Stats loaded from server
		
		public static function Init(gameid:int,websitegameid:int,gamename:String,key:String,parameters:Object,sponsorurl:String="http://www.tremorgames.com"):void
		{
			DefaultNetwokList = new Array("www.tremorgames.com", "www.tremolearns.com", "www.tremorkids.com","www.tremorx.com","www.tremorgems.com","www.backspacegames.com","www.doxagames.com","www.tremorgirls.com","www.tremorracing.com");
			SponsorURL = sponsorurl;
			
			 WebsiteGameID = websitegameid;
     	     GameID = gameid;
			 Key = key;
			 GameName = gamename;
			 
			 if (DefaultNetwokList.indexOf(GetDomainName()) >= 0)
					GameInTremorNetwork = true;
			else
					GameInTremorNetwork = false;
					
					
			 if (IsGameInTremorNetwork())
			 {
				 var paramObj:Object = parameters;
			     PlayerName = String(paramObj["PlayerName"]);
			 
	            if (PlayerName == null || PlayerName == "" || PlayerName == "undefined" )
	            {
				         PlayerName = "";  
    				     LoggedIn = false;
			    }
			    else
			    {
				      LoggedIn = true ;
   		  	          GetGameStats();

			    }
			 }
				
			// GetGameStats();		 
			//PlayerName = "rudy";
			//LoggedIn = true;
			
						
		}
		
		public static function IsGameInTremorNetwork():Boolean
		{
			
			
			return GameInTremorNetwork;
		}
		
		private static function isNumeric(num:String):Boolean
		{
			return !isNaN(parseInt(num));
		}
		
		public static function IsLoggedIn():Boolean
		{
			return LoggedIn;
		}
		
		
		private static function onStatsReceived(evt:Event):void
		{
			var loader:URLLoader = URLLoader(evt.target) ;
			
			StatsLoaded = true;
		    try
			{
			  StatsData = JSON.decode(loader.data);	
		  
			  var i:int = 0;
			  while (i < StatsData.length)
			  {
				  StatsData[StatsData[i].StatName] = StatsData[i];
				  i++;
			  }
			  
			}
		   	catch (error:Error)
			{
				StatsLoaded = false;
			}
			
			
			
			
				
		}
		
	   
        private static function GetGameStats():void
		{
			var myurl:String = "http://" +  GetDomainName() + "/achievements/json_get_stats.php" ;
			
			var request : URLRequest = new URLRequest(myurl);
			var reqVars : URLVariables = new URLVariables();
		 
			reqVars.PlayerName = PlayerName;
			//reqVars.PlayerName = "rudy";
			reqVars.GameID = GameID;
			
			 
			 
			request.data = reqVars ;
			request.method = URLRequestMethod.GET;
            
			 var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onStatsReceived);

			try
			{
				loader.load(request);
			}
			catch (error:Error)
			{
				//trace('Error: unable to load the document.');
			}
			
		}
		
		
		public  static function PostScore(playername:String,score:Number):void
		{
		   var SubmitScoreURL:String = "";
	    if (IsLoggedIn())
		     SubmitScoreURL =  "http://" + GetDomainName() + "/submitscore.php";
        else
		      SubmitScoreURL =  SponsorURL + "/submitscore.php?utm_source=SponsoredGames&utm_medium=FlashGame&utm_term=" + GetDomainName() + "&utm_content=SubmitScore&utm_campaign=" +  escape(GameName) ;
		   
		 var request : URLRequest = new URLRequest(SubmitScoreURL);
		 var reqVars : URLVariables = new URLVariables();
		 
		 reqVars.Score=score;
		 reqVars.GameID = GameID;
 		 reqVars.Website=GetDomainName();

		 
   	    if (IsLoggedIn())
          			reqVars.PlayerName = PlayerName ;
		else
				      reqVars.PlayerName=playername ;


		 reqVars.Key = MD5.hash(reqVars.PlayerName + Key + reqVars.Score); 
  		 request.method = URLRequestMethod.POST;

		 
		 trace (reqVars.Key);
		 request.data = reqVars ;
		 
		 
  	    if (IsLoggedIn())
		{

		    var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			try
			{
				loader.load(request);
			}
			catch (error:Error)
			{
				//trace('Error: unable to load the document.');
			}
			ExternalInterface.call("onMemberScoreSubmitted", score);  // Call javascript 
			
			
		}
		else
		{
		  trace(request.data.PlayerName);
  		 navigateToURL(request, "_blank"); 
		}
 
   
   
       }
	   
	  
	   
	   // Displays Progress In Web Page
	   
	   public static function DisplayProgress(StatName:String, StatValue:int):void
	   {
   	    if (IsLoggedIn())
		{
		  try
		  {
		   ExternalInterface.call("setStatValue", StatName, StatValue);  // Call javascript to update progress 
		  }
		  catch (er:Error)
		  {
		  }
		}

	   }
	   
	   
	    public static function PostStat(StatName:String,StatValue:int):void
       {
	
	
	    if (IsLoggedIn())
		{
			var StatShouldPost:Boolean = false;
			
			if (StatsLoaded)
			  {
				  try
				  {
					  //Need to check whether we really need to post the stat
					  if ( StatValue > StatsData[StatName].ProgressValue &&  StatsData[StatName].StatType == "Max")
						   StatShouldPost = true;
					  else if ( StatValue < StatsData[StatName].ProgressValue &&  StatsData[StatName].StatType == "Min")
						StatShouldPost = true;
					  else if (StatsData[StatName].StatType == "Cumulative"  && StatValue < StatsData[StatName].Limit )
						StatShouldPost = true;
				  }
				  catch (er:Error)
				  {
					  trace (er.message);
					  StatShouldPost = true;
				  }
				  
				  
			  }
			 else
			 {
				 StatShouldPost = true;
			 }
			 
			 
			
			//FlxG.log ("Should POst=" + StatShouldPost.toString() + " | StatName = " + StatName + " | Previous Value =" + StatsData[StatName].ProgressValue);
			 
			
		if (StatShouldPost)
		{
			var request : URLRequest = new URLRequest("http://" + GetDomainName() + "/achievements/record_stats.php");
			var reqVars : URLVariables = new URLVariables();
		 
			reqVars.PlayerName = PlayerName;
			reqVars.StatName = StatName;
			reqVars.StatValue = StatValue;
			reqVars.GameID = GameID;
			
			reqVars.Key = MD5.hash(reqVars.PlayerName + Key + StatValue.toString()); 
			 
			trace (reqVars.Key);
			 
			request.data = reqVars ;
			request.method = URLRequestMethod.POST;

			 //reqVars.Key="123";
			 //navigateToURL(request,"_blank"); 
			 var loader:URLLoader = new URLLoader();
			 loader.dataFormat = URLLoaderDataFormat.VARIABLES;

			try
			{
				loader.load(request);
				ExternalInterface.call("setStatValue", StatName, StatValue);  // Call javascript to update progress
				if (StatsLoaded)
				{
					if (!isNumeric(StatsData[StatName].ProgressValue))
					   {
						   StatsData[StatName].ProgressValue = StatValue ;
					   }
					   
					else
					{
												
						if (StatsData[StatName].StatType != "Cumulative")
								StatsData[StatName].ProgressValue = StatValue;
						else
							StatsData[StatName].ProgressValue = parseInt(StatsData[StatName].ProgressValue) + StatValue;
								
					}
				}
			}
			catch (error:Error)
			{
				//trace('Error: unable to load the document.');
			}
			
			
			
		}
		else  //if (StatShouldPost)
		{
			ExternalInterface.call("setStatValue", StatName, StatValue);  // Call javascript to update progress
		}
			

			   
   
		}
	   }
	   
	   
	   
	   
	   public static function GetPlayerName():String
	   {
		   
		   return PlayerName;
	   }
	   public static function GetDomainName():String
		{
			if (DomainName == "")
			     {
			     var lc:LocalConnection = new LocalConnection();
				  DomainName  = lc.domain;
				 }
				 
	        return DomainName;
			
		}
		
		public static function GetTrackingURL(LinkName:String):String
		{
			return SponsorURL + "/?utm_source=SponsoredGames&utm_medium=FlashGame&utm_term=" + GetDomainName() + "&utm_content=" + escape(LinkName) + "&utm_campaign=" +  escape(GameName) ;
		}
		
		public static function GetGameURL():String
		{
			return SponsorURL + "/index.php?action=playgame&gameid=" + WebsiteGameID + "&utm_source=SponsoredGames&utm_medium=FlashGame&utm_term=" + GetDomainName() + "&utm_content=" + escape("Achievements") + "&utm_campaign=" +  escape(GameName) ;
		}
		
		
	}
	
}
