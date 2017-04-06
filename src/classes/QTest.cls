@isTest
private class QTest {

	@isTest
	static void it_should_generate_query() {
		String query = 
			new Q(Account.SObjectType)
				.build();

		System.assertEquals('SELECT Id FROM Account', query);
		Database.query(query);
	}

	@isTest
	static void it_should_generate_query_with_sub_query() {
		String query = 
			new Q(Account.SObjectType)
				.addSubquery(new Q('Contacts'))
				.build();

		System.assertEquals('SELECT (SELECT Id FROM Contacts) FROM Account', query);
		Database.query(query);
	}

	@isTest
	static void it_should_generate_query_with_fieldset() {
		String query = 
			new Q(Account.SObjectType)
				.selectFields(SObjectType.Account.fieldSets.Example)
				.build();

		System.assertEquals('SELECT CreatedById, Description, Owner.Email FROM Account', query);
		Database.query(query);
	}

	@isTest
	static void it_should_generate_query_with_multiple_order_by() {
		String query =
			new Q(Account.SObjectType)
				.add(Q.orderBy('Name').nullsLast())
				.add(Q.orderBy('BillingCountry').descending())
				.build();

		System.assertEquals('SELECT Id FROM Account ORDER BY Name ASC NULLS LAST, BillingCountry DESC', query);
		Database.query(query);
	}

	@isTest
	static void it_should_generate_query_with_condition_is_not_null() {
		String query =
			new Q(Account.SObjectType)
				.add(Q.condition('BillingCountry').isNotNull())
				.build();

		System.assertEquals('SELECT Id FROM Account WHERE BillingCountry != null', query);
		Database.query(query);
	}

	@isTest
	static void it_should_generate_query_with_condition_like() {
		String query =
			new Q(Account.SObjectType)
				.add(Q.condition('Name').isLike('%Acme%'))
				.build();

		System.assertEquals('SELECT Id FROM Account WHERE Name LIKE \'%Acme%\'', query);
		Database.query(query);
	}

	@isTest
	static void it_should_generate_query_with_limit() {
		String query =
			new Q(Account.SObjectType)
				.addLimit(5)
				.build();

		System.assertEquals('SELECT Id FROM Account LIMIT 5', query);
		Database.query(query);
	}

	@isTest
	static void it_should_generate_query_with_offset() {
		String query =
			new Q(Account.SObjectType)
				.addOffset(5)
				.build();

		System.assertEquals('SELECT Id FROM Account OFFSET 5', query);
		Database.query(query);
	}

}