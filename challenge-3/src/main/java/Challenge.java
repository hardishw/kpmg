import java.util.*;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Challenge {

    private String[] keys;
    private JSONObject object;

    public JSONObject getObject() {
        return object;
    }

    public void setObject(JSONObject object) {
        this.object = object;
    }

    public String[] getKeys() {
        return keys;
    }

    public void setKeys(String[] keys) {
        this.keys = keys;
    }

    public String[] getKeyInput(){
        System.out.println("Please enter key: ");
        Scanner scan = new Scanner(System.in);
        String key = scan.next();
        return key.split("/");
    }

    public JSONObject getObjectInput() throws ParseException {
        JSONParser parser = new JSONParser();

        System.out.println("Please enter object: ");
        Scanner scan = new Scanner(System.in);
        Object object = parser.parse(scan.next());
        return (JSONObject) object;
    }

    public String getObjectValue(){
        Queue<String> queue = new LinkedList<String>(Arrays.asList(keys));
        return objectValue(queue,object);
    }

    private String objectValue(Queue<String> key, JSONObject object){
        String currnetKey = key.remove();

        if (key.isEmpty()){
            return (String) object.get(currnetKey);
        } else {
            object = (JSONObject) object.get(currnetKey);
            return objectValue(key,object);
        }
    }
}
