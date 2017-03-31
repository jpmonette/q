public class QCondition {

	private String field {
		private get;
		private set { field = String.escapeSingleQuotes(value); }
	}

	private String fieldValue {
		private get;
		private set { fieldValue = String.escapeSingleQuotes(value); }
	}
	
	private Boolean isNotNull = false;
	private Boolean isLike = false;

	public QCondition(String field) {
		this.field = field;
	}

	public QCondition isNotNull() {
		this.isNotNull = true;
		return this;
	}

	public QCondition isLike(String value) {
		this.fieldValue = value;
		this.isLike = true;
		return this;
	}

	public String build() {
		if (isNotNull) {
			return field + ' != null';
		} else if (isLike) {
			return field + ' LIKE \'' + fieldValue + '\'';
		} else {
			return '';
		}
	}

}