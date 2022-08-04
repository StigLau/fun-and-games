import org.junit.jupiter.api.Test;

import java.util.*;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TreasureSplitTest {

    @Test
    public void testFirstVersion() throws WrongBranchException {
        Map<Integer, List<Integer>> result = shareBagOfGems(0, init(3), List.of(4, 4, 4) );
        //Assume bag is sorted
        assertEquals(result.size(), 3);
        assertEquals(4, result.get(0).get(0));
        assertEquals(4, result.get(1).get(0));
        assertEquals(4, result.get(2).get(0));
    }

    @Test
    public void twoSeekerDilemma() throws WrongBranchException {
        //Map<Integer, List<Integer>> result = doStuff(init(2), List.of(27, 7, 20) );
        Map<Integer, List<Integer>> result = shareBagOfGems(0, init(2), List.of(27, 20, 7) );
        assertEquals(result.size(), 2);
        assertEquals(27, result.get(0).get(0));
        assertEquals(20, result.get(1).get(0));
        assertEquals(7, result.get(1).get(1));

        shareBagOfGems(0, init(2), List.of( 20, 7, 27) );
        shareBagOfGems(0, init(2), List.of( 27, 7, 20) );
    }


    public Map<Integer, List<Integer>> shareBagOfGems(int hunterRef, Map<Integer, List<Integer>> original, List<Integer> gems) throws WrongBranchException {

        Map<Integer, List<Integer>> result = deepCopy(original);

        if(gems.size() == 0) {
            if(isLegalResult(result))
                return result;
        }

        for (Integer gem : gems) {

            List<Integer> pouch = result.get(hunterRef);
            pouch.add(gem);

            try {
                List<Integer> nuiGems = gems.subList(1, gems.size());
                return shareBagOfGems(hunterRef, result, nuiGems);
            } catch (Exception wrongBranch) {
                //Try with next hunter
                if(hunterRef < result.size() -1) {
                    hunterRef++;
                } else {
                    throw new WrongBranchException("Lets try backing up further");
                    //hunterRef = 0;
                }
                return shareBagOfGems(hunterRef, original, gems);
            }
        }
        return result;
    }

    private Map<Integer, List<Integer>> deepCopy(Map<Integer, List<Integer>> original) {
        Map<Integer, List<Integer>> copy = new HashMap<>();
        for (Map.Entry<Integer, List<Integer>> integerListEntry : original.entrySet()) {
            List<Integer> nuList = new ArrayList<>();
            nuList.addAll(integerListEntry.getValue());
            copy.put(integerListEntry.getKey(), nuList);
        }
        return copy;
    }

    private boolean isLegalResult(Map<Integer, List<Integer>> result) throws WrongBranchException {
        Integer compareToPouch = null;
        for (Integer key : result.keySet()) {
            Integer thisPouch = result.get(key).stream().reduce(Integer::sum).get();
            if(compareToPouch == null) {
                compareToPouch = thisPouch;
            } else if(!thisPouch.equals(compareToPouch)) {
                throw new WrongBranchException("Pouches were different");
            }
        }
        //Verify if pouches are equal
        return true;
    }

    Map<Integer, List<Integer>> init(int nrOfHunters) {
        //Initialize
        Map<Integer, List<Integer>> result = new HashMap<>();
        for (int i = 0; i < nrOfHunters; i++) {
            result.put(i, new ArrayList<>());
        }
        return result;
    }
}


class WrongBranchException extends Exception {

    public WrongBranchException(String message) {
        super(message);
    }
}