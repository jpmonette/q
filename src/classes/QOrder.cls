public class QOrder {

	private static final String ASCENDING = 'ASC';
	private static final String DESCENDING = 'DESC';

	private String field;
	private String orderText = ASCENDING;
	private String nullsOrder = '';

	public QOrder(String field) {
		this.field = field;
	}

	public QOrder ascending() {
		this.orderText = ASCENDING;
		return this;
	}

	public QOrder descending() {
		this.orderText = DESCENDING;
		return this;
	}

	public QOrder nullsFirst() {
		this.nullsOrder = ' NULLS FIRST';
		return this;
	}

	public QOrder nullsLast() {
		this.nullsOrder = ' NULLS LAST';
		return this;
	}

	public String build() {
		return field + ' ' + orderText + nullsOrder;
	}
}