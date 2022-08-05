package no.lau;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.*;

import static no.lau.Treasury.init;
import static no.lau.Treasury.shareBagOfGems;
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
        Map<Integer, List<Integer>> first = shareBagOfGems(init(2), List.of(27, 20, 7) );
        assertEquals(first.size(), 2);
        assertEquals(27, first.get(0).get(0));
        assertEquals(20, first.get(1).get(0));
        assertEquals(7, first.get(1).get(1));

        shareBagOfGems(init(2), List.of( 20, 7, 27) );
        shareBagOfGems(init(2), List.of( 27, 7, 20) );


        WrongBranchException thrown = Assertions.assertThrows(WrongBranchException.class, () -> {
            shareBagOfGems(0, init(3), List.of(27, 7, 20));
        });
        Assertions.assertEquals("Lets try backing up further", thrown.getMessage());

    }


    @Test
    public void threeSeekers() {
        //shareBagOfGems(init(2), List.of(6, 2, 4, 3, 1));
        shareBagOfGems(init(2), List.of(6, 3, 2, 4, 1));
    }

    public void testOtherSeekers() {
        shareBagOfGems(init(1), List.of(6,3,2,4,1));



        WrongBranchException thrown = Assertions.assertThrows(WrongBranchException.class, () -> {
            shareBagOfGems(init(3), List.of(6,3,2,4,1) );
        });
        Assertions.assertEquals("Gave up", thrown.getMessage());

    }
}