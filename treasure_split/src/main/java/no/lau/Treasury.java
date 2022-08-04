package no.lau;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Treasury {

    public static Map<Integer, List<Integer>> shareBagOfGems(int hunterRef, Map<Integer, List<Integer>> original, List<Integer> gems) throws WrongBranchException {

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

    private static Map<Integer, List<Integer>> deepCopy(Map<Integer, List<Integer>> original) {
        Map<Integer, List<Integer>> copy = new HashMap<>();
        for (Map.Entry<Integer, List<Integer>> integerListEntry : original.entrySet()) {
            List<Integer> nuList = new ArrayList<>();
            nuList.addAll(integerListEntry.getValue());
            copy.put(integerListEntry.getKey(), nuList);
        }
        return copy;
    }

    private static boolean isLegalResult(Map<Integer, List<Integer>> result) throws WrongBranchException {
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

    public static Map<Integer, List<Integer>> init(int nrOfHunters) {
        //Initialize
        Map<Integer, List<Integer>> result = new HashMap<>();
        for (int i = 0; i < nrOfHunters; i++) {
            result.put(i, new ArrayList<>());
        }
        return result;
    }
}

class WrongBranchException extends RuntimeException {

    public WrongBranchException(String message) {
        super(message);
    }
}