package valueobjects
{
	import flash.events.EventDispatcher;
	
	public class EmployeeVO extends EventDispatcher
	{
		
		/** The user id of the employee, used to determine their email address. **/
		public var id : String;

		/** The first name of the employee. **/
		public var firstName : String;
		
		/** The last name of the employee. **/
		public var lastName : String;
		
		/** The display name of the employee. **/
		public var displayName : String;

		/** The display name of the employee. **/
		public var imageUrl : String;
		
		/** The display name of the employee. **/
		public var location : String;
		
		public var status : String;
		
		public function EmployeeVO(emp:Object=null)
		{
			if(emp==null)return;
			
			
			id = emp.id;
			firstName = emp.firstName;
			lastName = emp.lastName;
			displayName = emp.displayName;
			imageUrl = emp.imageUrl;
			location = emp.location;
			status = emp.status;
					
		}
		
	}
}