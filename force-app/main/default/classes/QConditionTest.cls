/**
* QConditionTest is used to test QCondition logic
* @author  Jean-Philippe Monette
* @since   2017-04-21
*/
@IsTest
private class QConditionTest {

    @IsTest
    static void testEqualsString() {
        String segment = new QCondition('Name').isEqualTo('Jean-Philippe Monette').build();
        System.assertEquals('Name = \'Jean-Philippe Monette\'', segment);
    }

    @IsTest
    static void testEqualsInteger() {
        String segment = new QCondition('Age').isEqualTo(5).build();
        System.assertEquals('Age = 5', segment);
    }

    @IsTest
    static void testEqualsIntegerBindVar() {
        Integer ageVar = 5;
        String segment = new QCondition('Age').isEqualTo(Q.bindVar(':ageVar')).build();
        System.assertEquals('Age = :ageVar', segment);
    }

    @IsTest
    static void testNotEquals() {
        String segment = new QCondition('Name').isNotEqualTo('Jean-Philippe Monette').build();
        System.assertEquals('Name != \'Jean-Philippe Monette\'', segment);
    }

    @IsTest
    static void testIsLessThan() {
        String segment = new QCondition('Age').isLessThan(5).build();
        System.assertEquals('Age < 5', segment);
    }

    @IsTest
    static void testIsLessOrEquals() {
        String segment = new QCondition('Age').isLessOrEquals(5).build();
        System.assertEquals('Age <= 5', segment);
    }

    @IsTest
    static void testIsGreaterThan() {
        String segment = new QCondition('Age').isGreaterThan(5).build();
        System.assertEquals('Age > 5', segment);
    }

    @IsTest
    static void testIsGreaterOrEquals() {
        String segment = new QCondition('Age').isGreaterOrEquals(5).build();
        System.assertEquals('Age >= 5', segment);
    }

    @IsTest
    static void testIsLike() {
        String segment = new QCondition('Name').isLike('%Acme%').build();
        System.assertEquals('Name LIKE \'%Acme%\'', segment);
    }

    @IsTest
    static void testIsIn() {
        List<String> names = new List<String>{'John', 'Jane'};
        String segment = new QCondition('Name').isIn(names).build();
        System.assertEquals('Name IN (\'John\', \'Jane\')', segment);
    }

    @IsTest
    static void testIsInBindVar() {
        List<String> names = new List<String>{'John', 'Jane'};
        String segment = new QCondition('Name').isIn(Q.bindVar(':names')).build();
        System.assertEquals('Name IN :names', segment);
    }

    @IsTest
    static void testIsNotIn() {
        List<String> names = new List<String>{'John', 'Jane'};
        String segment = new QCondition('Name').isNotIn(names).build();
        System.assertEquals('Name NOT IN (\'John\', \'Jane\')', segment);
    }

    @IsTest
    static void testIsNotInBindVar() {
        List<String> names = new List<String>{'John', 'Jane'};
        String segment = new QCondition('Name').isNotIn(Q.bindVar(':names')).build();
        System.assertEquals('Name NOT IN :names', segment);
    }

    @IsTest
    static void testIncludes() {
        List<String> markets = new List<String>{'APAC', 'EMEA'};
        String segment = new QCondition('Market').includes(markets).build();
        System.assertEquals('Market INCLUDES (\'APAC\', \'EMEA\')', segment);
    }

    @IsTest
    static void testIncludesBindVar() {
        List<String> markets = new List<String>{'APAC', 'EMEA'};
        String segment = new QCondition('Market').includes(q.bindVar(':markets')).build();
        System.assertEquals('Market INCLUDES :markets', segment);
    }

    @IsTest
    static void testExcludes() {
        List<String> markets = new List<String>{'APAC', 'EMEA'};
        String segment = new QCondition('Market').excludes(markets).build();
        System.assertEquals('Market EXCLUDES (\'APAC\', \'EMEA\')', segment);
    }

    @IsTest
    static void testExcludesBindVar() {
        List<String> markets = new List<String>{'APAC', 'EMEA'};
        String segment = new QCondition('Market').excludes(q.bindVar(':markets')).build();
        System.assertEquals('Market EXCLUDES :markets', segment);
    }

    @IsTest
    static void testIsNull() {
        String segment = new QCondition('Name').isNull().build();
        System.assertEquals('Name = null', segment);
    }

    @IsTest
    static void testIsNotNull() {
        String segment = new QCondition('Name').isNotNull().build();
        System.assertEquals('Name != null', segment);
    }

    @IsTest
    static void testDateLiteral() {
        String segment = new QCondition('CreatedDate').isEqualTo(Q.dateLiteral(QDateLiteral.Value.LAST_N_DAYS, 7)).build();
        System.assertEquals('CreatedDate = LAST_N_DAYS:7', segment);

        segment = new QCondition('CreatedDate').isEqualTo(Q.dateLiteral(QDateLiteral.Value.YESTERDAY)).build();
        System.assertEquals('CreatedDate = YESTERDAY', segment);
    }

    @IsTest
    static void testEmptyConditions() {
        String query = new Q(Account.SObjectType).buildConditions();

        System.assertEquals(null, query);
    }

    @IsTest
    static void testEmptyGroupBy() {
        String query = new Q(Account.SObjectType).buildGroupBy();

        System.assertEquals(null, query);
    }

    @IsTest
    static void testEmptyOrderBy() {
        String query = new Q(Account.SObjectType).buildOrderBy();

        System.assertEquals('', query);
    }
  
    @isTest
	  static void testDistance() {
		    String segment = new QDistance('BillingAddress', 'LocationField__c', QDistance.Unit.mi).isLessThan(20).build();
		    System.assertEquals('DISTANCE(BillingAddress, LocationField__c, \'mi\') < 20', segment);
	  }

	  @isTest
	  static void testDistanceGreaterThan() {
		    String segment = new QDistance('BillingAddress', 'LocationField__c', QDistance.Unit.mi).isGreaterThan(20).build();
		    System.assertEquals('DISTANCE(BillingAddress, LocationField__c, \'mi\') > 20', segment);
	  }

	  @isTest
	  static void testDistanceInvalidOperator() {
		    Boolean exceptionThrown = false;
		    try {
			      String segment = new QDistance('BillingAddress', 'LocationField__c', QDistance.Unit.mi).equalsTo(20).build();
		    } catch (QDistance.QDistanceException e) {
			      exceptionThrown = true;
		    }
		    System.assertEquals(true, exceptionThrown);
	  }

	  @isTest
    static void testDistanceLatLon() {
		    String segment = new QDistance('BillingAddress', 37.775, -122.418, QDistance.Unit.mi).isLessThan(20).build();
		    System.assertEquals('DISTANCE(BillingAddress, GEOLOCATION(37.775, -122.418), \'mi\') < 20', segment);
	  }    

}