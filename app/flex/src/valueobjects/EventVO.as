package valueobjects
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	
	[Bindable]
	public class EventVO extends EventDispatcher
	{
		
		/** The user id of the employee, used to determine their email address. **/
		public var id : String;

		/** The first name of the employee. **/
		public var title : String;
		
		/** The last name of the employee. **/
		public var time : String;
		
		/** The display name of the employee. **/
		public var text : String;

		/** The display name of the employee. **/
		public var location_id : String;


		public var participants:ArrayCollection;

		public function EventVO(event:Object=null)
		{
			participants = new ArrayCollection();

			if(event==null)return;
			
			id = event.id;
			title = event.name;
			//time = "10:10";
			var timeString:String = event["starts-at"];
			var matches:Array = timeString.match("[0-9]{2}:[0-9]{2}:[0-9]{2}");
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "HH:NN"
			text = event.description;
			time = formatter.format(timeString);
			location_id = event["location-id"];
		}
		
		

	}
}