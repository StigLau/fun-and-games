package no.lau;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class TreasuryV2 {

    public static List<List<Integer>> shareGems(int nrOfHunters, List<Integer> gems) {
        Integer allGems = calculatePouchContents(gems);
        Integer individualPouchSize = allGems / nrOfHunters;

        List<Integer> reverseSortedGems = new ArrayList<>(gems);
        Collections.sort(reverseSortedGems, Collections.reverseOrder());

        List<List<Integer>> rez = shareGems(individualPouchSize, gems);
        if(!isLegalResult(rez))
            throw new RuntimeException("Bollocks");
        else
            return rez;
    }

    private static List<List<Integer>> shareGems(Integer pouchSize, List<Integer> gems) {
        List<Integer> hunter = new ArrayList<>();

        int pouchSizeToFill = pouchSize;
        List<Integer> gemsAfterTakeout = new ArrayList<>();

        for (Integer gem : gems) {
            if (pouchSizeToFill >= gem) {
                pouchSizeToFill -= gem;
                hunter.add(gem);
            } else {
                gemsAfterTakeout.add(gem);
            }
        }
        List<List<Integer>> all = new ArrayList<>();
        all.add(hunter);
        if (gemsAfterTakeout.size() > 0) {
            all.addAll(shareGems(pouchSize, gemsAfterTakeout));
        }
        return all;
    }

    private static boolean isLegalResult(List<List<Integer>> result) throws WrongBranchException {
        Integer compareToPouch = null;
        for (List<Integer> pouch : result) {
            Integer thisPouch = calculatePouchContents(pouch);
            if(compareToPouch == null) {
                compareToPouch = thisPouch;
            } else if(!thisPouch.equals(compareToPouch)) {
                throw new WrongBranchException("Pouches were different");
            }
        }
        //Verify if pouches are equal
        return true;
    }

    private static Integer calculatePouchContents(List<Integer> puu) {
        return puu.stream().reduce(Integer::sum).get();
    }
}
