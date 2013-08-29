
public class Pair<Key, Value> {
	public Key key;
	public Value value;

	
	@Override
	public String toString(){
		return key + "=" + value;
	}
	
	public Pair<Key, Value> clone(){
		Pair<Key, Value> temp = new Pair<Key, Value>();
		temp.key = this.key;
		temp.value = this.value;
		return temp;
	}
}
