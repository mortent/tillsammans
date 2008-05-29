package model
{
	import event.ModelStateChangeEvent;
	
	import flash.events.EventDispatcher;
	
	import valueobjects.EventVO;

	[Event(name="modelStateChangeEvent", type="event.ModelStateChangeEvent")]

	
	public class ApplicationModel extends EventDispatcher 
	{
			
		public static const DEFAULT_STATE:String = "default";
		public static const DETAIL_STATE:String = "detail";
		private static var instance:ApplicationModel;
		private var _currentState:String;
		
		[Bindable]
		public var currentEventItem:EventVO;	
			
			
		/**
		 * Private constructor. Use getInstance() instead.
		 */
		public function ApplicationModel()
		{
			if ( instance != null )
			{
				throw new Error("Private constructor. Use getIntance() instead.");	
			}
			
			currentState = DEFAULT_STATE;
		}
			
		/**
		 * Get an instance of the DataManager.
		 */ 
		public static function getInstance() : ApplicationModel
		{
			if ( instance == null )
			{
				instance = new ApplicationModel();
			}
			return instance;
		}

		[Bindable("modelStateChangeEvent")]
		public function get currentState() : String
		{
			return _currentState;
		}

		public function set currentState( state:String ) : void
		{
			_currentState = state;
			dispatchEvent( new ModelStateChangeEvent() );
		}
	}
}