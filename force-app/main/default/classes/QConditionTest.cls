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
		System.assertEquals('Name = \'Jean-Philippe Monette\'', segment, 'It should output an equal condition.');
	}

	@isTest
	static void testEqualsInteger() {
		String segment = new QCondition('Age').equalsTo(5).build();
		System.assertEquals('Age = 5', segment, 'It should output an equal integer condition.');
	}

	@isTest
	static void testNotEquals() {
		String segment = new QCondition('Name').notEqualsTo('Jean-Philippe Monette').build();
		System.assertEquals('Name != \'Jean-Philippe Monette\'', segment, 'It should output a not equal condition.');
	}

	@isTest
	static void testIsLessThan() {
		String segment = new QCondition('Age').isLessThan(5).build();
		System.assertEquals('Age < 5', segment, 'It should output a less than condition.');
	}

	@isTest
	static void testIsLessOrEquals() {
		String segment = new QCondition('Age').isLessOrEquals(5).build();
		System.assertEquals('Age <= 5', segment, 'It should output a less or equal condition.');
	}

	@isTest
	static void testIsGreaterThan() {
		String segment = new QCondition('Age').isGreaterThan(5).build();
		System.assertEquals('Age > 5', segment, 'It should output a greather than condition.');
	}

	@isTest
	static void testIsGreaterOrEquals() {
		String segment = new QCondition('Age').isGreaterOrEquals(5).build();
		System.assertEquals('Age >= 5', segment, 'It should output a greater or equal condition.');
	}

	@isTest
	static void testIsLike() {
		String segment = new QCondition('Name').isLike('%Acme%').build();
		System.assertEquals('Name LIKE \'%Acme%\'', segment, 'It should output a LIKE condition.');
	}

	@isTest
	static void testIsIn() {
		List<String> names = new List<String>{'John', 'Jane'};
		String segment = new QCondition('Name').isIn(names).build();
		System.assertEquals('Name IN (\'John\', \'Jane\')', segment, 'It should output an IN condition.');
	}

	@isTest
	static void testIsNotIn() {
		List<String> names = new List<String>{'John', 'Jane'};
		String segment = new QCondition('Name').isNotIn(names).build();
		System.assertEquals('Name NOT IN (\'John\', \'Jane\')', segment, 'It should output a NOT IN condition.');
	}

	@isTest
	static void testIncludes() {
		List<String> markets = new List<String>{'APAC', 'EMEA'};
		String segment = new QCondition('Market').includes(markets).build();
		System.assertEquals('Market INCLUDES (\'APAC\', \'EMEA\')', segment, 'It should output an INCLUDES condition.');
	}

	@isTest
	static void testExcludes() {
		List<String> markets = new List<String>{'APAC', 'EMEA'};
		String segment = new QCondition('Market').excludes(markets).build();
		System.assertEquals('Market EXCLUDES (\'APAC\', \'EMEA\')', segment, 'It should output a EXCLUDES condition.');
	}

	@isTest
	static void testIsNull() {
		String segment = new QCondition('Name').isNull().build();
		System.assertEquals('Name = null', segment, 'It should output an IS NULL condition.');
	}

	@isTest
	static void testIsNotNull() {
		String segment = new QCondition('Name').isNotNull().build();
		System.assertEquals('Name != null', segment, 'It should output a IS NOT NULL condition.');
	}

	@isTest
	static void testDistance() {
		String segment = new QDistance('BillingAddress').to('LocationField__c').isLessThan(20).build();
		String expected = 'DISTANCE(BillingAddress, LocationField__c, \'mi\') < 20';
		System.assertEquals(expected, segment, 'Segment should output a distance condition.');
	}

	@isTest
	static void testDistanceGreaterThan() {
		String segment = new QDistance('BillingAddress').to('LocationField__c').inKilometers().isGreaterThan(20).build();
		String expected = 'DISTANCE(BillingAddress, LocationField__c, \'km\') > 20';
		System.assertEquals(expected, segment, 'Segment should output a distance condition.');
	}

	@isTest
	static void testDistanceInMiles() {
		String segment = new QDistance('BillingAddress').to('LocationField__c').inMiles().isGreaterThan(20).build();
		string expected = 'DISTANCE(BillingAddress, LocationField__c, \'mi\') > 20';
		System.assertEquals(expected, segment, 'Segment should output a distance condition.');
	}

	@isTest
	static void testDistanceInvalidOperator() {
		String expected = '';
		try {
			String segment = new QDistance('BillingAddress').to('LocationField__c').equalsTo(20).build();
		} catch (QDistance.QDistanceException e) {
			expected = e.getMessage();
		}
		System.assertEquals(expected, 'Invalid operator. DISTANCE supports only the logical operators > and <', 'Should output an exception message.');
	}

	@isTest
	static void testDistanceToLocationNotSet() {
		String expected = '';
		try {
			String segment = new QDistance('BillingAddress').isLessThan(20).build();
		} catch (QDistance.QDistanceException e) {
			expected = e.getMessage();
		}
		System.assertEquals(expected, 'To location is not set. Call to() method to set up.', 'Should output an exception message.');
	}

	@isTest
	static void testDistanceLatLon() {
		String segment = new QDistance('BillingAddress').to(37.775, -122.418).isLessThan(20).build();
		String expected = 'DISTANCE(BillingAddress, GEOLOCATION(37.775, -122.418), \'mi\') < 20';
		System.assertEquals(expected, segment, 'Segment should output a distance condition.');
	}

}