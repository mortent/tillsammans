package event
{
	import flash.events.Event;

	public class ModelStateChangeEvent extends Event
	{
		public static const MODEL_STATE_CHANGE_EVENT:String = "modelStateChangeEvent";

		public function ModelStateChangeEvent()
		{
			super(MODEL_STATE_CHANGE_EVENT);
		}
		
	}
}