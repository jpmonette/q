/**
* QTest is used to test Q logic
* @author  Jean-Philippe Monette
* @since   2017-03-21
*/
@isTest
private class QTest {

	@isTest
	static void testConstructor() {
		String query =
			new Q(Account.SObjectType)
				.build();

		System.assertEquals('SELECT Id FROM Account', query);
		Database.query(query);
	}

	@isTest
	static void testAddSubQuery() {
		String query =
			new Q(Account.SObjectType)
				.addSubquery(new Q('Contacts'))
				.build();

		System.assertEquals('SELECT (SELECT Id FROM Contacts) FROM Account', query);
		Database.query(query);
	}

	@isTest
	static void testSelectFields() {
		String query =
			new Q(Account.SObjectType)
				.selectFields(SObjectType.Account.fieldSets.Example)
				.build();

		System.assertEquals('SELECT CreatedById, Description, Owner.Email FROM Account', query);
		Database.query(query);
	}

	@isTest
	static void testAddOrders() {
		String query =
			new Q(Account.SObjectType)
				.add(Q.orderBy('Name').nullsLast())
				.add(Q.orderBy('BillingCountry').descending())
				.build();

		System.assertEquals('SELECT Id FROM Account ORDER BY Name ASC NULLS LAST, BillingCountry DESC', query);
		Database.query(query);
	}

	@isTest
	static void testAddCondition1() {
		String query =
			new Q(Account.SObjectType)
				.add(Q.condition('BillingCountry').isNotNull())
				.build();

		System.assertEquals('SELECT Id FROM Account WHERE BillingCountry != null', query);
		Database.query(query);
	}

	@isTest
	static void testAddCondition2() {
		String query =
			new Q(Account.SObjectType)
				.add(Q.condition('Name').isLike('%Acme%'))
				.build();

		System.assertEquals('SELECT Id FROM Account WHERE Name LIKE \'%Acme%\'', query);
		Database.query(query);
	}

	@isTest
	static void testAddLimit() {
		String query =
			new Q(Account.SObjectType)
				.addLimit(5)
				.build();

		System.assertEquals('SELECT Id FROM Account LIMIT 5', query);
		Database.query(query);
	}

	@isTest
	static void testAddOffset() {
		String query =
			new Q(Account.SObjectType)
				.addOffset(5)
				.build();

		System.assertEquals('SELECT Id FROM Account OFFSET 5', query);
		Database.query(query);
	}

}