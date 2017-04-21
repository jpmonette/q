/**
* QOrderTest is used to test QOrder logic
* @author  Jean-Philippe Monette
* @since   2017-03-29
*/
@isTest
private class QOrderTest {

	@isTest
	static void testConstructor() {
		String segment = new QOrder('Name').build();
		System.assertEquals('Name ASC', segment);
	}

	@isTest
	static void testAscending() {
		String segment = new QOrder('Name').ascending().build();
		System.assertEquals('Name ASC', segment);
	}

	@isTest
	static void testDescending() {
		String segment = new QOrder('Name').descending().build();
		System.assertEquals('Name DESC', segment);
	}

	@isTest
	static void testNullsFirst() {
		String segment = new QOrder('Name').nullsFirst().build();
		System.assertEquals('Name ASC NULLS FIRST', segment);
	}

	@isTest
	static void testNullsLast() {
		String segment = new QOrder('Name').nullsLast().build();
		System.assertEquals('Name ASC NULLS LAST', segment);
	}

}