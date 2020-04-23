/**
* QOrderTest is used to test QOrder logic
* @author  Jean-Philippe Monette
* @since   2017-03-29
*/
@IsTest
private class QOrderTest {

    @IsTest
    static void testConstructor() {
        String segment = new QOrder('Name').build();
        System.assertEquals('Name ASC', segment);
    }

    @IsTest
    static void testAscending() {
        String segment = new QOrder('Name').ascending().build();
        System.assertEquals('Name ASC', segment);
    }

    @IsTest
    static void testDescending() {
        String segment = new QOrder('Name').descending().build();
        System.assertEquals('Name DESC', segment);
    }

    @IsTest
    static void testNullsFirst() {
        String segment = new QOrder('Name').nullsFirst().build();
        System.assertEquals('Name ASC NULLS FIRST', segment);
    }

    @IsTest
    static void testNullsLast() {
        String segment = new QOrder('Name').nullsLast().build();
        System.assertEquals('Name ASC NULLS LAST', segment);
    }

}