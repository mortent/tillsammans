package valueobjects
{
	import flash.events.EventDispatcher;
	
	public class UserVO extends EventDispatcher
	{
		
		public var login : String;
		public var firstName : String;
		public var lastName : String;
		public var displayName : String;
		public var imageUrl : String;
		public var location : String;
		public var status : String;
		
		public function UserVO(user:Object=null)
		{
			if(user==null)return;
			
			login = user.login;
			location = user.location;
			status = "Jeg er med";
			
			/*id = user.id;
			firstName = user.firstName;
			lastName = user.lastName;
			displayName = user.displayName;
			imageUrl = user.imageUrl;
			location = user.location;*/			
					
		}
		
	}
}