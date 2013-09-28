import java.util.EventObject;


public class BoundingBoxClickEvent extends EventObject{

	private int eventType;
	
	public BoundingBoxClickEvent(Object e, int eventType) {
		super(e);
		this.eventType = eventType;
	}

}
