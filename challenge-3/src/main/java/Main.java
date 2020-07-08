import org.json.simple.parser.ParseException;

import java.sql.Array;
import java.util.Arrays;

public class Main {
    public static void main(String[] args){
        Challenge challenge = new Challenge();
        challenge.setKeys(challenge.getKeyInput());
        try {
            challenge.setObject(challenge.getObjectInput());
            System.out.println(challenge.getObjectValue());
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
