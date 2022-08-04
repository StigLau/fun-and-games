package no.lau;

import org.junit.jupiter.api.Test;

import java.util.*;

import static no.lau.Treasury.init;
import static no.lau.Treasury.shareBagOfGems;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class TreasureSplitTest {

    @Test
    public void testFirstVersion() {
        Map<Integer, List<Integer>> result = shareBagOfGems(0, init(3), List.of(4, 4, 4) );
        //Assume bag is sorted
        assertEquals(result.size(), 3);
        assertEquals(4, result.get(0).get(0));
        assertEquals(4, result.get(1).get(0));
        assertEquals(4, result.get(2).get(0));
    }

    @Test
    public void twoSeekerDilemma() {
        //Map<Integer, List<Integer>> result = doStuff(init(2), List.of(27, 7, 20) );
        Map<Integer, List<Integer>> result = shareBagOfGems(0, init(2), List.of(27, 20, 7) );
        assertEquals(result.size(), 2);
        assertEquals(27, result.get(0).get(0));
        assertEquals(20, result.get(1).get(0));
        assertEquals(7, result.get(1).get(1));

        shareBagOfGems(0, init(2), List.of( 20, 7, 27) );
        shareBagOfGems(0, init(2), List.of( 27, 7, 20) );
    }
}