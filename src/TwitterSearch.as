package 
{
	import flash.display.Sprite;
	import flash.net.URLVariables;
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthToken;
	import org.iotashan.oauth.OAuthRequest;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	
	/**
	 * ...
	 * @author Matthew C Valverde
	 */
	
	 public class  TwitterSearch extends Sprite 
	{
		
		public const Search:String = "https://api.twitter.com/1.1/search/tweets.json";
		
		// 1. You need to visit the official Twitter developer site and register for a developer account. This is a free and necessary step to make requests for the v1.1 API.
		// 2. Create Access Tokens.
		
		// see here for more information: http://stackoverflow.com/questions/12916539/simplest-php-example-for-retrieving-user-timeline-with-twitter-api-version-1-1
		
		private var consumerKey:String = "";
		private var consumerSecret:String = "";
		private var accessKey:String = "";
		private var accessSecret:String = "";
		
		protected var signature:OAuthSignatureMethod_HMAC_SHA1 = new OAuthSignatureMethod_HMAC_SHA1();
		
		public function  TwitterSearch():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			search();
		}
		
		public function search():void
		{
			var consumer:OAuthConsumer = new OAuthConsumer(consumerKey, consumerSecret);
			var token:OAuthToken = new OAuthToken(accessKey, accessSecret);
			var variables:URLVariables = new URLVariables();
			variables.q = "baseball";
			var oauthRequest:OAuthRequest = new OAuthRequest("GET", Search, variables, consumer, token);
			var request:URLRequest = new URLRequest(oauthRequest.buildRequest(signature, OAuthRequest.RESULT_TYPE_URL_STRING));
			request.method = "GET";
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, verifyAccessTokenHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onTwitterIOError);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onTwitterHttpStatus);
			
			loader.load(request);
		}
		
		// Twitter IO Error
		private function onTwitterIOError(e:IOErrorEvent):void
		{
			trace("Tweet IOError!", e);
		}
		
		// Twitter HTTP Status Error
		private function onTwitterHttpStatus(e:HTTPStatusEvent):void
		{
			trace("Tweet HttpStatus!");
		}
		
		// Access Token Exists
		protected function verifyAccessTokenHandler(event:Event):void
		{
			trace("Valid Access Data Exists\n ", event.target.data);
		}
		
	}
	
}