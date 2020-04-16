/**
* QConditionTest is used to test QCondition logic
* @author  Jean-Philippe Monette
* @since   2017-04-21
*/
@isTest
private class QConditionTest {

	@isTest
	static void testEqualsString() {
		String segment = new QCondition('Name').equalsTo('Jean-Philippe Monette').build();
		System.assertEquals('Name = \'Jean-Philippe Monette\'', segment);
	}

	@isTest
	static void testEqualsInteger() {
		String segment = new QCondition('Age').equalsTo(5).build();
		System.assertEquals('Age = 5', segment);
	}

	@isTest
	static void testEqualsIntegerBindVar() {
		Integer ageVar = 5;
		String segment = new QCondition('Age').equalsTo(Q.bindVar(':ageVar')).build();
		System.assertEquals('Age = :ageVar', segment);
	}

	@isTest
	static void testNotEquals() {
		String segment = new QCondition('Name').notEqualsTo('Jean-Philippe Monette').build();
		System.assertEquals('Name != \'Jean-Philippe Monette\'', segment);
	}

	@isTest
	static void testIsLessThan() {
		String segment = new QCondition('Age').isLessThan(5).build();
		System.assertEquals('Age < 5', segment);
	}

	@isTest
	static void testIsLessOrEquals() {
		String segment = new QCondition('Age').isLessOrEquals(5).build();
		System.assertEquals('Age <= 5', segment);
	}

	@isTest
	static void testIsGreaterThan() {
		String segment = new QCondition('Age').isGreaterThan(5).build();
		System.assertEquals('Age > 5', segment);
	}

	@isTest
	static void testIsGreaterOrEquals() {
		String segment = new QCondition('Age').isGreaterOrEquals(5).build();
		System.assertEquals('Age >= 5', segment);
	}

	@isTest
	static void testIsLike() {
		String segment = new QCondition('Name').isLike('%Acme%').build();
		System.assertEquals('Name LIKE \'%Acme%\'', segment);
	}

	@isTest
	static void testIsIn() {
		List<String> names = new List<String>{'John', 'Jane'};
		String segment = new QCondition('Name').isIn(names).build();
		System.assertEquals('Name IN (\'John\', \'Jane\')', segment);
	}

	@isTest
	static void testIsInBindVar() {
		List<String> names = new List<String>{'John', 'Jane'};
		String segment = new QCondition('Name').isIn(Q.bindVar(':names')).build();
		System.assertEquals('Name IN :names', segment);
	}

	@isTest
	static void testIsNotIn() {
		List<String> names = new List<String>{'John', 'Jane'};
		String segment = new QCondition('Name').isNotIn(names).build();
		System.assertEquals('Name NOT IN (\'John\', \'Jane\')', segment);
	}

	@isTest
	static void testIsNotInBindVar() {
		List<String> names = new List<String>{'John', 'Jane'};
		String segment = new QCondition('Name').isNotIn(Q.bindVar(':names')).build();
		System.assertEquals('Name NOT IN :names', segment);
	}

	@isTest
	static void testIncludes() {
		List<String> markets = new List<String>{'APAC', 'EMEA'};
		String segment = new QCondition('Market').includes(markets).build();
		System.assertEquals('Market INCLUDES (\'APAC\', \'EMEA\')', segment);
	}

	@isTest
	static void testIncludesBindVar() {
		List<String> markets = new List<String>{'APAC', 'EMEA'};
		String segment = new QCondition('Market').includes(q.bindVar(':markets')).build();
		System.assertEquals('Market INCLUDES :markets', segment);
	}

	@isTest
	static void testExcludes() {
		List<String> markets = new List<String>{'APAC', 'EMEA'};
		String segment = new QCondition('Market').excludes(markets).build();
		System.assertEquals('Market EXCLUDES (\'APAC\', \'EMEA\')', segment);
	}

	@isTest
	static void testExcludesBindVar() {
		List<String> markets = new List<String>{'APAC', 'EMEA'};
		String segment = new QCondition('Market').excludes(q.bindVar(':markets')).build();
		System.assertEquals('Market EXCLUDES :markets', segment);
	}

	@isTest
	static void testIsNull() {
		String segment = new QCondition('Name').isNull().build();
		System.assertEquals('Name = null', segment);
	}

	@isTest
	static void testIsNotNull() {
		String segment = new QCondition('Name').isNotNull().build();
		System.assertEquals('Name != null', segment);
	}

}