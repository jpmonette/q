public class Q {

	private String fromText;
	private Integer numberOfRows;
	private Integer numberOfRowsToSkip;

	private Set<String> fieldList = new Set<String>();
	private List<QOrder> orders = new List<QOrder>();
	private List<QCondition> conditions = new List<QCondition>();
	private List<Q> subQueries = new List<Q>();

	public Q() 						{}
	public Q(SObjectType fromType)	{ this.fromText = String.valueOf(fromType); }
	public Q(String fromText) 		{ this.fromText = fromText; }

	/**
	 * Instantiate an OrderBy object
	 */
	public static QOrder orderBy(String fieldName) {
		QOrder od = new QOrder(fieldName);
		return od;
	}

	/**
	 * Instantiate a Condition object
	 */
	public static QCondition condition(String fieldName) {
		QCondition cond = new QCondition(fieldName);
		return cond;
	}

	/**
	 * Add an OrderBy statement
	 */
	public Q add(QOrder ob) {
		this.orders.add(ob);
		return this;
	}

	/**
	 * Add a Condition statement
	 */
	public Q add(QCondition cnd) {
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

		for (QOrder order : this.orders) {
			orderList.add(order.build());
		}

		if (!this.orders.isEmpty()) {
			query += ' ORDER BY ' + String.join(orderList, ', ');
		}

		// Conditions
		List<String> condList = new List<String>();

		for (QCondition cond : this.conditions) {
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

}
