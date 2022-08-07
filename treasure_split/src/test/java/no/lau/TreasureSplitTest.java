package no.lau;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.*;

import static no.lau.Treasury.*;
import static no.lau.TreasuryV2.shareGems;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class TreasureSplitTest {

    @Test
    public void testFirstVersion() {
        Map<Integer, List<Integer>> result = shareBagOfGems(init(3), List.of(4, 4, 4) );
        //Assume bag is sorted
        assertEquals(result.size(), 3);
        assertEquals(4, result.get(0).get(0));
        assertEquals(4, result.get(1).get(0));
        assertEquals(4, result.get(2).get(0));
    }

    @Test
    public void twoSeekerDilemma() {
        //Map<Integer, List<Integer>> result = doStuff(init(2), List.of(27, 7, 20) );
        List<List<Integer>> first = shareGems(2, List.of(27, 20, 7) );
        assertEquals(first.size(), 2);
        assertEquals(27, first.get(0).get(0));
        assertEquals(20, first.get(1).get(0));
        assertEquals(7, first.get(1).get(1));

        shareGems(2, List.of( 20, 7, 27) );
        shareGems(2, List.of( 27, 7, 20) );


        WrongBranchException thrown = Assertions.assertThrows(WrongBranchException.class, () -> {
            shareBagOfGems(0, init(3), List.of(27, 7, 20));
        });
        Assertions.assertEquals("Lets try backing up further", thrown.getMessage());
    }


    @Test
    public void threeSeekers() {
        shareGems(2, List.of(6, 3, 2, 4, 1));
    }

    @Test
    public void fourHunters() {
        shareGems(4, List.of(3,2,7,7,14,5,3,4,9,2));
    }

    @Test
    public void testOtherSeekers() {
        List<List<Integer>> one = shareGems(1, List.of(3,3,3,3,2,2,2,2,2,2,2,2));
        List<List<Integer>> two = shareGems(2, List.of(3,3,3,3,2,2,2,2,2,2,2,2));
        RuntimeException notThree = Assertions.assertThrows(WrongBranchException.class, () -> {
                    List<List<Integer>> three = shareGems(3, List.of(3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2));
                });
        //Here we see that we need to backtrack and try different option
        List<List<Integer>> four = shareGems(4, List.of(3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2));
    }
}