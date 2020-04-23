/**
* Q is used to build SOQL statements
* @author  Jean-Philippe Monette
* @since   2017-03-21
*/
public class Q {

	private String fromText;
	private Integer numberOfRows;
	private Integer numberOfRowsToSkip;

	private Set<String> fieldList = new Set<String>();
	private Set<String> groupBy = new Set<String>();
	private List<QOrder> orders = new List<QOrder>();
	private List<QICondition> conditions = new List<QICondition>();
	private List<QICondition> havingConditions = new List<QICondition>();
	private List<Q> subQueries = new List<Q>();

	public Q(SObjectType fromType)	{ this.fromText = String.valueOf(fromType); }
	public Q(String fromText) 		{ this.fromText = fromText; }

	/*
	 * Instantiate an OrderBy object
	 */
	public static QOrder orderBy(String fieldName) {
		QOrder od = new QOrder(fieldName);
		return od;
	}

	/*
	 * Instantiate a Condition object
	 */
	public static QCondition condition(String fieldName) {
		QCondition cond = new QCondition(fieldName);
		return cond;
	}

	/*
	 * Instantiate a Distance object using location fields
	 */
	public static QDistance distance(String fromFieldName, String toFieldName, QDistance.Unit unit) {
		QDistance dist = new QDistance(fromFieldName, toFieldName, unit);
		return dist;
	}

	/*
	 * Instantiate a Distance object using lat/lon
	 */
	public static QDistance distance(String fromFieldName, Decimal lat, Decimal lon, QDistance.Unit unit) {
		QDistance dist = new QDistance(fromFieldName, lat, lon, unit);
		return dist;
	}

	/*
	 * Instantiate a DateLiteral object
	 */
	public static QDateLiteral dateLiteral(QDateLiteral.Value literal) {
		return dateLiteral(literal, null);
	}

	/*
	 * Instantiate a DateLiteral object
	 */
	public static QDateLiteral dateLiteral(QDateLiteral.Value literal, Integer value) {
		QDateLiteral dateLiteral = new QDateLiteral(literal, value);
		return dateLiteral;
	}

	/*
	 * Instantiate a BindVariable object
	 */
	public static QBindVariable bindVar(String bindVarName) {
		QBindVariable bindVar = new QBindVariable(bindVarName);
		return bindVar;
	}

	/*
	 * Add an OrderBy statement
	 */
	public Q add(QOrder ob) {
		this.orders.add(ob);
		return this;
	}

	/*
	 * Add a Condition statement
	 */
	public Q add(QICondition cnd) {
		this.conditions.add(cnd);
		return this;
	}

	/*
	 * Add an SELECT sub-query
	 */
	public Q addSubquery(Q qb) {
		this.subQueries.add(qb);
		return this;
	}

	/**
	 * Add fields to the SELECT statement from FieldSet
	 */
	public Q selectFields(Schema.FieldSet fs) {
		for(Schema.FieldSetMember field : fs.getFields()) {
			this.fieldList.add(field.getFieldPath());
		}
		return this;
	}

	/*
	 * Add fields to the SELECT statement from Set of Strings
	 */
	public Q selectFields(Set<String> fields) {
		for(String field : fields) {
			this.fieldList.add(field);
		}
		return this;
	}

	/*
	 * Add a GROUP BY statement
	 */
	public Q groupBy(String fieldName) {
		this.groupBy.add(fieldName);
		return this;
	}

	/*
	 * Add a GROUP BY statement
	 */
	public Q groupBy(Set<String> fieldNames) {
		this.groupBy.addAll(fieldNames);
		return this;
	}

	/*
	 * Add a HAVING condition statement
	 */
	public Q havingCondition(QICondition cnd) {
		this.havingConditions.add(cnd);
		return this;
	}

	/*
	 * Add a LIMIT statement
	 */
	public Q addLimit(Integer i) {
		this.numberOfRows = i;
		return this;
	}

	/*
	 * Add an OFFSET statement
	 */
	public Q addOffset(Integer i) {
		this.numberOfRowsToSkip = i;
		return this;
	}

	/*
     * Instantiate a parenthetical OR condition group
     */
    public static QConditionGroup orGroup() {
        QOrGroup orGroup = new QOrGroup();
        return orGroup;
    }

    /*
     * Instantiate a parenthetical AND condition group
     */
    public static QConditionGroup andGroup() {
        QAndGroup andGroup = new QAndGroup();
        return andGroup;
    }

	/*
	 * Build the SELECT statement
	 */
	public String buildSelect() {
		for (Q qb : this.subQueries) {
			this.fieldList.add('(' + qb.build() + ')');
		}

		if (!this.fieldList.isEmpty()) {
			return 'SELECT ' + String.join(new List<String>(this.fieldList), ', ');
		} else {
			return 'SELECT Id';
		}
	}

	/*
	 * Build the WHERE statement
	 */
	public String buildConditions() {
		List<String> condList = new List<String>();

		for (QICondition cond : this.conditions) {
			condList.add(cond.build());
		}

		if (!this.conditions.isEmpty()) {
			return 'WHERE ' + String.join(condList, ' AND ');
		} else {
			return null;
		}
	}

	/*
	 * Build the GROUP BY statement
	 */
	public String buildGroupBy() {
		if (!this.groupBy.isEmpty()) {
			return 'GROUP BY ' + String.join(new List<String>(this.groupBy), ', ');
		} else {
			return null;
		}
	}

	/*
	 * Build the HAVING statement
	 */
	public String buildHavingConditions() {
		List<String> condList = new List<String>();

		for (QICondition cond : this.havingConditions) {
			condList.add(cond.build());
		}

		if (!this.havingConditions.isEmpty()) {
			return 'HAVING ' + String.join(condList, ' AND ');
		} else {
			return null;
		}
	}

	/*
	 * Build the ORDER BY statement
	 */
	public String buildOrderBy() {
		List<String> orderList = new List<String>();

		for (QOrder order : this.orders) {
			orderList.add(order.build());
		}

		if (!this.orders.isEmpty()) {
			return 'ORDER BY ' + String.join(orderList, ', ');
		} else {
			return '';
		}

	}

	/*
	 * Build the SOQL query
	 */
	public String build() {
		List<String> queryParts = new List<String>();

		queryParts.add(this.buildSelect());
		queryParts.add('FROM ' + this.fromText);

		if (!this.conditions.isEmpty()) {
			queryParts.add(this.buildConditions());
		}

		if (!this.orders.isEmpty()) {
			queryParts.add(this.buildOrderBy());
		}

		if (!this.groupBy.isEmpty()) {
			queryParts.add(this.buildGroupBy());
		}

		if (!this.havingConditions.isEmpty()) {
			queryParts.add(this.buildHavingConditions());
		}

		if (this.numberOfRows != null) {
			queryParts.add('LIMIT ' + this.numberOfRows);
		}

		if (this.numberOfRowsToSkip != null) {
			queryParts.add('OFFSET ' + this.numberOfRowsToSkip);
		}

		return String.join(queryParts, ' ');
	}

}