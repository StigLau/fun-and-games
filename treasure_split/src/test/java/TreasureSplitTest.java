import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TreasureSplitTest {

    @Test
    public void testFirstVersion() {
        Map<Integer, List<Integer>> result = doStuff(3, List.of(4, 4, 4) );

        //Assume bag is sorted

        assertEquals(result.size(), 3);
        assertEquals(4, result.get(0).get(0));
        assertEquals(4, result.get(1).get(0));
        assertEquals(4, result.get(2).get(0));

    }

    public Map<Integer, List<Integer>> doStuff(int nrOfHunters, List<Integer> gems) {
        //Initialize
        Map<Integer, List<Integer>> result = new HashMap<>();
        for (int i = 0; i < nrOfHunters; i++) {
            result.put(i, new ArrayList<>());
        }

        //Compute
        int hunterRef = 0;
        for (Integer gem : gems) {
            result.get(hunterRef).add(gem);

            if(hunterRef < result.size()) {
                hunterRef++;
            } else {
                hunterRef = 0;
            }
        }
        return result;
    }
}
