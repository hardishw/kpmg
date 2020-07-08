import junit.framework.*;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.util.Scanner;

public class ChallengeTest extends TestCase{

    public void testGetObjectValue() throws ParseException {
        Challenge challenge = new Challenge();
        JSONParser parser = new JSONParser();
        Object object;

        challenge.setKeys(new String[]{"a","b","c"});
        object = parser.parse("{\"a\":{\"b\":{\"c\":\"d\"}}}");
        challenge.setObject((JSONObject) object);

        assertEquals(challenge.getObjectValue(),"d");

        challenge.setKeys(new String[]{"r","b","c"});
        object = parser.parse("{\"r\":{\"b\":{\"c\":\"d\"}}}");
        challenge.setObject((JSONObject) object);

        assertEquals(challenge.getObjectValue(),"d");
    }
}
