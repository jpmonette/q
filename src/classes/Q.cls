public class Q {

	private String fromText;
	private Integer numberOfRows;
	private Integer numberOfRowsToSkip;

	private Set<String> fieldList = new Set<String>();
	private List<OrderBy> orders = new List<OrderBy>();
	private List<Condition> conditions = new List<Condition>();
	private List<Q> subQueries = new List<Q>();

	private static final String ASCENDING = 'ASC';
	private static final String DESCENDING = 'DESC';

	public Q(SObjectType fromType)	{ this.fromText = String.valueOf(fromType); }
	public Q(String fromText) 		{ this.fromText = fromText; }

	/**
	 * Instantiate an OrderBy object
	 */
	public static OrderBy orderBy(String fieldName) {
		OrderBy od = new OrderBy(fieldName);
		return od;
	}

	/**
	 * Instantiate a Condition object
	 */
	public static Condition condition(String fieldName) {
		Condition cond = new Condition(fieldName);
		return cond;
	}

	/**
	 * Add an OrderBy statement
	 */
	public Q add(OrderBy ob) {
		this.orders.add(ob);
		return this;
	}

	/**
	 * Add a Condition statement
	 */
	public Q add(Condition cnd) {
		this.conditions.add(cnd);
		return this;
	}

	/**
	 * Add an SELECT sub-query
	 */
	public Q addSubquery(Q qb) {
		this.subQueries.add(qb);
		return this;
	}

	/**
	 * Add fields to the SELECT statement
	 */
	public Q selectFields(Schema.FieldSet fs) {
		for(Schema.FieldSetMember field : fs.getFields()) {
			this.fieldList.add(field.getFieldPath());
		}
		return this;
	}

	/**
	 * Add a LIMIT statement
	 */
	public Q addLimit(Integer i) {
		this.numberOfRows = i;
		return this;
	}

	/**
	 * Add an OFFSET statement
	 */
	public Q addOffset(Integer i) {
		this.numberOfRowsToSkip = i;
		return this;
	}

	/**
	 * Return SOQL Q
	 * @return String
	 * @access public
	 */
	public String toSOQL() {
		String query = 'SELECT Id ';

		for (Q qb : this.subQueries) {
			this.fieldList.add('(' + qb.toSOQL() + ')');
		}

		if (!this.fieldList.isEmpty()) {
			query = 'SELECT ' + String.join(new List<String>(this.fieldList), ', ') + ' ';
		}

		query += 'FROM ' + this.fromText;

		// Order
		List<String> orderList = new List<String>();

		for (OrderBy order : this.orders) {
			orderList.add(order.build());
		}

		if (!this.orders.isEmpty()) {
			query += ' ORDER BY ' + String.join(orderList, ', ');
		}

		// Conditions
		List<String> condList = new List<String>();

		for (Condition cond : this.conditions) {
			condList.add(cond.build());
		}

		if (!this.conditions.isEmpty()) {
			query += ' WHERE ' + String.join(condList, ' AND ');
		}

		if (this.numberOfRows != null) {
			query += ' LIMIT ' + this.numberOfRows;
		}

		if (this.numberOfRowsToSkip != null) {
			query += ' OFFSET ' + this.numberOfRowsToSkip;
		}

		return query;
	}

	public class OrderBy {

		private String field;
		private String orderText = ASCENDING;
		private String nullsOrder = '';

		public OrderBy(String field) {
			this.field = field;
		}

		public OrderBy ascending() {
			this.orderText = ASCENDING;
			return this;
		}

		public OrderBy descending() {
			this.orderText = DESCENDING;
			return this;
		}

		public OrderBy nullsFirst() {
			this.nullsOrder = ' NULLS FIRST';
			return this;
		}

		public OrderBy nullsLast() {
			this.nullsOrder = ' NULLS LAST';
			return this;
		}

		public String build() {
			return field + ' ' + orderText + nullsOrder;
		}
	}

	public class Condition {

		private String field {
			private get;
			private set { field = String.escapeSingleQuotes(value); }
		}
		private String value {
			private get;
			private set { field = String.escapeSingleQuotes(value); }
		}
		private Boolean isNotNull = false;
		private Boolean isLike = false;

		public Condition(String field) {
			this.field = field;
		}

		public Condition isNotNull() {
			this.isNotNull = true;
			return this;
		}

		public Condition isLike(String value) {
			this.value = value;
			this.isLike = true;
			return this;
		}

		public String build() {
			if (isNotNull) {
				return field + ' != null';
			} else if (isLike) {
				return field + ' LIKE \'' + value + '\'';
			} else {
				return '';
			}
		}

	}

}
